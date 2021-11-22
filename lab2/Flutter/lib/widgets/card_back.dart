import 'package:flutter/material.dart';

class CardBack extends StatelessWidget {
  const CardBack(
      {Key? key, required String this.cardnumber, required String this.cvv})
      : super(key: key);
  final String cardnumber;
  final String cvv;

  String cardType(String s) {
    RegExp visa = RegExp(r'^4');
    RegExp mastercard = RegExp(r'^5[1-5]');
    RegExp amex = RegExp(r'^(34|37)');
    RegExp discover = RegExp(r'^6011');
    RegExp troy = RegExp(r'^9792');

    if (visa.hasMatch(s)) {
      return 'visa';
    }
    if (amex.hasMatch(s)) {
      return 'amex';
    }
    if (mastercard.hasMatch(s)) {
      return 'mastercard';
    }
    if (discover.hasMatch(s)) {
      return 'discover';
    }
    if (troy.hasMatch(s)) {
      return 'troy';
    }

    return 'visa';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 275,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            image: DecorationImage(
                image: AssetImage("assets/6.jpeg"), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.black87,
              height: 32,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                child: Text('CVV',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(4),
                color: Colors.white,
                height: 32,
                alignment: Alignment.centerRight,
                child: Text(
                  '$cvv',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: cardType(cardnumber) == 'visa'
                    ? Image(
                        image: AssetImage('assets/visa.png'),
                        height: 30,
                      )
                    : cardType(cardnumber) == 'amex'
                        ? Image(
                            image: AssetImage('assets/amex.png'),
                            height: 30,
                          )
                        : cardType(cardnumber) == 'mastercard'
                            ? Image(
                                image: AssetImage('assets/mastercard.png'),
                                height: 50,
                              )
                            : cardType(cardnumber) == 'troy'
                                ? Image(
                                    image: AssetImage('assets/troy.png'),
                                    height: 30,
                                  )
                                : cardType(cardnumber) == 'discover'
                                    ? Image(
                                        image:
                                            AssetImage('assets/discover.png'),
                                        height: 30,
                                      )
                                    : Image(
                                        image: AssetImage('assets/visa.png'),
                                        height: 30,
                                      ))
          ],
        ));
  }
}
