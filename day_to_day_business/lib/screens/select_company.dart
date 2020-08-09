import 'dart:ui';

import 'package:day_to_day_business/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'home.dart';
import 'package:day_to_day_business/raigam/home.dart';

class SelectCompany extends StatefulWidget {
  SelectCompany({Key key}) : super(key: key);

  _SelectCompanyState createState() => _SelectCompanyState();
}

class _SelectCompanyState extends State<SelectCompany> {
  _myRaisedButton() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Wijaya Product',
      roundedBorde: true,
    );
  }

   _myRaisedButtonRaigam() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RaigamHome()));
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Raigam Product',
      roundedBorde: true,
    );
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Container(
          margin: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Select Your Company',
                  style: headerStyle,
                ),
                Container(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'images/c1.jpg',
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )),
                _myRaisedButton(),
               // SizedBox(height: 20.0,),
                _myRaisedButtonRaigam(),
              ]),
        ));
  }
}
