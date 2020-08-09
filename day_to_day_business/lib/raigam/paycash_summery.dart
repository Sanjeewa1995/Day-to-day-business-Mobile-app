import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/raigam/home.dart';

class PayCashSummery extends StatefulWidget {
  final String invoiceNumber;
  PayCashSummery({this.invoiceNumber});

  _PayCashSummeryState createState() => _PayCashSummeryState(invoiceNumber);
}

class _PayCashSummeryState extends State<PayCashSummery> {
  final String invoiceNumber;
  _PayCashSummeryState(this.invoiceNumber);

  Stream paySummery;

  getPayCash() async {
    var firestore = Firestore.instance;
    var qn = await firestore
        .collection('Raigam PayCash Credit')
        .where('IN', isEqualTo: invoiceNumber)
        .snapshots();
    print(qn);
    return qn;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPayCash().then((result) {
      print('object');
      setState(() {
        paySummery = result;
      });
    });
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
                    context, MaterialPageRoute(builder: (context) => RaigamHome()));
              })
        ],
        centerTitle: true,
        title: Text('Summery of pay cash bile'),
      ),
      body: Container(
          child: StreamBuilder(
              stream: paySummery,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Loading'));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blue,
                          child: ListTile(
                            leading: Text(
                              snapshot.data.documents[index].data['Date'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(snapshot
                                .data.documents[index].data['Pay Cash']
                                .toString()),
                          ),
                        );
                      });
                }
              })),
    );
  }
}
