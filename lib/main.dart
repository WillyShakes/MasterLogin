import 'package:flutter/material.dart';
import 'package:masterlogin/Add/add_view.dart';
import 'package:masterlogin/Login/login_view.dart';

void main() =>runApp(
    new MaterialApp(
      title: 'Master Login',
      theme: new ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new LoginPage(),
      routes: <String, WidgetBuilder> {
        '/add': (BuildContext context) => new AddQuote(),
      },
    )
);

