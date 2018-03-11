import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class Quote extends StatelessWidget {
  Quote({this.snapshot, this.animation});
  final DataSnapshot snapshot;
  final Animation animation;

  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animation, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                      snapshot.value['author'],
                      style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child:
                    new Text(
                        snapshot.value['quote']
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}