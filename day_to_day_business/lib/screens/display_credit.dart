import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'credit_owner.dart';

class DisplayCredit extends StatefulWidget {
  DisplayCredit({Key key}) : super(key: key);

  _DisplayCreditState createState() => _DisplayCreditState();
}

class _DisplayCreditState extends State<DisplayCredit> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;

  Widget _buildName(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value){
        name = value;
      },
      labelText: 'Name',
      hintText: 'Enter Name Of Owner',
    );
  }

  _owner(){
    return MyRaisedButton(
      onPressed:(){
          if(!_formKey.currentState.validate()){
                  return;
                  }
              _formKey.currentState.save();
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreditOwner(name:name)));
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Search Owner',
      roundedBorde: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title:Text('Check')
      ),
      body:Form(
        key: _formKey,
        child: ListView(children: <Widget>[
        SizedBox(height:30.0),
        _buildName(),
        SizedBox(height:10.0),
        _owner()
      ],)
      )
    );
  }
}