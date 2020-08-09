import 'package:day_to_day_business/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'dart:convert';

class TSummery extends StatefulWidget {
  final int tCash;
  final String year;
  final String month;
  final String day;
  final String date;
  final int sumCheck;

  TSummery(
      {this.tCash, this.year, this.month, this.date, this.day, this.sumCheck});

  _TSummeryState createState() =>
      _TSummeryState(tCash, year, month, day, date, sumCheck);
}

class _TSummeryState extends State<TSummery> {
  final int tCash;
  final String year;
  final String month;
  final String day;
  final String date;
  final int sumCheck;

  _TSummeryState(
      this.tCash, this.year, this.month, this.day, this.date, this.sumCheck);

  Stream tSummery;
  Stream tPayCashList;
  int sale = 0;
  double profit = 0;
  int disccount = 0;
  int diesel = 0;
  int employee = 0;
  int tea = 0;
  int otherCost = 0;
  int tCheck = 0;
  int getCredit = 0;
  int tCredit = 0;
  int income;
  int outcome;
  int various;
  int tPayCash = 0;

  getOwners() async {
    var firestore = Firestore.instance;
    var qn = await firestore
        .collection('Wijaya')
        .document(widget.year)
        .collection('Month')
        .document(widget.month)
        .collection('Day')
        .where('Date', isEqualTo: date)
        .snapshots();

    return qn;
  }

  // getTPayCash() async {
  //   var firestore = Firestore.instance;
  //   var qn = await firestore
  //       .collection('PayCash Credit')
  //       .where('Date', isEqualTo: date)
  //       .snapshots();
  //   return qn;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOwners().then((result) {
      setState(() {
        tSummery = result;
      });
    });
    // getTPayCash().then((value) {
    //   setState(() {
    //     tPayCashList = value;
    //   });
    // });
  }

  // _saveData() {
  //   Firestore.instance.runTransaction((Transaction transaction) async {
  //     DocumentReference reference = Firestore.instance
  //         .collection('Wijaya Full Day Summery')
  //         .document(year)
  //         .collection('Month')
  //         .document(month)
  //         .collection('Day')
  //         .document(day);
  //     Map<String, dynamic> data = <String, dynamic>{
  //       'Sale': sale,
  //       'Profit': profit,
  //       'Disccount': disccount,
  //       'Diesel': diesel,
  //       'Employee': employee,
  //       'Tea': tea,
  //       'Other Cost': otherCost,
  //       'Outcome': outcome,
  //       'Check Value': tCheck,
  //       'Cash': tCash,
  //       'Various': various,
  //       'Credit Bill': tCredit,
  //       'Get Credit': getCredit,
  //     };
  //     await reference.setData(data);
  //   });
  // }

  _saveData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference = Firestore.instance
          .collection('Wijaya')
          .document(year)
          .collection('Month')
          .document(month)
          .collection('Day')
          .document(date);
      Map<String, dynamic> data = <String, dynamic>{
        'Various': various,
        'TPayCash': tPayCash,
      };
      await reference.updateData(data);
    });
  }

  _myRaisedButtonSibmit() {
    return MyRaisedButton(
      onPressed: () {
        _saveData();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Submit',
      roundedBorde: true,
    );
  }

// var paySnapshot = Firestore.instance
//                 .collection('PayCash Credit')
//                 .where('Date', isEqualTo: widget.date)
//                 .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF57DAD7),
        appBar: AppBar(title: Text('Full Summery')),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('PayCash Credit')
                .where('Date', isEqualTo: date)
                .snapshots(),
            builder: (context, AsyncSnapshot paySnapshot) {
              if (!paySnapshot.hasData) {
                return new Text("Loading");
              }
              print(paySnapshot.data.documents.length);
              tPayCash = 0;
              int t = 0;
              for (int i = 1; i <= paySnapshot.data.documents.length; i++) {
                tPayCash += paySnapshot.data.documents[t].data['Pay Cash'];
                t++;
              }
              print(tPayCash.toString());
              return StreamBuilder(
                  stream: tSummery,
                  builder: (context, snapshot) {
                    //        if (snapshot.hasError || paySnapshot.hasError || !snapshot.hasData)
                    // return new Text('error');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Loading'));
                    } else {
                      return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            int t = 0;
                            for (int i = 1;
                                i <= snapshot.data.documents.length;
                                i++) {
                              snapshot.data.documents[t].data['Cheque Value'] != null
                                  ? tCheck +=
                                      snapshot.data.documents[t].data['Cheque Value']
                                  : tCheck += 0;
                              snapshot.data.documents[t].data['Profit'] != null
                                  ? profit +=
                                      snapshot.data.documents[t].data['Profit']
                                  : profit += 0;
                              snapshot.data.documents[t].data['Disccount'] !=
                                      null
                                  ? disccount += snapshot
                                      .data.documents[t].data['Disccount']
                                  : disccount += 0;
                              // snapshot.data.documents[t].data['Credit Value'] != null
                              //     ? tCredit +=
                              //         snapshot.data.documents[t].data['Credit Value']
                              //     : tCredit += 0;
                              snapshot.data.documents[t].data['Pay Cash'] !=
                                      null
                                  ? getCredit += snapshot
                                      .data.documents[t].data['Pay Cash']
                                  : getCredit += 0;
                              snapshot.data.documents[t].data['Sale'] != null
                                  ? sale +=
                                      snapshot.data.documents[t].data['Sale']
                                  : sale += 0;
                              snapshot.data.documents[t].data['Diesel'] != null
                                  ? diesel +=
                                      snapshot.data.documents[t].data['Diesel']
                                  : diesel += 0;
                              snapshot.data.documents[t].data['Employee'] !=
                                      null
                                  ? employee += snapshot
                                      .data.documents[t].data['Employee']
                                  : employee += 0;
                              snapshot.data.documents[t].data['Tea'] != null
                                  ? tea +=
                                      snapshot.data.documents[t].data['Tea']
                                  : tea += 0;

                              snapshot.data.documents[t].data['Other Cost'] !=
                                      null
                                  ? otherCost += snapshot
                                      .data.documents[t].data['Other Cost']
                                  : otherCost += 0;
                              t++;
                            }
                            int tCredit =
                                snapshot.data.documents[0].data['Credit Value'];
                            int tCheque =
                                snapshot.data.documents[0].data['Cheque Value'];
                            income = sale;
                            outcome = diesel + employee + tea + otherCost;
                            various = (income - outcome - tCheque - disccount) -
                                (tCash - 1000) -
                                tCredit +
                                 
                                getCredit + tPayCash;
                            return Column(children: <Widget>[
                              SizedBox(height: 20.0),
                              Center(
                                child: Text(
                                  ' Full Summery Of Today',
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
                                    'Sale: ' + sale.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    'OutCome: ' + outcome.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    'Check Value: ' + tCheck.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    'Credit Bill Value: ' + tCredit.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    'Cash: ' + tCash.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    'Credit bill pay cash: ' + tPayCash.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                   SizedBox(height: 20.0),
                                  Text(
                                    'Various: ' + various.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ]),
                              ),
                              SizedBox(height: 30.0),
                              _myRaisedButtonSibmit(),
                              SizedBox(height: 15.0),
                            ]);
                          });
                    }
                  });
            }));
  }
}
