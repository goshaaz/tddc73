import 'package:flutter/material.dart';

class PasswordStrengthField extends StatefulWidget {
  PasswordStrengthField(
      {Key? key,
      required this.onChange,
      this.shouldContainUppercase = true,
      this.shouldContainSpecial = true,
      this.minLength = 6})
      : super(key: key);
  final bool shouldContainUppercase;
  final bool shouldContainSpecial;
  final int minLength;
  final void Function(String password, String strength) onChange;

  @override
  PasswordStrengthFieldState createState() => PasswordStrengthFieldState();
}

class PasswordStrengthFieldState extends State<PasswordStrengthField> {
  strengthText(double value) {
    if (value <= 0.33) {
      return 'Weak';
    }
    if (value <= 0.66) {
      return 'Fair';
    }
    if (value >= 0.66 && value < 0.8) {
      return 'Good';
    }
    return 'Strong';
  }

  getBar(String pw) {
    int numOfConstraints = 2;
    if (widget.shouldContainSpecial) {
      numOfConstraints++;
    }
    if (widget.shouldContainUppercase) {
      numOfConstraints++;
    }
    List<String> hintList = [];
    double toSubtract = (1 / numOfConstraints) - 0.01;
    double barFilled = 1;

    RegExp upperCaseCheck = new RegExp(r"[A-Z]");
    RegExp specialCheck = new RegExp(r"[^a-zA-Z0-9]");

    if (pw.length < widget.minLength) {
      hintList.add('Password too short');
      barFilled -= toSubtract;
    }
    if (pw.length < widget.minLength + 5) {
      if (pw.length >= widget.minLength) {
        hintList.insert(0, 'Password could be longer');
      }
      barFilled -= toSubtract;
    }
    if (!upperCaseCheck.hasMatch(pw) && widget.shouldContainUppercase) {
      hintList.add("Password doesn't contain uppercase letters");
      barFilled -= toSubtract;
    }
    if (!specialCheck.hasMatch(pw) && widget.shouldContainSpecial) {
      hintList.add("Password doesn't contain special characters");
      barFilled -= toSubtract;
    }
    int r = ((0 - 255) * barFilled + 0).floor();
    int g = ((255 - 0) * barFilled + 0).floor();
    return [Color.fromRGBO(r, g, 0, 1), barFilled, hintList];
  }

  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        TextField(
          onChanged: (value) {
            setState(() {
              password = value;
              widget.onChange(value, strengthText(getBar(password)[1]));
            });
          },
          obscureText: true,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            margin: EdgeInsets.only(bottom: 6),
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password strength',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  Text(strengthText(getBar(password)[1]),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: getBar(password)[0]))
                ])),
        Stack(
          children: [
            Container(
                color: Colors.grey[300],
                width: double.infinity,
                height: 14,
                child: null),
            FractionallySizedBox(
                widthFactor: getBar(password)[1],
                child: Container(
                  color: getBar(password)[0],
                  height: 14,
                  child: null,
                ))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: getBar(password)[2].length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  getBar(password)[2][index],
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.red,
                      fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
