import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckOwner extends StatefulWidget {
  final String name;
  CheckOwner({this.name});

  _CheckOwnerState createState() => _CheckOwnerState(name);
}

class _CheckOwnerState extends State<CheckOwner> {
  final String name;
  _CheckOwnerState(this.name);

  Stream owners;

    getOwners() async {
    var firestore = Firestore.instance;
    var  qn = await firestore.collection('Wijaya Cheque').where('Name' , isEqualTo: name).snapshots();
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
      Firestore.instance.collection('Wijaya Cheque').document(selectDoc).updateData(newValue);
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
                  bool cashOk = snapshot.data.documents[index].data['Cash ok'];
                  return Container(
                      color: Hexcolor('5fdde5'),
                      margin: EdgeInsets.all(20.0),
                      width:300.0,
                      height:250.0,
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
                          Text('Check Number: ' + snapshot.data.documents[index].data['Cheque Number'].toString(),
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                          Text('Bank Date: ' + snapshot.data.documents[index].data['Bank Date'],
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                        Text('Value: ' + snapshot.data.documents[index].data['Cheque Value'].toString(),
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          )
                        ),
                        SizedBox(height:10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                          Text('Cash Ok: ',
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.black,
                          ),
                          ),
                          Checkbox(
                          value: cashOk,
                          onChanged: (bool val){
                            _updateData(snapshot.data.documents[index].documentID, {'Cash ok':val});
                            },
                          activeColor: Colors.green,
                        ),
                        ]),
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