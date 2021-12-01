import 'package:flutter/material.dart';
import './devlist.dart';
import './repolist.dart';

class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  var currentPage = Page.Repolist;
  var color = const Color(0xFF161B22);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).padding.top;

    var container;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Trending'),
      ),
      body: container,
    );
  }
}

enum Page { Repolist, Devlist }
