import 'package:day_to_day_business/screens/day_wise_summery.dart';
import 'package:day_to_day_business/screens/enter_data.dart';
import 'package:day_to_day_business/screens/month_wise_summery.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'add_data.dart';
import 'display_data.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _image() {
    return Center(
      child: Container(
          width: 400.0,
          height: 300.0,
          child: Image(image: AssetImage('images/wijaya.jpg'))),
    );
  }

  _addData() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddData()));
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Add Data',
      roundedBorde: false,
    );
  }

  _displayData() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DisplayData()));
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Display Data',
      roundedBorde: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2d4059),
        appBar: AppBar(centerTitle: true, title: Text('Home')),
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SizedBox(height: 20.0),
          _image(),
          SizedBox(height: 20.0),
          _addData(),
          SizedBox(height: 20.0),
          _displayData(),
          SizedBox(height: 20.0),
        ]));
  }
}
