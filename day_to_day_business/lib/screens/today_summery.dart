import 'package:day_to_day_business/screens/add_data.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

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

  TodaySummery({this.month , this.year , this.sale, this.diesel, this.employee, this.tea, this.other, this.date, this.discount, this.day, this.profit});


  @override
  _TodaySummeryState createState() => _TodaySummeryState(month, year, sale, diesel, employee, tea, other, date, discount, day, profit);
}

class _TodaySummeryState extends State<TodaySummery> {
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

  _TodaySummeryState(this.month , this.year , this.sale, this.diesel, this.employee, this.tea, this.other, this.date, this.discount, this.day, this.profit);

  int tSale =0;

  _myRaisedButtonSibmit(){
    return MyRaisedButton(
      onPressed:(){
        _saveData();
        _saveData2();
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddData()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Submit',
      roundedBorde: true,
    );}

    _myRaisedButtonCancel(){
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
      label: 'Cancel',
      roundedBorde: true,
    );}

    _saveData(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Wijaya').document(year).
                      collection('Month').document(month).collection('Day').document(date);
                      Map<String, dynamic> data= <String, dynamic>{
                        'Sale' : sale,
                        'Diesel': diesel,
                        'Employee': employee,
                        'Tea': tea,
                        'Other Cost': other,
                        'Date' : date,
                        'Disccount': discount,
                        'Profit' :profit,
                      };
                      await reference.setData(data);
                    });
  }

    _saveData2(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Cash Setle').document();
                      Map<String, dynamic> data= <String, dynamic>{
                        'Sale' : sale,
                        'Diesel': diesel,
                        'Employee': employee,
                        'Tea': tea,
                        'Other Cost': other,
                        'Date' : date,
                        'Disccount': discount,
                         'Profit' :profit,
                      };
                      await reference.setData(data);
                    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title:Text(date)
      ),
      body: ListView(
      //  padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
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
                Text('Sale: ' + sale.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Profit: ' + profit.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Discount: ' + discount.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Diesel: ' + diesel.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Employee: ' + employee.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Tea: ' + tea.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Other Cost: ' + other.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),]),),
                Text(tSale.toString()),
                SizedBox(height:30.0),
                _myRaisedButtonSibmit(),
                SizedBox(height:15.0),
                _myRaisedButtonCancel(),
        ]
      ),
    );
  }
}