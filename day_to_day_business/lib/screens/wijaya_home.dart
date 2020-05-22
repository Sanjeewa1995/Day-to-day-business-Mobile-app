import 'package:flutter/material.dart';

import 'data_enter.dart';

class WijayaHome extends StatelessWidget {
  const WijayaHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Home Page')
      ),
      body:Column(children: <Widget>[
        SizedBox(
          height: 200.0,
          width: 400.0,
          child: Image(image: AssetImage(
            'images/wijaya.jpg'
          )),
        ),
        SizedBox(
          height:30.0
        ),
        SizedBox(
          width:300.0,
          height:40.0,
          child:RaisedButton(
            onPressed:(){
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
            },
            child:Text('Enter Data',
              style:TextStyle(
                fontSize:30.0,
                color:Colors.white
              )),
            color: Colors.blue,
          )
        ),
          SizedBox(
          height:30.0
        ),
        SizedBox(
          width:300.0,
          height:40.0,
          child:RaisedButton(
            onPressed:(){

            },
            child:Text('Month Summery',
              style:TextStyle(
                fontSize:30.0,
                color:Colors.white
              )),
            color: Colors.blue,
          )
        ),
          SizedBox(
          height:30.0
        ),
        SizedBox(
          width:300.0,
          height:40.0,
          child:RaisedButton(
            onPressed:(){

            },
            child:Text('Total Summery',
              style:TextStyle(
                fontSize:30.0,
                color:Colors.white
              )),
            color: Colors.blue,
          )
        )
      ],)
    );
  }
}