import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'card.dart';

class CardForm extends StatefulWidget {
  const CardForm({Key? key}) : super(key: key);

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
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
                      focused = "cardnumber";
                    })
                  },
                  onEditingComplete: () => {
                    setState(() {
                      fnodenumber.unfocus();
                      focused = "";
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
                      focused = 'cardname';
                    })
                  },
                  onEditingComplete: () => {
                    setState(() {
                      fnodename.unfocus();
                      focused = "";
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
                      isDense: true,
                      elevation: 16,
                      onChanged: (String? newValue) {
                        setState(() {
                          month = newValue!;
                        });
                      },
                      value: month,
                      items: <String>['Month', '01', '02', '03', '12']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value[0] == "0" ? value[1] : value,
                          enabled: !(value == "Month"),
                          child: Text(value),
                        );
                      }).toList()),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                      isDense: true,
                      elevation: 16,
                      onChanged: (String? newValue) {
                        setState(() {
                          year = newValue!;
                        });
                      },
                      value: year,
                      items: <String>['Year', '2021', '2022', '2023']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: !(value == "Year"),
                          child: Text(value),
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
            offset: Offset(0, -120),
            child: Container(
                child: CreditCard(
                  year: year,
                  cardnumber: _cardNumber,
                  name: name,
                  cvv: cvv,
                  month: month,
                  focused: focused,
                ),
                margin: EdgeInsets.all(20)))
      ],
    );
  }
}
