import 'package:flutter/material.dart';
import 'package:lab3flutter/widgets/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './widgets/repo.dart';

void main() => runApp(MyApp());

final HttpLink httpLink = HttpLink(
  'https://api.github.com/graphql',
);

final AuthLink authLink = AuthLink(
  getToken: () async => 'Bearer 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',
  // OR
  // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
);

final Link link = authLink.concat(httpLink);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  ),
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var color = const Color(0xFF161B22);

  static DateTime now = new DateTime.now();
  static DateTime weekAgo = now.subtract(Duration(days: 7));
  static String year = weekAgo.year.toString();
  static String month = weekAgo.month.toString();
  static String day = weekAgo.day.toString();

  String language = 'All';

  @override
  Widget build(BuildContext context) {
    if (day.length == 1) {
      day = '0' + day;
    }
    if (month.length == 1) {
      day = '0' + day;
    }

    String readRepositories = """
  {
  search(query: "created:>=$year-$month-$day sort:stars language:$language", type: REPOSITORY, first: 20) {
    repositoryCount
    pageInfo {
      endCursor
      startCursor
    }
    edges {
      node {
        ... on Repository {
          primaryLanguage{
            name
          }
          owner {
					  login
            avatarUrl
					}
          name
          forkCount
          description
          stargazers {
            totalCount
          }
          url
        }
      }
    }
  }
}
""";

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
            theme: ThemeData(primarySwatch: Colors.indigo),
            routes: {
              '/asd': (_) => Main(),
            },
            title: 'Welcome to Flutter',
            home: Scaffold(
                appBar: AppBar(
                  title: Text('Trending repositories'),
                ),
                body: Column(children: [
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

                        final repoList = result.data?['search']['edges'];

                        return Column(children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: repoList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (repoList[index]['node']
                                                ['primaryLanguage']
                                            .toString() ==
                                        'null') {
                                      return SizedBox.shrink();
                                    }
                                    return GestureDetector(
                                        onTap: () {
                                          print(index);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Repo(
                                                      reponame: repoList[index]
                                                              ['node']['name']
                                                          .toString(),
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            repoList[index]
                                                                        ['node']
                                                                    ['name']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                          Text(
                                                            repoList[index]['node']
                                                                        [
                                                                        'owner']
                                                                    ['login']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Expanded(
                                                            child: Text(
                                                              repoList[index]['node']
                                                                              [
                                                                              'description']
                                                                          .toString() ==
                                                                      'null'
                                                                  ? ''
                                                                  : repoList[index]
                                                                              [
                                                                              'node']
                                                                          [
                                                                          'description']
                                                                      .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                            ),
                                                          )
                                                        ])),
                                                Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              repoList[index]['node']
                                                                          [
                                                                          'primaryLanguage']
                                                                      ['name']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            alignment: Alignment
                                                                .topRight,
                                                          ),
                                                          Container(
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .indigo,
                                                                    size: 20.0,
                                                                    semanticLabel:
                                                                        'Text to announce in accessibility modes',
                                                                  ),
                                                                  Text(repoList[index]['node']
                                                                              [
                                                                              'stargazers']
                                                                          [
                                                                          'totalCount']
                                                                      .toString())
                                                                ]),
                                                            alignment: Alignment
                                                                .bottomRight,
                                                          ),
                                                        ]))
                                              ]),
                                          margin: EdgeInsets.all(14),
                                          padding: EdgeInsets.all(14),
                                        ));
                                  }))
                        ]);
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0)),
                                      contentPadding: EdgeInsets.all(14),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: language,
                                        isDense: true,
                                        items: [
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'All';
                                                });
                                              },
                                              child: Text("All"),
                                              value: "All"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'C';
                                                });
                                              },
                                              child: Text("C"),
                                              value: "C"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'C++';
                                                });
                                              },
                                              child: Text("C++"),
                                              value: "C++"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'C#';
                                                });
                                              },
                                              child: Text("C#"),
                                              value: "C#"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'Go';
                                                });
                                              },
                                              child: Text("Go"),
                                              value: "Go"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'Java';
                                                });
                                              },
                                              child: Text("Java"),
                                              value: "Java"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'JavaScript';
                                                });
                                              },
                                              child: Text("JavaScript"),
                                              value: "JavaScript"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'PHP';
                                                });
                                              },
                                              child: Text("PHP"),
                                              value: "PHP"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'Python';
                                                });
                                              },
                                              child: Text("Python"),
                                              value: "Python"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'Ruby';
                                                });
                                              },
                                              child: Text("Ruby"),
                                              value: "Ruby"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'Scala';
                                                });
                                              },
                                              child: Text("Scala"),
                                              value: "Scala"),
                                          DropdownMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  language = 'TypeScript';
                                                });
                                              },
                                              child: Text("TypeScript"),
                                              value: "TypeScript"),
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
                ]))));
  }
}
