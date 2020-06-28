import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 't_summery.dart';

class CashSetle extends StatefulWidget {
  CashSetle({Key key}) : super(key: key);

  _CashSetleState createState() => _CashSetleState();
}

class _CashSetleState extends State<CashSetle> {

  int cash5000;
  int cash1000;
  int cash500;
  int cash100;
  int cash50;
  int cash20;
  int coin;
  int tCash;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

    _selectDate(){
    return MyRaisedButton(
      onPressed:(){
      _dateFlicker();
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: _date,
      roundedBorde: false,
    );}

    Widget _build5000(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'cash is required';
        }
        return null;
      },
      onSaved: (String value){
        cash5000 = int.parse(value)*5000;
      },
      labelText: '5000',
      hintText: 'Enter number of 5000',
    );
  }

   Widget _build1000(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'cash is required';
        }
        return null;
      },
      onSaved: (String value){
        cash1000 = int.parse(value)*1000;
      },
      labelText: '1000',
      hintText: 'Enter number of 1000',
    );
  }

   Widget _build500(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'cash is required';
        }
        return null;
      },
      onSaved: (String value){
        cash500 = int.parse(value)*500;
      },
      labelText: '500',
      hintText: 'Enter number of 500',
    );
  }

   Widget _build100(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'cash is required';
        }
        return null;
      },
      onSaved: (String value){
        cash100 = int.parse(value)*100;
      },
      labelText: '100',
      hintText: 'Enter number of 100',
    );
  }

   Widget _build50(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'cash is required';
        }
        return null;
      },
      onSaved: (String value){
        cash50 = int.parse(value)*50;
      },
      labelText: '50',
      hintText: 'Enter number of 50',
    );
  }

   Widget _build20(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'cash is required';
        }
        return null;
      },
      onSaved: (String value){
        cash20 = int.parse(value)*20;
      },
      labelText: '20',
      hintText: 'Enter number of 20',
    );
  }

   Widget _buildCoin(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'coin is required';
        }
        return null;
      },
      onSaved: (String value){
        coin = int.parse(value);
      },
      labelText: 'Totol value of coins',
      hintText: 'Enter totol value',
    );
  }

  _tCash(){
    tCash = cash5000 + cash100 + cash1000 + cash500 + cash50 + cash20 + coin;
  }

    _save(){
    return MyRaisedButton(
      onPressed:(){
        if(!_formKey.currentState.validate()){
                  return;
                  }
        _formKey.currentState.save();
        _tCash();
        if(tCash != null){
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TSummery(tCash:tCash , year:_year , month:_month, day:_day, date:_date,)));
        } else{
          Text('Loding......');
        }
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Submit',
      roundedBorde: true,
    );}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title:Text('Cash Setle')
      ),
      body: ListView(children: <Widget>[
        SizedBox(height:10.0),
        _selectDate(),
        SizedBox(height:15.0),
        Center(
          child: Text('Enter Cash',
          style: TextStyle(
            fontSize:20.0,
          ),
          ),
        ),
        Form(
          key:_formKey ,
          child: Column(children: <Widget>[
          _build5000(),
          _build1000(),
          _build500(),
          _build100(),
          _build50(),
          _build20(),
          _buildCoin(),
        ],)),
          _save(),
      ],));
  }
}