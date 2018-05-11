import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
const platform = const MethodChannel('masterlogin/code');


Future<String> getToken(String domain, String clientId, String appSecret) async {

  final String code = await platform.invokeMethod('getCode');
  final http.Response response = await http.post(
      "https://$domain/oauth/token",
      body: {"client_id": clientId, "redirect_uri": "com.google.codelabs.appauth://oauth2callback", "client_secret": appSecret,
        "code": code, "grant_type": "authorization_code"});

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