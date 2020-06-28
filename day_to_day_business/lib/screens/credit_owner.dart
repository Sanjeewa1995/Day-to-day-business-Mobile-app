import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class CreditOwner extends StatefulWidget {
  final String name;
  CreditOwner({this.name});

  _CreditOwnerState createState() => _CreditOwnerState(name);
}

class _CreditOwnerState extends State<CreditOwner> {
  final String name;
  _CreditOwnerState(this.name);

  Stream owners;
  int newPayCash;
  int tPayCash;
  String invoiceN;
  String payDoc;

   String _date = DateFormat.yMMMMd().format( DateTime.now());
  String _month =  DateFormat().add_M().format(DateTime.now());
  String _year =DateTime.now().year.toString();
  String _day =DateTime.now().day.toString();

  _dateFlicker() async{
    DateTime _dateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 16,
      theme: ThemeData.dark()
    );
    setState(() {
      _date =  DateFormat.yMMMMd().format( _dateTime);
      _month = DateFormat().add_M().format( _dateTime);
      _year =_dateTime.year.toString();
      _day =_dateTime.day.toString();
    });
  }

  getOwners() async {
    var firestore = Firestore.instance;
    var  qn = await firestore.collection('Wijaya Credit').where('Name' , isEqualTo: name).snapshots();
    return qn;
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
      getOwners().then((result){
        setState(() {
          owners = result;
        });
      });
  }

  _updateData(selectDoc , newValue){
      Firestore.instance.collection('Wijaya Credit').document(selectDoc).updateData(newValue);
    }

     _updateData1(){
      Firestore.instance.collection('Wijaya Credit').document(payDoc).updateData({_date:_date});
    }

    Future _updateDialog(BuildContext context )async{
      return showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text('Add Pay Cash'),
            content: TextField(
              decoration:InputDecoration(hintText:'Enter pay Amount'),
              onChanged:(value){
                newPayCash = int.parse(value);
              },
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              )
            ],
          );
        }
        );
    }

       _saveData(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Cash Setle').document();
                      Map<String, dynamic> data= <String, dynamic>{
                        'Pay Cash' : newPayCash,
                        'Date': _date,
                      };
                      await reference.setData(data);
                    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            padding: EdgeInsets.only(right:20.0),
            tooltip: 'Go Home',
            iconSize: 30.0,
            onPressed: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home()));
          })
        ],
        centerTitle: true,
        title: Text('Owners'),
      ),
      body: Container(
      child:StreamBuilder(
        stream: owners,
        builder:(context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child:Text('Loading')
            );
          } else{
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context , index){
                 
                //  bool cashOk = snapshot.data.documents[index].data['Cash ok'];
                  return Container(
                      color: Hexcolor('5fdde5'),
                      margin: EdgeInsets.all(20.0),
                      width:300.0,
                      height:300.0,
                      child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                        SizedBox(height:10.0),
                        Text('Name: ' + snapshot.data.documents[index].data['Name'],
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                        Text('Adress: ' + snapshot.data.documents[index].data['Adress'],
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                          Text('Invoice Number: ' + snapshot.data.documents[index].data['Invoice Number'].toString(),
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                          Text('Phone Number: ' + snapshot.data.documents[index].data['Phone Number'],
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                        Text('Value: ' + snapshot.data.documents[index].data['Credit Value'].toString(),
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                        Text('Pay Cash: ' +snapshot.data.documents[index].data['Pay Cash'].toString(),
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          ),
                          ),
                          SizedBox(height:10.0),
                          Container(
                            height: 40.0,
                            width: 1000.0,
                            child:  RaisedButton(
                              onPressed: (){
                                _updateDialog(context );
                                _dateFlicker();
                              },
                              child: Text('Add Pay'),
                              )
                          ),
                          Container(
                            child:RaisedButton(
                              onPressed:(){
                                  payDoc= snapshot.data.documents[index].documentID;
                                  invoiceN = snapshot.data.documents[index].data['Invoice Number'];
                                  tPayCash = snapshot.data.documents[index].data['Pay Cash'];
                                  _updateData(snapshot.data.documents[index].documentID , {'Pay Cash':tPayCash + newPayCash} );
                                  _updateData1();
                                  _saveData();
                              },
                              child: Text('Update'),
                              )
                          )
                        //   Checkbox(
                        //   value: cashOk,
                        //   onChanged: (bool val){
                        //     _updateData(snapshot.data.documents[index].documentID, {'Cash ok':val});
                        //     },
                        //   activeColor: Colors.green,
                        // ),
                        
                      ],)
                    );
                }
                );
            }
        }
      )
    ) ,
    );
  }
}