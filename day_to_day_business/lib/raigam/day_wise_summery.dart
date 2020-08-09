import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/raigam/home.dart';

class DayWiseSummery extends StatefulWidget {
  final String year;
  final String month;
  final String day;
  final String date;

  DayWiseSummery({this.year, this.month, this.day, this.date});

  _DayWiseSummeryState createState() =>
      _DayWiseSummeryState(year, month, day, date);
}

class _DayWiseSummeryState extends State<DayWiseSummery> {
  final String year;
  final String month;
  final String day;
  final String date;

  _DayWiseSummeryState(this.year, this.month, this.day, this.date);

  _myRaisedButtonHome() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RaigamHome()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Home',
      roundedBorde: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF57DAD7),
        appBar: AppBar(centerTitle: true, title: Text(date)),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Raigam')
                .document(year)
                .collection('Month')
                .document(month)
                .collection('Day')
                .document(date)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot.data;
              print(snapshot.data.toString());
              return Column(children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Summery Of Today',
                    style: GoogleFonts.yanoneKaffeesatz(
                      fontSize: 40.0,
                      color: Hexcolor('0f3057'),
                    ),
                  ),
                ),
                Center(
                  child: Column(children: <Widget>[
                    ReUseText('Sale: ' + userDocument['Sale'].toString()),
                    ReUseText('Profit: ' + userDocument['Profit'].toString()),
                    ReUseText('Discount: ' + userDocument['Disccount'].toString()),
                    ReUseText('Diesel: ' + userDocument['Diesel'].toString()),
                    ReUseText('Employee: ' + userDocument['Employee'].toString()),
                    ReUseText('Tea: ' + userDocument['Tea'].toString()),
                    ReUseText('Other Cost: ' + userDocument['Other Cost'].toString()),
                    ReUseText('Cheque Value: ' + userDocument['Cheque Value'].toString()),
                    ReUseText('Credit Value: ' + userDocument['Credit Value'].toString()),
                    ReUseText('Various: ' + userDocument['Various'].toString()),
                    _myRaisedButtonHome(),
                  ]),
                )
              ]);
            }));
  }
}

class ReUseText extends StatelessWidget {
  final label;

  const ReUseText(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: 20.0),
    );
  }
}
