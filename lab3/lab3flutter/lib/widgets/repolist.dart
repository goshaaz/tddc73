import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './main_drawer.dart';

class RepoList extends StatefulWidget {
  const RepoList({Key? key}) : super(key: key);

  @override
  State<RepoList> createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  late Future<Album> futureAlbum;
  var color = const Color(0xFF161B22);
  int test = 0;

  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    print('initialized?');
    futureAlbum = fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('$test'),
      ElevatedButton(
        onPressed: () => {
          setState(() {
            test++;
          })
        },
        child: Text('incr'),
      ),
      Expanded(
        child: Container(
            color: Colors.orange,
            child: SingleChildScrollView(
              child: FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data!);
                    return Text(snapshot.data!.title);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            )),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0)),
                          contentPadding: EdgeInsets.all(14),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'all',
                            isDense: true,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                  child: Text("All"), value: "all"),
                              DropdownMenuItem(
                                  child: Text("Female"), value: "Female"),
                            ],
                            onChanged: (newValue) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ))
    ]));
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
