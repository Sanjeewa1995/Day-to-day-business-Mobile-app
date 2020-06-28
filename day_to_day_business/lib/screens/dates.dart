import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detail_page.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'enter_data.dart';
import 'dart:async';


class Dates extends StatefulWidget {
  final String month;
  final String year;
  Dates({this.month , this.year});

  _DatesState createState() => _DatesState(month , year);
}

class _DatesState extends State<Dates> {
  String month;
  String year;
  _DatesState(this.month , this.year);
  Future _data;

  Future getDate() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Wijaya').document(year).collection('Month').document(month).collection('Day').getDocuments();
    return qn.documents;

  }
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(post: post,)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = getDate();
  }


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
                itemCount:  snapshot.data.length,
                itemBuilder: (context , index){
                return ListTile(
                  title:Center(child: Text(snapshot.data[index].data['Date'],
                  style: TextStyle(
                    fontSize:30.0,
                    backgroundColor:Colors.blue[400],
                    color: Colors.white,
                  ),
                  )),
                  onTap: ()=> navigateToDetail(snapshot.data[index]),
                ) ;
                },
              );
            }
        }
      )
    ));
  }
}