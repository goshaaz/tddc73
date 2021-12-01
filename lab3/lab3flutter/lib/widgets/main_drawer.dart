import 'package:flutter/material.dart';
import './repolist.dart';
import './devlist.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).padding.top;

    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.black26))),
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 14),
            child: Text(
              'Repositories',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => DevList(),
                  transitionDuration: Duration(seconds: 2),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.black26))),
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 14),
            child: Text(
              'Developers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ));
  }
}

enum Page { Repolist, Devlist }
