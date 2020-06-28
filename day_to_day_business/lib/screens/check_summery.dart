import 'package:day_to_day_business/screens/add_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckSummery extends StatefulWidget {
  final String name;
  final int number;
  final int cValue;
  final String bDate;
  final String date;
  final String month;
  final String year;
  final String day;
  final String adress;

  CheckSummery({this.bDate, this.cValue, this.date, this.day, this.month, this.name, this.number, this.year, this.adress});

  _CheckSummeryState createState() => _CheckSummeryState(bDate, cValue, date, day, month, name, number, year, adress );
}

class _CheckSummeryState extends State<CheckSummery> {

  final String name;
  final int number;
  final int cValue;
  final String bDate;
  final String date;
  final String month;
  final String year;
  final String day;
  final String adress;

  _CheckSummeryState(this.bDate, this.cValue, this.date, this.day, this.month, this.name, this.number, this.year, this.adress);

    _myRaisedButtonSubmit(){
    return MyRaisedButton(
      onPressed:(){
        _saveData1();
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
                        builder: (context) => AddData()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Cancel',
      roundedBorde: true,
    );}

      _saveData1(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Cash Setle').document();
                      Map<String, dynamic> data= <String, dynamic>{
                        'Name' : name,
                        'Adress': adress,
                        'Check Number': number,
                        'Check Value': cValue,
                        'Bank Date': bDate,
                        'Date' : date,
                      };
                      await reference.setData(data);
                    });
  }

    _saveData2(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Wijaya Check').document();
                      Map<String, dynamic> data= <String, dynamic>{
                        'Name' : name,
                        'Adress': adress,
                        'Check Number': number,
                        'Check Value': cValue,
                        'Bank Date': bDate,
                        'Date' : date,
                        'Cash ok' : false,
                      };
                      await reference.setData(data);
                    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(date)
      ),
      body: ListView(
        children:<Widget>[
          SizedBox(height:20.0),
                Center(
                  child: Text('Summery Of Check',
                  style: GoogleFonts.yanoneKaffeesatz(
                    fontSize:40.0,
                    color: Hexcolor('0f3057'),
                  ),
                  ),
                ),
                Center(
                child: Column(children:<Widget>[
                SizedBox(height:20.0),
                Text('Name of Owner: ' + name,
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Adress of Owner: ' + adress,
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Check Number: ' + number.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Value Of Check: ' + cValue.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Bank Date: ' + bDate.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                ]),),
                SizedBox(height:30.0),
                _myRaisedButtonSubmit(),
                SizedBox(height:20.0),
                _myRaisedButtonCancel()
        ]
      ),
    );
  }
}