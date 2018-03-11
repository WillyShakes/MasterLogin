import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masterlogin/Add/add_quote_presenter.dart';


class AddQuote extends StatefulWidget {
  const AddQuote({ Key key }) : super(key: key);
  @override
  _AddQuoteState createState() => new _AddQuoteState();
}


class _AddQuoteState extends State<AddQuote> implements AddQuoteViewContract {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AddQuotePresenter _presenter;
  bool _IsLoading;
  String token;
  final reference = FirebaseDatabase.instance.reference().child('quotes');
  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  BuildContext _context;
  String _author;
  String _quote;

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;  // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      _presenter.add_quote(_author, _quote);
    }
  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'This field is required.';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      child: new AlertDialog(
        title: const Text('This form has errors'),
        content: const Text('Really leave this form?'),
        actions: <Widget> [
          new FlatButton(
            child: const Text('YES'),
            onPressed: () { Navigator.of(context).pop(true); },
          ),
          new FlatButton(
            child: const Text('NO'),
            onPressed: () { Navigator.of(context).pop(false); },
          ),
        ],
      ),
    ) ?? false;
  }


  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  _AddQuoteState() {
    _presenter = new AddQuotePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _IsLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    var widget;
    if(_IsLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );
    }
    else {
      widget = new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autovalidate,
          onWillPop: _warnUserAboutInvalidData,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Author',
                  labelText: 'author *',
                ),
                onSaved: (String value) { _author = value; },
                validator: _validateName,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.note),
                  hintText: 'Your quote',
                  labelText: 'Quote',
                ),
                maxLines: 3,
                keyboardType: TextInputType.emailAddress,
                onSaved: (String value) { _quote = value; },
                validator: _validateName,
              ),
              new Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new RaisedButton(
                  child: const Text('ADD'),
                  onPressed: _handleSubmitted,
                ),
              ),
            ],
          ),
        ),
    );
    }
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
        title: const Text('Add Quote'),
    ),
    body: widget
    );
  }



  @override
  void onQuoteAddedError(String message) {
    showInSnackBar('Error '+message);
  }

  @override
  void quoteAdded() {
    Navigator.pop(_context);
  }
}