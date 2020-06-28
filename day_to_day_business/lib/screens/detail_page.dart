import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'home.dart';

class Detail extends StatefulWidget {
  final DocumentSnapshot post;
  Detail({this.post});

  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String disccount ;

    _myRaisedButtonHome(){
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
      label: 'Home',
      roundedBorde: true,
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text(widget.post.data['Date'])
          ),
          body: Container(
            margin: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 10.0),
            child:ListView(
              children: <Widget>[
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
                Text('Sale: ' + widget.post.data['Sale'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                SizedBox(height:20.0),
                Text('Discount: ' +widget.post.data['Disccount'].toString() ,
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Diesel: ' + widget.post.data['Diesel'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Employee: ' +widget.post.data['Employee'].toString()  ,
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Tea: ' + widget.post.data['Tea'].toString(),
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),
                  SizedBox(height:20.0),
                Text('Other Cost: ' +widget.post.data['Other Cost'].toString() ,
                  style: TextStyle(
                  fontSize:20.0
                  ),
                ),]),),
                SizedBox(height:40.0),
                _myRaisedButtonHome()
              ],
            ),
          )
    );
  }
}