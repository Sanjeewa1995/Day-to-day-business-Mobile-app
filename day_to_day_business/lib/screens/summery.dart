



import 'package:day_to_day_business/screens/summery_of_date.dart';
import 'package:flutter/material.dart';
import 'data_enter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Summery extends StatefulWidget {
  Summery({Key key}) : super(key: key);

  _SummeryState createState() => _SummeryState();
}

class _SummeryState extends State<Summery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Summery')
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('summery').snapshots(),
        builder: (BuildContext context , snapshot){
      if(!snapshot.hasData) return CircularProgressIndicator();
      return FirestoreListView(documents:snapshot.data.documents );
        }));
  }
}

class FirestoreListView extends StatelessWidget {
   final List<DocumentSnapshot> documents;
  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (BuildContext context , int index){
        return ListTile(
          title: Container(
            padding:EdgeInsets.all(5.0),
            child:RaisedButton(
              onPressed: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>SummeryOfDate(
                        )));
              },
              child: Text(documents[index].data['date'].toString()),
              color: Colors.blue,
              textColor: Colors.white,
            )
          ),
        );
    });
  }
}






    


  