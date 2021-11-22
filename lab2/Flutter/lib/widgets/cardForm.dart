import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'card_back.dart';
import 'card.dart';

class CardForm extends StatefulWidget {
  const CardForm({Key? key}) : super(key: key);

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  String _cardNumber = "";
  bool opened = false;
  String month = "Month";
  String year = "Year";
  String name = "";
  String cvv = "";
  String focused = "";
  final FocusNode fnodenumber = FocusNode();
  final FocusNode fnodename = FocusNode();
  final FocusNode fnodemonth = FocusNode();
  final FocusNode fnodeyear = FocusNode();
  final FocusNode fnodecvv = FocusNode();
  bool yearOpened = false;

  late final TextEditingController _textEditing;

  late AnimationController animationController;

  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  var yearsList = ['Year'];
  var monthsList = [
    'Month',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  colorMonth(String monthVal) {
    if (year == 'Year' || int.parse(year) > currentYear) {
      if (monthVal == 'Month') return Colors.black87;
      return Colors.black;
    }
    if (monthVal == 'Month') {
      return Colors.black87;
    }
    if (monthVal[0] == '0') {
      if (int.parse(monthVal[1]) < currentMonth) {
        return Colors.black45;
      } else {
        return Colors.black;
      }
    }
    if (int.parse(monthVal) < currentMonth) {
      return Colors.black45;
    } else {
      return Colors.black;
    }
  }

  colorYear(String yearVal) {
    print(yearOpened);
    if (yearVal == 'Year') {
      return Colors.black87;
    } else {
      return Colors.black;
    }
  }

  @override
  void initState() {
    super.initState();
    for (var i = currentYear; i < currentYear + 8; i++) {
      yearsList.add(i.toString());
    }
    print(currentMonth);
    print(currentYear);
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animationController.addListener(() {
      setState(() {});
    });
    fnodenumber.addListener(() {
      setState(() {
        if (fnodenumber.hasFocus) {
          if (focused == 'cvv') {
            animationController.reverse();
          }
          focused = 'cardnumber';
        } else {
          focused = '';
        }
      });
    });
    fnodename.addListener(() {
      setState(() {
        if (fnodename.hasFocus) {
          if (focused == 'cvv') {
            animationController.reverse();
          }
          focused = 'cardname';
        } else {
          focused = '';
        }
      });
    });
    fnodemonth.addListener(() {
      setState(() {
        if (!fnodemonth.hasFocus) {
          if (focused == 'cvv') {
            animationController.reverse();
          }
          focused = 'expiration';
        } else {
          focused = '';
        }
      });
    });
    fnodeyear.addListener(() {
      setState(() {
        if (!fnodeyear.hasFocus) {
          if (focused == 'cvv') {
            animationController.reverse();
          }
          focused = 'expiration';
          yearOpened = true;
        } else {
          focused = '';
          yearOpened = false;
        }
      });
    });
    fnodecvv.addListener(() {
      setState(() {
        if (!fnodecvv.hasFocus) {
          animationController.reverse();
          focused = 'cvv';
        } else {
          animationController.forward();
          focused = '';
        }
      });
    });
  }

  currentAnimation() {
    if (animationController.velocity > 0) {
      return Transform(
          transform: Matrix4.rotationY((animationController.value) * (3.14)),
          alignment: Alignment.center,
          child: CreditCard(
            year: year,
            cardnumber: _cardNumber,
            name: name,
            cvv: cvv,
            month: month,
            focused: focused,
          ));
    }
  }

  @override
  void dispose() {
    fnodemonth.dispose();
    fnodeyear.dispose();
    fnodecvv.dispose();
    fnodenumber.dispose();
    fnodename.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
            padding: EdgeInsets.all(40),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Text(
                      'Card Number',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(top: 12, bottom: 6)),
                TextField(
                  focusNode: fnodenumber,
                  maxLength: 19,
                  onTap: () => {
                    setState(() {
                      fnodenumber.requestFocus();
                    })
                  },
                  controller: _controller,
                  onChanged: (value) {
                    if (_controller.text.length > 19) return;
                    RegExp regExp = new RegExp(
                      r"(?<=[0-9]{4})(\B)",
                      caseSensitive: false,
                      multiLine: false,
                    );
                    RegExp removeSpaces = new RegExp(
                      r" ",
                      caseSensitive: false,
                      multiLine: false,
                    );
                    _controller.text = _controller.text.replaceAll(regExp, " ");
                    RegExp test = new RegExp(
                      r"(\d{1,4})",
                    );
                    _controller.selection = TextSelection(
                        baseOffset: _controller.text.length,
                        extentOffset: _controller.text.length);
                    setState(() {
                      _cardNumber = _controller.text;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      counterText: ""),
                ),
                Container(
                    child: Text(
                      'Card Name',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(top: 12, bottom: 6)),
                TextField(
                  focusNode: fnodename,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  onTap: () => {
                    setState(() {
                      fnodename.requestFocus();
                    })
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      counterText: ""),
                ),
                SizedBox(height: 12),
                Row(children: [
                  Expanded(
                      flex: 10,
                      child: Container(
                        child: Text(
                          'Expiration Date',
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey),
                        ),
                      )),
                  Expanded(
                      flex: 5,
                      child: Container(
                        child: Text(
                          'CVV',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey),
                        ),
                      ))
                ]),
                SizedBox(
                  height: 4,
                ),
                Row(children: [
                  DropdownButton<String>(
                      focusNode: fnodemonth,
                      isDense: true,
                      onTap: () {
                        setState(() {
                          fnodemonth.requestFocus();
                        });
                      },
                      elevation: 16,
                      onChanged: (String? newValue) {
                        setState(() {
                          month = newValue!;
                        });
                      },
                      value: month,
                      items: monthsList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value[0] == "0" ? value[1] : value,
                          enabled: colorMonth(value) == Colors.black,
                          child: Text(
                            value,
                            style: TextStyle(color: colorMonth(value)),
                          ),
                        );
                      }).toList()),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                      focusNode: fnodeyear,
                      onTap: () {
                        setState(() {
                          fnodeyear.requestFocus();
                        });
                      },
                      isDense: true,
                      elevation: 16,
                      onChanged: (String? newValue) {
                        setState(() {
                          year = newValue!;

                          if (month != 'Month' &&
                              int.parse(month) < currentMonth) {
                            month = 'Month';
                          }
                        });
                      },
                      value: year,
                      items: yearsList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: !(value == "Year"),
                          child: Text(
                            value,
                            style: TextStyle(color: colorYear(value)),
                          ),
                        );
                      }).toList()),
                  SizedBox(width: 52),
                  Expanded(
                      child: TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    onChanged: (value) {
                      cvvController.text =
                          cvvController.text.replaceAll(" ", "");
                      setState(() {
                        cvv = cvvController.text;
                      });
                      cvvController.selection = TextSelection(
                          baseOffset: cvvController.text.length,
                          extentOffset: cvvController.text.length);
                    },
                    focusNode: fnodecvv,
                    onTap: () {
                      setState(() {
                        fnodecvv.requestFocus();
                      });
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        counterText: ""),
                  )),
                ]),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                  onPressed: () => print('o'),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              ],
            )),
        Transform.translate(
            offset: Offset(0, -130),
            child: Container(
                child: animationController.value < 0.5
                    ? Transform(
                        transform: Matrix4.rotationY(
                            (animationController.value * 3.14)),
                        alignment: Alignment.center,
                        child: CreditCard(
                          year: year,
                          cardnumber: _cardNumber,
                          name: name,
                          cvv: cvv,
                          month: month,
                          focused: focused,
                        ))
                    : Transform(
                        transform: Matrix4.rotationY((3.14 / 2 -
                            (animationController.value - 0.5) * 3.14)),
                        child: CardBack(
                          cardnumber: _cardNumber,
                          cvv: cvv,
                        ),
                        alignment: Alignment.center),
                margin: EdgeInsets.all(20))),
      ],
    );
  }
}
