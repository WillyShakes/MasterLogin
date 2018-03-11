import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class AddQuoteViewContract {
  void quoteAdded();
  void onQuoteAddedError(String message);
}

class AddQuotePresenter {
  AddQuoteViewContract _view;
  AddQuotePresenter(this._view);
  final reference = FirebaseDatabase.instance.reference().child('quotes');

  void add_quote(String author, String quote) {
    assert(_view != null);
    reference.push().set({                                         //new
      'author': author,                                                //new
      'quote': quote,          //new
      'category': 'personal',         //new
    }).then((covariant) {
      _view.quoteAdded();
    }).catchError((error){
      _view.onQuoteAddedError(error.toString());
    });
  }
}