import 'package:day_to_day_business/screens/add_credit.dart';
import 'package:day_to_day_business/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CreditSummery extends StatefulWidget {
  final String name;
  final String pNumber;
  final String invoice;
  final int cValue;
  final String date;
  final String year;
  final String month;
  final String day;
  final String adress;

  CreditSummery({this.cValue, this.date, this.day, this.invoice, this.month, this.name, this.pNumber, this.year, this.adress});

  _CreditSummeryState createState() => _CreditSummeryState(cValue, date, day, invoice, month, name, pNumber, year, adress);
}

class _CreditSummeryState extends State<CreditSummery> {
  final String name;
  final String pNumber;
  final String invoice;
  final int cValue;
  final String date;
  final String year;
  final String month;
  final String day;
  final String adress;

  _CreditSummeryState(this.cValue, this.date, this.day, this.invoice, this.month, this.name, this.pNumber, this.year, this.adress);

    _saveData1(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Cash Setle').document();
                      Map<String, dynamic> data= <String, dynamic>{
                        'Name' : name,
                        'Adress': adress,
                        'Invoice Number': invoice,
                        'Credit Value': cValue,
                        'Phone Number': pNumber,
                        'Date' : date,
                      };
                      await reference.setData(data);
                    });
  }

    _saveData2(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Wijaya Credit').document();
                      Map<String, dynamic> data= <String, dynamic>{
                        'Name' : name,
                        'Adress': adress,
                        'Invoice Number': invoice,
                        'Credit Value': cValue,
                        'Phone Number': pNumber,
                        'Date' : date,
                        'Pay Cash': 0,
                      };
                      await reference.setData(data);
                    });
  }

    _myRaisedButtonSubmit(){
    return MyRaisedButton(
      onPressed:(){
        _saveData1();
        _saveData2();
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home()));
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
                        builder: (context) => AddCredit()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Cancel',
      roundedBorde: true,
    );}

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
                  child: Text('Summery Of Credit',
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
                Text('Invoice Number: ' + invoice,
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Phone Number: ' + pNumber.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Value Of Credit: ' + cValue.toString(),
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