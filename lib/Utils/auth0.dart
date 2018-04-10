import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<String> getToken(String domain, String clientId, String appSecret) async {
  String result = "";
  Stream<String> onCode = await _server();
  String url =
      "https://$domain/authorize?&response_type=code&client_id=$clientId&redirect_uri=http://localhost:8585&state=STATE";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  flutterWebviewPlugin.launch(url);
  final String code = await onCode.first;
  final http.Response response = await http.post(
      "https://$domain/oauth/token",
      body: {"client_id": clientId, "redirect_uri": "http://localhost:8585", "client_secret": appSecret,
        "code": code, "grant_type": "authorization_code"});
  flutterWebviewPlugin.close();
  Token t = new Token.fromMap(JSON.decode(response.body));
  print("access_token: "+t.access_token);
  print("token_type: "+t.token_type);

  final http.Response res = await http.get(
      "https://us-central1-flutter-quotes.cloudfunctions.net/api/delegate/firebase",
      headers: {HttpHeaders.AUTHORIZATION: "Bearer "+t.access_token});

  String jwt = res.body;
  print("jwt: "+jwt);

  return _auth.signInWithCustomToken(token: jwt).then((u){
    print("firebase user: "+u.toString());
    return "success";
  }).catchError((e){
    print("error: "+e.toString());
    return e.toString();
  });
}

Future<Stream<String>> _server() async {
  final StreamController<String> onCode = new StreamController();
  HttpServer server =
  await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8585);
  server.listen((HttpRequest request) async {
    final String code = request.uri.queryParameters["code"];
    request.response
      ..statusCode = 200
      ..headers.set("Content-Type", ContentType.HTML.mimeType)
      ..write("<html><h1>You can now close this window</h1></html>");
    await request.response.close();
    await server.close(force: true);
    onCode.add(code);
    await onCode.close();
  });
  return onCode.stream;
}



class Token {
  String access_token;
  String refresh_token;
  String id_token;
  String token_type;
  int expires_in;

  Token.fromMap(Map json){
    access_token = json['access_token'];
    refresh_token = json['refresh_token'];
    id_token = json['id_token'];
    token_type = json['token_type'];
    expires_in = json['expires_in'];
  }
}

