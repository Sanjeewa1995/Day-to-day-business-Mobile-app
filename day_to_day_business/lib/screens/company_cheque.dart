import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyCheque extends StatefulWidget {
  CompanyCheque({Key key}) : super(key: key);

  _CompanyChequeState createState() => _CompanyChequeState();
}

class _CompanyChequeState extends State<CompanyCheque> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int number;
  int cValue;
  var bankDate;

  var _date = DateTime.now();

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
      _date =   _dateTime;
    });
  }

    Widget _buildNumber(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Cheque Number is required';
        }
        return null;
      },
      onSaved: (String value){
        number = int.parse(value);
      },
      labelText: 'Cheque Number',
      hintText: 'Enter Number',
      keyboardType:TextInputType.number,
    );
  }

  Widget _buildValue(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Value is required';
        }
        return null;
      },
      onSaved: (String value){
        cValue = int.parse(value);
      },
      labelText: 'Value Of Cheque',
      hintText: 'Enter Value',
      keyboardType:TextInputType.number,
    );
  }

   _selectDateButton(){
    return MyRaisedButton(
      onPressed:(){
        _dateFlicker();
      },
      color:Colors.blue,
      size:300.0,
      label: 'Select Bank Date',
      roundedBorde: false,

    );
  }

    _saveData1(){

    Firestore.instance.runTransaction((Transaction transaction) async{
                      DocumentReference reference =  Firestore.instance.collection('Wijaya Cheque').document();
                      Map<String, dynamic> data= <String, dynamic>{
                        'Check Number': number,
                        'Check Value': cValue,
                        'Bank Date': _date,
                        'status': 'scheduled'
                      };
                      await reference.setData(data);
                    });
  }

  _myRaisedButton(){
    return MyRaisedButton(
      onPressed:(){
        if(!_formKey.currentState.validate()){
                  return;
                  }
                    _formKey.currentState.save();
                    _saveData1();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home()));
      },
      size: 200.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Check Data',
      roundedBorde: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Company Cheque'),
      ),
      body:  Form(
        key: _formKey,
        child:ListView(children: <Widget>[
          SizedBox(height:20.0),
          _selectDateButton(),
          SizedBox(height:20.0),
          _buildNumber(),
          _buildValue(),
          SizedBox(height:20.0),
          _myRaisedButton()
        ],)
      ),
    );
  }
}