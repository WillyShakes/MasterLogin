import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masterlogin/Data/Quote.dart';
import 'package:masterlogin/Login/login_presenter.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';


class LoginPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text("Flutter Quotes"),
        ),
        body: new LoginScreen(_scaffoldKey)
    );
  }

}


///
///   Contact List
///

class LoginScreen extends StatefulWidget{
  GlobalKey<ScaffoldState> skey;

  LoginScreen(GlobalKey<ScaffoldState> this.skey, { Key key }) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState(skey);
}


class _LoginScreenState extends State<LoginScreen> implements LoginViewContract {
  LoginPresenter _presenter;
  bool _IsLoading;
  String token;
  final reference = FirebaseDatabase.instance.reference().child('quotes');
  GlobalKey<ScaffoldState> _scaffoldKey;


  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  _LoginScreenState(GlobalKey<ScaffoldState> skey) {
    _presenter = new LoginPresenter(this);
    _scaffoldKey = skey;
  }

  @override
  void initState() {
    super.initState();
    _IsLoading = false;
  }


  @override
  void onLoginError(String msg) {
    setState(() {
      _IsLoading = false;
    });
    showInSnackBar(msg);
  }

  @override
  void onLoginScuccess(String t) {
    setState(() {
      _IsLoading = false;
      token = t;
    });
    showInSnackBar('Login successful');
  }


  @override
  Widget build(BuildContext context) {
    var widget;
    if(_IsLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );
    } else if(token != null){
      widget = new Padding(
        padding: new EdgeInsets.all(32.0),
        child: new Column(children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(                            //new
              query: reference,                                       //new
              sort: (a, b) => b.key.compareTo(a.key),                 //new
              padding: new EdgeInsets.all(8.0),                       //new
              reverse: true,                                          //new
              itemBuilder: (context, DataSnapshot snapshot, Animation<double> animation,int x) { //new
                return new Quote(                               //new
                    snapshot: snapshot,                                 //new
                    animation: animation                                //new
                );                                                    //new
              },                                                      //new
            ),                                                        //new
          ),
          new Align(
            alignment: const Alignment(0.0, -0.2),
            child: new FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/add');
              },
            ),
          ),
        ], ),
      );
    }
    else {
      widget = new Padding(
          padding: new EdgeInsets.all(32.0),
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Welcome to FlutterAuth,',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),),
                new Text('Login to continue'),
                new Center(
                  child: new Padding(
                      padding: new EdgeInsets.symmetric(vertical: 160.0),
                      child:
                      new InkWell(child:
                      new Text('Login'),onTap: _login,)
                  ),
                ),
              ]
          )
      );
    }
    return widget;
  }

  void _login(){
    setState(() {
      _IsLoading = true;
    });
    _presenter.perform_login();
  }
}