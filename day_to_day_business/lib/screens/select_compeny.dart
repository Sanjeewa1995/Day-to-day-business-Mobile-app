import 'package:flutter/material.dart';
import 'wijaya_home.dart';

class SelectCompeny extends StatelessWidget {
  const SelectCompeny({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(height: 80.0,),
        Center(child:Text('Select Your Company',
          style: TextStyle(
            color: Colors.green,
            fontSize: 35.0,
          ),),),
        SizedBox(height: 50.0,),
        SizedBox(
          width: 300.0,
          height: 50.0,
          child: RaisedButton(
            onPressed: (){
              Navigator.push(context,   MaterialPageRoute(
                        builder: (context) => WijayaHome(),
                      ));
            },
            child: Text('Wijaya Products',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white
              ),
            ),
            color: Colors.blue,
          ),
        )
      ],),
    );
  }
}