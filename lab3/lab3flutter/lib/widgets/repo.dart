import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Repo extends StatefulWidget {
  const Repo(
      {Key? key,
      required this.reponame,
      required this.language,
      required this.starCount,
      required this.watchCount,
      required this.description,
      required this.forkCount,
      required this.avatarUrl,
      required this.userLogin,
      required this.repoUrl})
      : super(key: key);
  final String description;
  final String reponame;
  final String language;
  final String starCount;
  final String watchCount;
  final String forkCount;
  final String avatarUrl;
  final String userLogin;
  final String repoUrl;

  @override
  State<Repo> createState() => _RepoState();
}

class _RepoState extends State<Repo> {
  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final String userLogin = widget.userLogin;
    final String repoUrl = widget.repoUrl;
    String readRepositories = """
  query { 
  user(login: "$userLogin"){
    id
    repositories{
      totalCount
    }
    followers{
      totalCount
    }
    url
  }
}
""";

    return Scaffold(
        appBar: AppBar(title: Text('${widget.reponame}')),
        body: Container(
            margin: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Repository',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.reponame,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.description),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                Text('Language '),
                Text(widget.language,
                    style: TextStyle(fontWeight: FontWeight.w600))
              ]),
              Row(children: [
                Text('Stars '),
                Text(widget.starCount,
                    style: TextStyle(fontWeight: FontWeight.w600))
              ]),
              Row(children: [
                Text('Forks '),
                Text(widget.forkCount,
                    style: TextStyle(fontWeight: FontWeight.w600))
              ]),
              Row(children: [
                Text('Watchers '),
                Text(widget.watchCount,
                    style: TextStyle(fontWeight: FontWeight.w600))
              ]),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => {_launchURL(repoUrl)},
                  child: Text('Go to repository')),
              SizedBox(
                height: 20,
              ),
              Text(
                'Owner',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.avatarUrl),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.userLogin,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Expanded(
                child: Query(
                  options: QueryOptions(document: gql(readRepositories)),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }

                    if (result.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final user = result.data?['user'];

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Text('Followers '),
                            Text(user['followers']['totalCount'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w600))
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Text('Repositories '),
                            Text(user['repositories']['totalCount'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w600))
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () => {_launchURL(user['url'])},
                              child: Text('Go to profile'))
                        ]);
                  },
                ),
              )
            ])));
  }
}
