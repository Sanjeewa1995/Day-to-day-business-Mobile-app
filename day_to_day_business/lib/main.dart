import 'package:day_to_day_business/screens/data_enter.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/screens/select_compeny.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:SelectCompeny(),
      routes: <String, WidgetBuilder> {
      '/screens/data_enter': (BuildContext context) => Home(),
      }
    );
  }
}

