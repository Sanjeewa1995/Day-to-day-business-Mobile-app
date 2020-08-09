import 'package:day_to_day_business/raigam/add_data.dart';
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

  CheckSummery(
      {this.bDate,
      this.cValue,
      this.date,
      this.day,
      this.month,
      this.name,
      this.number,
      this.year,
      this.adress});

  _CheckSummeryState createState() => _CheckSummeryState();
}

class _CheckSummeryState extends State<CheckSummery> {

  _CheckSummeryState();

  Stream tSummery;
  int tCheque = 0;

  _myRaisedButtonSubmit() {
    return MyRaisedButton(
      onPressed: () {
        _saveData1();
        _saveData2();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddData()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Submit',
      roundedBorde: true,
    );
  }

  _myRaisedButtonCancel() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddData()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Cancel',
      roundedBorde: true,
    );
  }

  _saveData1() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference = Firestore.instance
          .collection('Raigam')
          .document(widget.year)
          .collection('Month')
          .document(widget.month)
          .collection('Day')
          .document(widget.date);
      Map<String, dynamic> data = <String, dynamic>{
        'Cheque Value': tCheque + widget.cValue,
      };
      await reference.updateData(data);
    });
  }

  _saveData2() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference =
          Firestore.instance.collection('Raigam Cheque').document();
      Map<String, dynamic> data = <String, dynamic>{
        'Name': widget.name,
        'Adress': widget.adress,
        'Cheque Number': widget.number,
        'Cheque Value': widget.cValue,
        'Bank Date': widget.bDate,
        'Date': widget.date,
        'Cash ok': false,
      };
      await reference.setData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.date)),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Raigam Cheque')
                .where('Date', isEqualTo: widget.date)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading'));
              } else {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      print(snapshot.data.documents.length.toString());
                      int t = 0;
                      for (int i = 1;
                          i <= snapshot.data.documents.length;
                          i++) {
                        snapshot.data.documents[t].data['Cheque Value'] != null
                            ? tCheque +=
                                snapshot.data.documents[t].data['Cheque Value']
                            : tCheque += 0;
                        print(tCheque);
                        t++;
                      }
                      return Column(children: <Widget>[
                        SizedBox(height: 20.0),
                        Center(
                          child: Text(
                            'Summery Of Cheque',
                            style: GoogleFonts.yanoneKaffeesatz(
                              fontSize: 40.0,
                              color: Hexcolor('0f3057'),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(children: <Widget>[
                            SizedBox(height: 20.0),
                            Text(
                              'Name of Owner: ' + widget.name,
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Adress of Owner: ' + widget.adress,
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Check Number: ' + widget.number.toString(),
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Value Of Check: ' + widget.cValue.toString(),
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Bank Date: ' + widget.bDate.toString(),
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ]),
                        ),
                        SizedBox(height: 30.0),
                        _myRaisedButtonSubmit(),
                        SizedBox(height: 20.0),
                        _myRaisedButtonCancel()
                      ]);
                    });
              }
            }));
  }
}
