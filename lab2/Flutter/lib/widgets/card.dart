import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  const CreditCard(
      {Key? key,
      required this.year,
      required this.cardnumber,
      required this.name,
      required this.cvv,
      required this.month,
      required this.focused})
      : super(key: key);
  final String year;
  final String cardnumber;
  final String name;
  final String cvv;
  final String month;
  final String focused;

  static RegExp visa = RegExp(r'^4');
  static RegExp master = RegExp(r'^5[1-5]');
  static RegExp amex = RegExp(r'^(34|37)');
  static RegExp discover = RegExp(r'^6011');
  static RegExp troy = RegExp(r'^9792');

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

  String processCard(String s) {
    for (int i = s.length - 1; i < 18; i++) {
      if (i != 3 && i != 8 && i != 13) {
        s += "#";
      } else {
        s += " ";
      }
    }
    return s;
  }

  String processMonth(String s) {
    if (s.length == 1) {
      return '0$s/';
    }
    return s + '/';
  }

  String processYear(String s) {
    return "/" + s.substring(2, 4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275,
      height: 180,
      child: Padding(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: AssetImage('assets/chip.png'),
                  width: 35,
                ),
                cardType(cardnumber) == 'visa'
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
                                      )
              ],
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Text(processCard("$cardnumber"),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: focused == 'cardnumber'
                      ? Border.all(color: Colors.white)
                      : null),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                        child: Column(
                          children: [
                            Text(
                              'Card Holder',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            Text(
                              name == '' ? 'FULL NAME' : '$name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: focused == 'cardname'
                                ? Border.all(color: Colors.white)
                                : null)),
                    flex: 4),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                        child: Column(
                          children: [
                            Text(
                              'Expires',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            Row(children: [
                              Text(
                                month == 'Month' ? 'MM/' : processMonth(month),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                year == 'Year' ? 'YY' : year.substring(2, 4),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: focused == 'expiration'
                                ? Border.all(color: Colors.white)
                                : null)),
                    flex: 2),
                /*
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Card Holder',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        name == '' ? 'FULL NAME' : '$name',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Text(
                        'Card Holder',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        name == '' ? 'FULL NAME' : '$name',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                */
              ],
            ),
            /*
            Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Card Holder',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      'Expires',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name == '' ? 'FULL NAME' : '$name',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Row(children: [
                      Text(
                        month == 'Month' ? 'MM/' : processMonth(month),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        year == 'Year' ? 'YY' : year.substring(2, 4),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ]),
                    flex: 1,
                  ),
                ],
              )
            ]),
            */
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
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
    );
  }
}
