import 'package:day_to_day_business/raigam/add_data.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/raigam/home.dart';
import 'package:day_to_day_business/custom_widgets/constants.dart';

class TodaySummery extends StatefulWidget {
  final String month;
  final String year;
  final int sale;
  final int diesel;
  final int employee;
  final int tea;
  final int other;
  final String date;
  final int discount;
  final String day;
  final double profit;

  TodaySummery(
      {this.month,
      this.year,
      this.sale,
      this.diesel,
      this.employee,
      this.tea,
      this.other,
      this.date,
      this.discount,
      this.day,
      this.profit});

  @override
  _TodaySummeryState createState() => _TodaySummeryState();
}

class _TodaySummeryState extends State<TodaySummery> {
  Widget _myRaisedButtonSibmit() {
    return MyRaisedButton(
      onPressed: () {
        _saveData();
        _savePayCash();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AddData()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Submit',
      roundedBorde: true,
    );
  }

  Widget _myRaisedButtonCancel() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RaigamHome()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Cancel',
      roundedBorde: true,
    );
  }

  void _saveData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference = Firestore.instance
          .collection('Raigam')
          .document(widget.year)
          .collection('Month')
          .document(widget.month)
          .collection('Day')
          .document(widget.date);
      Map<String, dynamic> data = <String, dynamic>{
        'Sale': widget.sale,
        'Diesel': widget.diesel,
        'Employee': widget.employee,
        'Tea': widget.tea,
        'Other Cost': widget.other,
        'Date': widget.date,
        'Disccount': widget.discount,
        'Profit': widget.profit,
        'Cheque Value':0,
        'Credit Value':0,
        'Various':0,
        'TPayCash':0,
      };
      await reference.setData(data);
    });
  }

  _savePayCash() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference =
          Firestore.instance.collection('Raigam PayCash Credit').document();
      Map<String, dynamic> data = <String, dynamic>{
        'Pay Cash': 0,
        'Date': widget.date,
        'IN': 123456789,
      };
      await reference.setData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true, title: Text(widget.date)),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Summery Of Today', style: headerStyle),
            ),
            ReuseText(label: 'Sale', value: widget.sale),
            ReuseText(label: 'Profit', value: widget.profit.toInt()),
            ReuseText(label: 'Disccount', value: widget.discount),
            ReuseText(label: 'Diesel', value: widget.diesel),
            ReuseText(label: 'Employee', value: widget.employee),
            ReuseText(label: 'Tea', value: widget.tea),
            ReuseText(label: 'Other cost', value: widget.other),
            _myRaisedButtonSibmit(),
            _myRaisedButtonCancel(),
          ]),
    );
  }
}

class ReuseText extends StatelessWidget {
  final int value;
  final String label;

  const ReuseText({Key key, this.value, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        '$label: ' + value.toString(),
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
