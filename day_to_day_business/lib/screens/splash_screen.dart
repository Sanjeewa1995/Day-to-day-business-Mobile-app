import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:day_to_day_business/custom_widgets/progress_dialog.dart';
import 'package:day_to_day_business/screens/select_compant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../const_value.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 5), () {
    //   Navigator.of(context).pushReplacementNamed(SelectCompany.routeName);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Center(
              child: SpinKitCircle(color: Color(0xFF85091B), size: 60),
            ),
          ),
        ],
      ),
    );
  }
}
