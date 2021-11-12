import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Example 1'),
            backgroundColor: Colors.teal,
          ),
          body: Column(
            children: [
              SizedBox(height: 10),
              Image(
                image: AssetImage('assets/imglab1.png'),
                width: 150,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('BUTTON',
                        style: TextStyle(color: Colors.black87)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white38,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('BUTTON',
                        style: TextStyle(color: Colors.black87)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white38,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('BUTTON',
                        style: TextStyle(color: Colors.black87)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white38,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('BUTTON',
                        style: TextStyle(color: Colors.black87)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white38,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              SizedBox(height: 0),
              Row(
                children: [
                  SizedBox(width: 40),
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        'Email',
                        style: TextStyle(color: Colors.black54),
                      )),
                  Container(
                      width: 180,
                      margin: const EdgeInsets.only(left: 50.0, bottom: 0),
                      child: TextFormField(
                          cursorColor: Colors.redAccent,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                                top: 24, bottom: 4, left: 0, right: 6),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                            ),
                          )))
                ],
              )
            ],
          )),
    );
  }
}
