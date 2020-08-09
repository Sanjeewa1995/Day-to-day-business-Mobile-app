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

  CreditSummery(
      {this.cValue,
      this.date,
      this.day,
      this.invoice,
      this.month,
      this.name,
      this.pNumber,
      this.year,
      this.adress});

  _CreditSummeryState createState() => _CreditSummeryState();
}

class _CreditSummeryState extends State<CreditSummery> {
  Stream tSummery;
  int tCredit = 0;

  Future<Stream<QuerySnapshot>> getTCredit() async {
    var firestore = Firestore.instance;
    // ignore: await_only_futures
    Stream<QuerySnapshot> qn = await firestore
        .collection('Wijaya Credit')
        .where('Date', isEqualTo: widget.date)
        .snapshots();
    return qn;
  }

  @override
  void initState() {
    super.initState();
    getTCredit().then((result) {
      setState(() {
        tSummery = result;
      });
    });
  }

  void _saveData1() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference = Firestore.instance
          .collection('Wijaya')
          .document(widget.year)
          .collection('Month')
          .document(widget.month)
          .collection('Day')
          .document(widget.date);
      Map<String, dynamic> data = <String, dynamic>{
        'Credit Value': tCredit + widget.cValue,
      };
      await reference.updateData(data);
    });
  }

  void _saveData2() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference =
          Firestore.instance.collection('Wijaya Credit').document();
      Map<String, dynamic> data = <String, dynamic>{
        'Name': widget.name,
        'Adress': widget.adress,
        'Invoice Number': widget.invoice,
        'Credit Value': widget.cValue,
        'Phone Number': widget.pNumber,
        'Date': widget.date,
        'Pay Cash': 0,
        'Full Pay': false,
      };
      await reference.setData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: Color(0xFF57DAD7),
        appBar: AppBar(centerTitle: true, title: Text(widget.date)),
        body: StreamBuilder(
            stream: tSummery,
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
                        snapshot.data.documents[t].data['Credit Value'] != null
                            ? tCredit +=
                                snapshot.data.documents[t].data['Credit Value']
                            : tCredit += 0;
                        print(tCredit);
                        t++;
                      }
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30.0,),
                            Text(
                              'Summery Of Credit',
                              style: GoogleFonts.yanoneKaffeesatz(
                                fontSize: 40.0,
                                color: Hexcolor('0f3057'),
                              ),
                            ),
                            ReUseText('Name of Owner: ' + widget.name),
                            ReUseText('Adress of Owner: ' + widget.adress),
                            ReUseText('Invoice Number: ' + widget.invoice),
                            ReUseText(
                                'Phone Number: ' + widget.pNumber.toString()),
                            ReUseText(
                                'Value Of Credit: ' + widget.cValue.toString()),
                            ReUseButton(
                              label: 'Submit',
                              onTap: () {
                                _saveData1();
                                _saveData2();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              },
                            ),
                            ReUseButton(
                              label: 'Cancle',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCredit()));
                              },
                            ),
                           // Expanded(child: Container(width: MediaQuery.of(context).size.width, height: 10.0,),),
                          ]);
                    });
              }
            }));
  }
}

class ReUseButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const ReUseButton({Key key, this.label, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: MyRaisedButton(
        onPressed: onTap,
        size: 250.0,
        textColor: Colors.white,
        label: label,
        roundedBorde: true,
      ),
    );
  }
}

class ReUseText extends StatelessWidget {
  final label;

  const ReUseText(
    this.label,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
