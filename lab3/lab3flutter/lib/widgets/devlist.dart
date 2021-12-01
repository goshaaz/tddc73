import 'package:flutter/material.dart';

class DevList extends StatefulWidget {
  const DevList({Key? key}) : super(key: key);

  @override
  State<DevList> createState() => _DevListState();
}

class _DevListState extends State<DevList> {
  final color = const Color(0xFF161B22);

  @override
  Widget build(BuildContext context) {
    return Text('Developers list');
  }
}
