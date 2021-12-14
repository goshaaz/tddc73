import 'package:flutter/material.dart';
import 'package:projectflutter/widgets/carousel.dart';
import 'package:projectflutter/widgets/password_strengthfield.dart';
import 'movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(primarySwatch: Colors.lightBlue),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Movie> movieList = [
    Movie(
        "Series based on the Marvel Comics superhero Hawkeye, centering on the adventures of Young Avenger, Kate M. Bishop, who took on the role after the original Avenger, Clint Barton.",
        'Hawkeye',
        "https://m.media-amazon.com/images/M/MV5BZGRjYjNmYmQtZTI4NS00ZGQwLTg1YzQtMzJkOWJmYTNkODJmXkEyXkFqcGdeQXVyNTA3MTU2MjE@._V1_FMjpg_UX1000_.jpg",
        2021),
    Movie(
        "Set in utopian Piltover and the oppressed underground of Zaun, the story follows the origins of two iconic League champions-and the power that will tear them apart.",
        'Arcane',
        "https://m.media-amazon.com/images/M/MV5BYmU5OWM5ZTAtNjUzOC00NmUyLTgyOWMtMjlkNjdlMDAzMzU1XkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg",
        2021),
    Movie(
        "An unusual group of robbers attempt to carry out the most perfect robbery in Spanish history - stealing 2.4 billion euros from the Royal Mint of Spain.",
        'La casa de papel',
        "https://m.media-amazon.com/images/M/MV5BNDJkYzY3MzMtMGFhYi00MmQ4LWJkNTgtZGNiZWZmMTMxNzdlXkEyXkFqcGdeQXVyMTEyMjM2NDc2._V1_FMjpg_UX1000_.jpg",
        2017),
    Movie(
        "Geralt of Rivia, a solitary monster hunter, struggles to find his place in a world where people often prove more wicked than beasts.",
        'The Witcher',
        "https://m.media-amazon.com/images/M/MV5BN2FiOWU4YzYtMzZiOS00MzcyLTlkOGEtOTgwZmEwMzAxMzA3XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg",
        2019),
    Movie(
        "Hundreds of cash-strapped players accept a strange invitation to compete in children's games. Inside, a tempting prize awaits with deadly high stakes. A survival game that has a whopping 45.6 billion-won prize at stake.",
        'Squid Game',
        "https://m.media-amazon.com/images/M/MV5BYWE3MDVkN2EtNjQ5MS00ZDQ4LTliNzYtMjc2YWMzMDEwMTA3XkEyXkFqcGdeQXVyMTEzMTI1Mjk3._V1_FMjpg_UX1000_.jpg",
        2021),
    Movie(
        "A teenage boy with a sex therapist mother teams up with a high school classmate to set up an underground sex therapy clinic at school.",
        'Sex Education',
        "https://m.media-amazon.com/images/M/MV5BODhmN2Q4ZjUtNzE5Ni00YWQxLThmYjYtM2NkNDEwNmFhMGY3XkEyXkFqcGdeQXVyMTEyMjM2NDc2._V1_.jpg",
        2019)
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Container(
        margin: EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: PasswordStrengthField(
              onChange: (password, strength) {
                print(password);
                print(strength);
              },
              shouldContainSpecial: false,
            ),
          )
        ]),
      ),
      Carousel(
        movieList: movieList,
        numOfItems: 2,
      )
    ];

    return Scaffold(
      appBar:
          AppBar(title: Text('Project', style: TextStyle(color: Colors.white))),
      body: items[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.password_sharp),
            label: 'Password strength',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel),
            label: 'Carousel',
          ),
        ],
      ),
    );
  }
}
