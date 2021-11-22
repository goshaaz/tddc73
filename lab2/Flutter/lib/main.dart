import 'package:flutter/material.dart';
import 'widgets/cardForm.dart';
import 'widgets/card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
        ),
        Center(
          child: SingleChildScrollView(
              child: Transform.translate(
                  offset: Offset(0, 110), child: CardForm())),
        )
      ])),
    );
  }
}
