import 'package:flutter/material.dart';
import 'package:projectflutter/widgets/movie_info.dart';
import '../movie.dart';

class Carousel extends StatefulWidget {
  Carousel({Key? key, required this.movieList, this.numOfItems = 3})
      : super(key: key);

  List<Movie> movieList;
  int numOfItems;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentIndex = 0;
  late int numOfPages = (widget.movieList.length / widget.numOfItems).ceil();

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (var i = currentIndex * widget.numOfItems;
        i < currentIndex * widget.numOfItems + widget.numOfItems;
        i++) {
      if (i >= widget.movieList.length) {
        items.add(Expanded(
          child: Text(''),
        ));
        continue;
      }
      if (widget.numOfItems == 1) {
        items.add(Expanded(
            child: Container(
                margin: EdgeInsets.all(6),
                child: Column(children: [
                  Image.network(
                    widget.movieList[i].imgUrl,
                    height: 300,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.movieList[i].title,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ]))));
        continue;
      }
      items.add(Expanded(
          child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieInfo(mov: widget.movieList[i])),
          );
        },
        child: Container(
            margin: EdgeInsets.all(6),
            child: Column(children: [
              Image.network(
                widget.movieList[i].imgUrl,
                width: double.infinity,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.movieList[i].title,
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ])),
      )));
    }

    return Container(
        margin: EdgeInsets.all(20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'Carousel',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: double.infinity,
              child: Row(mainAxisSize: MainAxisSize.min, children: items)),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  numOfPages,
                  (index) => index == currentIndex
                      ? Icon(
                          Icons.circle,
                          color: Colors.blue,
                          size: 14,
                        )
                      : Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 14,
                        ))),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                if (currentIndex == 0) return;
                setState(() {
                  currentIndex--;
                });
                print('tapped');
              },
              child: Container(
                decoration: BoxDecoration(
                    color: currentIndex == 0 ? Colors.grey : Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Icon(
                  Icons.arrow_left_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            GestureDetector(
              onTap: () {
                if (currentIndex == numOfPages - 1) return;
                setState(() {
                  currentIndex++;
                });
                print('tapped');
              },
              child: Container(
                decoration: BoxDecoration(
                    color: currentIndex == (numOfPages - 1)
                        ? Colors.grey
                        : Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Icon(
                  Icons.arrow_right_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ])
        ]));
  }
}
