import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/raigam/home.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckBankDate extends StatefulWidget {
  final String date;
  CheckBankDate({this.date});

  _CheckBankDateState createState() => _CheckBankDateState(date);
}

class _CheckBankDateState extends State<CheckBankDate> {
  final String date;
  _CheckBankDateState(this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              padding: EdgeInsets.only(right: 20.0),
              tooltip: 'Go Home',
              iconSize: 30.0,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RaigamHome()));
              })
        ],
        centerTitle: true,
        title: Text(date),
      ),
      body: Container(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Raigam Cheque')
                  .where('Bank Date', isEqualTo: date)
                  .where('Cash ok', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Loading'));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Container(
                            color: Hexcolor('5fdde5'),
                            margin: EdgeInsets.all(20.0),
                            width: 300.0,
                            height: 250.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                    'Name: ' +
                                        snapshot
                                            .data.documents[index].data['Name'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 10.0),
                                Text(
                                    'Adress: ' +
                                        snapshot.data.documents[index]
                                            .data['Adress'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 10.0),
                                Text(
                                    'Check Number: ' +
                                        snapshot.data.documents[index]
                                            .data['Cheque Number']
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 10.0),
                                Text(
                                    'Bank Date: ' +
                                        snapshot.data.documents[index]
                                            .data['Bank Date'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 10.0),
                                Text(
                                    'Value: ' +
                                        snapshot.data.documents[index]
                                            .data['Cheque Value']
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 10.0),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[]),
                              ],
                            ));
                      });
                }
              })),
    );
  }
}
