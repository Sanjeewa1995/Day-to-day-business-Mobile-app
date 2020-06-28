import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'home.dart';

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

  // String image = "images/company.jpg";
   var asset =  AssetImage( "images/company.jpg");

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
        body:asset==null? CircularProgressIndicator(): Container(
           decoration: BoxDecoration(
          image: DecorationImage(
            image: asset,
            fit: BoxFit.fill,
          ),
        ),
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   stops: [0.3, 1],
            //   colors: <Color>[
            //     Color(0xFF323232),
            //     Color(0xFF9896f1),
            //   ],
            // )),
            child: Column(children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                  child: Text('Select Your Company',
                      style: GoogleFonts.yanoneKaffeesatz(
                          color: Color(0xFFeeeeee),
                          textStyle: TextStyle(fontSize: 40.0)))),
              SizedBox(height: 50.0),
              _myRaisedButton(),
            ])));
  }
}
