import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'home.dart';

class DayWiseSummery extends StatefulWidget {
  final String year;
  final String month;
  final String day;
  final String date;

  DayWiseSummery({this.year, this.month, this.day, this.date});


  _DayWiseSummeryState createState() => _DayWiseSummeryState(year, month, day, date);
}

class _DayWiseSummeryState extends State<DayWiseSummery> {
  final String year;
  final String month;
  final String day;
  final String date;

  _DayWiseSummeryState(this.year, this.month, this.day, this.date);

  _myRaisedButtonHome(){
    return MyRaisedButton(
      onPressed:(){
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Home',
      roundedBorde: true,
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title:Text(date)
    ),
    body: StreamBuilder(
      stream: Firestore.instance.collection('Wijaya').document(year).collection('Month').document(month).collection('Day').document(date).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return Column(
          children:<Widget>[
                SizedBox(height:20.0),
                Center(
                  child: Text('Summery Of Today',
                  style: GoogleFonts.yanoneKaffeesatz(
                    fontSize:40.0,
                    color: Hexcolor('0f3057'),
                  ),
                  ),
                ),
                  Center(
                child: Column(children:<Widget>[
                SizedBox(height:20.0),
                Text('Sale: ' + userDocument['Sale'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Profit: ' + userDocument['Profit'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Discount: ' +userDocument['Disccount'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Diesel: ' + userDocument['Diesel'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Employee: ' + userDocument['Employee'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Tea: ' + userDocument['Tea'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Other Cost: ' + userDocument['Other Cost'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),]),),
                SizedBox(height:40.0),
                _myRaisedButtonHome()
          ]
        );
      }
  )
    );
  }
}
