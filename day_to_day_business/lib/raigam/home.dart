import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/raigam/add_data.dart';
import 'package:day_to_day_business/raigam/display_data.dart';

class RaigamHome extends StatefulWidget {
  RaigamHome({Key key}) : super(key: key);

  _RaigamHomeState createState() => _RaigamHomeState();
}

class _RaigamHomeState extends State<RaigamHome> {
  _image() {
    return Center(
      child: Image(
        image: AssetImage('images/raigam.jpg'),
        height: 300.0,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  _addData() {
    return Expanded(
      child: MyRaisedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
        size: 300.0,
        color: Colors.blue,
        textColor: Colors.white,
        label: 'Add Data',
        roundedBorde: false,
      ),
    );
  }

  _displayData() {
    return Expanded(
      child: MyRaisedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DisplayData()));
        },
        size: 300.0,
        color: Colors.blue,
        textColor: Colors.white,
        label: 'Display Data',
        roundedBorde: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home'),
          backgroundColor: Color(0xFF19769F),
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _image(),
          _addData(),
          _displayData(),
          Expanded(child: Container()),
        ]));
  }
}
