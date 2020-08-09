import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/raigam/home.dart';

class MonthWiseSummery extends StatefulWidget {
  final String year;
  final String month;
  final String day;
  final String date;

  MonthWiseSummery({this.year, this.month, this.date, this.day});

  _MonthWiseSummeryState createState() => _MonthWiseSummeryState(year, month, date, day);
}

class _MonthWiseSummeryState extends State<MonthWiseSummery> {
  final String year;
  final String month;
  final String day;
  final String date;

  _MonthWiseSummeryState(this.year, this.month, this.date, this.day);
  Future _data;
  int tSale=0;
  int tDisccount =0;
  int tDiesel = 0;
  int tEmployee =0;
  int tTea =0;
  int tOther =0;
  double tProfit =0;

  Future getDate() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Raigam').document(year).collection('Month').document(month).collection('Day').getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = getDate();
  }

  _myRaisedButtonHome(){
    return MyRaisedButton(
      onPressed:(){
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RaigamHome()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Home',
      roundedBorde: true,
    );}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title:Text(month)
    ),
    body: Container(
      child:FutureBuilder(
        future: _data,
        builder:(context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child:Text('Loading')
            );
          } else{
              return ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                itemCount: 1,
                itemBuilder: (context , index){
                  int count =0;
                  for(int i=1; i<=snapshot.data.length; i++){
                    tSale += snapshot.data[count].data['Sale'];
                    tDisccount += snapshot.data[count].data['Disccount'];
                    tDiesel += snapshot.data[count].data['Diesel'];
                    tEmployee += snapshot.data[count].data['Employee'];
                    tTea += snapshot.data[count].data['Tea'];
                    tOther += snapshot.data[count].data['Other Cost'];
                    tProfit += snapshot.data[count].data['Profit'];
                    count++;
                  }
                  return  Column(
          children:<Widget>[
                SizedBox(height:20.0),
                Center(
                  child: Text('Summery Of Month',
                  style: GoogleFonts.yanoneKaffeesatz(
                    fontSize:40.0,
                    color: Hexcolor('0f3057'),
                  ),
                  ),
                ),
                  Center(
                child: Column(children:<Widget>[
                SizedBox(height:20.0),
                Text('Sale: ' + tSale.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Profit: ' + tProfit.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Discount: ' + tDisccount.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Diesel: ' + tDiesel.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Employee: ' + tEmployee.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Tea: ' + tTea.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Other Cost: ' + tOther.toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),]),),
                SizedBox(height:40.0),
                _myRaisedButtonHome()
          ]
        );
                },
              );
            }
        }
      )
    ));
  }
}