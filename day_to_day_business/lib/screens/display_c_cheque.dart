import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class DisplayCompanyCheque extends StatefulWidget {
  DisplayCompanyCheque({Key key}) : super(key: key);

  _DisplayCompanyChequeState createState() => _DisplayCompanyChequeState();
}

class _DisplayCompanyChequeState extends State<DisplayCompanyCheque> {
  Stream cCheque;

  _updateData(selectDoc, newValue) {
    Firestore.instance
        .collection('Wijaya Company Cheque')
        .document(selectDoc)
        .updateData(newValue);
  }

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
                    context, MaterialPageRoute(builder: (context) => Home()));
              })
        ],
        centerTitle: true,
        title: Text('Company Cheque'),
      ),
      body: Container(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Wijaya Company Cheque')
                  .where('Cash ok', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Loading'));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        bool cashOk =
                            snapshot.data.documents[index].data['Cash ok'];
                        return Container(
                            color: Color(0xFF57DAD7),
                            margin: EdgeInsets.all(20.0),
                            width: 300.0,
                            height: 250.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                    'Bank Date: ' +
                                        snapshot.data.documents[index]
                                            .data['Unformat Bank Date']
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 10.0),
                                Text(
                                    'Cheque Number: ' +
                                        snapshot.data.documents[index]
                                            .data['Check Number']
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 10.0),
                                Text(
                                    'Value: ' +
                                        snapshot.data.documents[index]
                                            .data['Check Value']
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
                                    children: <Widget>[
                                      Text(
                                        'Cash Ok: ',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Checkbox(
                                        value: cashOk,
                                        onChanged: (bool val) {
                                          _updateData(
                                              snapshot.data.documents[index]
                                                  .documentID,
                                              {'Cash ok': val});
                                        },
                                        activeColor: Colors.green,
                                      ),
                                    ]),
                              ],
                            ));
                      });
                }
              })),
    );
  }
}
