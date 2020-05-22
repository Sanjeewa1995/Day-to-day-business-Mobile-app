
import 'summery.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 String date;
 String sale;
 String disccount;
 String diesel;
 String employee;
 String tea;
 String other;
 String idate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text('Day To Day Business')
        ),
      ),
      body:  ListView(
              children:<Widget>[
                SizedBox(height: 30.0,),
                Column(children: <Widget>[
                Center(
                  child:Text('Enter Date', style:TextStyle(
                  fontSize:30.0,
                  color:Colors.green
                  ))
                ),
                SizedBox(height:5.0),
                SizedBox(
                  width:300.0,
                  child:TextField(
                  keyboardType:TextInputType.number,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.blue,)
                    )
                  ),
                  onChanged: (String textinput){
                    date = textinput;
                  },
                  ),
                ),
          ],),
                SizedBox(height: 20.0,),
                Column(children: <Widget>[
                Center(
                  child:Text('Enter Sale', style:TextStyle(
                  fontSize:30.0,
                  color:Colors.green
                  ))
                ),
                SizedBox(height:5.0),
                SizedBox(
                  width:300.0,
                  child:TextField(
                  keyboardType:TextInputType.number,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black,)
                    )
                  ),
                  onChanged: (String textinput){
                    sale = textinput;
                  },
                  ),
                ),
                ],),
                SizedBox(height: 20.0,),
                Column(children: <Widget>[
                Center(
                  child:Text('Enter Disccount', style:TextStyle(
                  fontSize:30.0,
                  color:Colors.green
                  ))
                ),
                SizedBox(height:5.0),
                SizedBox(
                  width:300.0,
                  child:TextField(
                  keyboardType:TextInputType.number,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black,)
                    )
                  ),
                  onChanged: (String textinput){
                    disccount = textinput;
                  },
                  ),
                ),
                ],),
                SizedBox(height: 20.0,),
                Column(children: <Widget>[
                Center(
                  child:Text('Enter Diesel', style:TextStyle(
                  fontSize:30.0,
                  color:Colors.green
                  ))
                ),
                SizedBox(height:5.0),
                SizedBox(
                  width:300.0,
                  child:TextField(
                  keyboardType:TextInputType.number,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black,)
                    )
                  ),
                  onChanged: (String textinput){
                    diesel = textinput;
                  },
                  ),
                ),
                ],),
                SizedBox(height: 20.0,),
                Column(children: <Widget>[
                Center(
                  child:Text('Enter Employee', style:TextStyle(
                  fontSize:30.0,
                  color:Colors.green
                  ))
                ),
                SizedBox(height:5.0),
                SizedBox(
                  width:300.0,
                  child:TextField(
                  keyboardType:TextInputType.number,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black,)
                    )
                  ),
                  onChanged: (String textinput){
                    employee = textinput;
                  },
                  ),
                ),
                ],),
                SizedBox(height: 20.0,),
                Column(children: <Widget>[
                Center(
                  child:Text('Enter Tea', style:TextStyle(
                  fontSize:30.0,
                  color:Colors.green
                  ))
                ),
                SizedBox(height:5.0),
                SizedBox(
                  width:300.0,
                  child:TextField(
                  keyboardType:TextInputType.number,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black,)
                    )
                  ),
                  onChanged: (String textinput){
                    tea = textinput;
                  },
                  ),
                ),
                ],),
                SizedBox(height: 20.0,),
                Column(children: <Widget>[
                Center(
                  child:Text('Enter Others', style:TextStyle(
                  fontSize:30.0,
                  color:Colors.green
                  ))
                ),
                SizedBox(height:5.0),
                SizedBox(
                  width:300.0,
                  child:TextField(
                  keyboardType:TextInputType.number,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black,)
                    )
                  ),
                  onChanged: (String textinput){
                    other = textinput;
                  },
                  ),
                ),
                ],),
                SizedBox(height: 20.0,),
                SizedBox(
                  width: 100.0,
                  height: 40.0,
                  child:  RaisedButton(
                  onPressed:(){
                    Firestore.instance.runTransaction((Transaction transaction) async{
                    DocumentReference reference =  Firestore.instance.collection('summery').document(date);
                    Map<String, String> data= <String, String>{
                      'date' : date,
                      'sale' : sale,
                      'disccount' : disccount,
                      'diesel' : diesel,
                      'employee' : employee,
                      'tea' : tea
                    };
                    await reference.setData(data);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Summery(),
                      ));
                  },
                  color:Colors.blue,
                  textColor:Colors.white,
                  child: Text('Submit', style: TextStyle(
                    fontSize:30.0
                  ),),
                  )
                ),
                SizedBox(height: 20.0,)
      ]
      ),
      );
  }
}
