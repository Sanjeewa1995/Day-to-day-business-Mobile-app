import 'package:day_to_day_business/screens/dates.dart';
import 'package:day_to_day_business/screens/detail_page.dart';
import 'package:day_to_day_business/screens/enter_data.dart';
import 'package:day_to_day_business/screens/home.dart';
import 'package:day_to_day_business/screens/select_company.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectCompany(),
      routes: {
        "/home": (context) => Home(),
        "/select_company": (context) => SelectCompany(),
        "/enter_data": (context) => EnterData(),
        "/dates": (context) => Dates(),
        "/detail_page": (context) => Detail(),
      },
    );
  }
}
