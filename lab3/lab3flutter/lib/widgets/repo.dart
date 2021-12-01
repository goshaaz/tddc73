import 'package:flutter/material.dart';

class Repo extends StatelessWidget {
  const Repo({Key? key, required this.reponame}) : super(key: key);
  final String reponame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('$reponame')), body: Text(reponame));
  }
}
