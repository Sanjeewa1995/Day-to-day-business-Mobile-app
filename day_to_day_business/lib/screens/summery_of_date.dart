import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SummeryOfDate extends StatefulWidget {

  final DocumentSnapshot date;
  SummeryOfDate({this.date});

  _SummeryOfDateState createState() => _SummeryOfDateState();
}

class _SummeryOfDateState extends State<SummeryOfDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:<Widget>[
          SizedBox(height: 30.0,),
          SizedBox(
            child:Text(widget.date.data['sale'])
          )
        ]
      ),
    );
  }
}

