import 'package:flutter/material.dart';
import 'widgets/cardForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          body: Center(
              child: Column(
        children: [Text("Hello"), CardForm()],
        mainAxisAlignment: MainAxisAlignment.center,
      ))),
    );
  }
}
