import 'package:flutter/material.dart';
import '../movie.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({Key? key, required this.mov}) : super(key: key);
  final Movie mov;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            mov.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Container(
                color: Colors.red,
                height: 450,
                width: 1900,
                child: Image.network(mov.imgUrl, fit: BoxFit.cover),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  mov.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    mov.description,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  )),
              Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Text(
                    mov.releaseYear.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ))
            ])));
  }
}
