import 'package:day_to_day_business/screens/today_summery.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnterData extends StatefulWidget {
  EnterData({Key key}) : super(key: key);

  _EnterDataState createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterData> {

  int disccount;
  double profit;
  bool validDate ;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Model model = Model();
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

  _selectDateButton(){
    return MyRaisedButton(
      onPressed:(){
        _dateFlicker();
      },
      color:Colors.blue,
      size:300.0,
      label: _date,
      roundedBorde: false,

    );
  }

  Widget _buildSale(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Sale is required';
        }
        return null;
      },
      onSaved: (String value){
        model.sale = int.parse(value);
      },
      labelText: 'Sale',
      hintText: 'Enter Sale',
      keyboardType:TextInputType.number,
    );
  }

   Widget _buildDisccount(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Disccount is required';
        }
        return null;
      },
      onSaved: (String value){
        disccount = int.parse(value);
      },
      labelText: 'Disccount',
      hintText: 'Enter Disccount',
      keyboardType:TextInputType.number,
    );
  }

  Widget _buildDiesel(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Diesel cost is required';
        }
        return null;
      },
      onSaved: (String value){
        model.diesel= int.parse(value);
      },
      labelText: 'Diesel',
      hintText: 'Enter Diesel cost of today',
      keyboardType:TextInputType.number,
    );
  }

  Widget _buildEmployee(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Employee cost is required';
        }
        return null;
      },
      onSaved: (String value){
        model.employee= int.parse(value);
      },
      labelText: 'Employee',
      hintText: 'Enter employee cost of today',
      keyboardType:TextInputType.number,
    );
  }

   Widget _buildTea(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Tea is required';
        }
        return null;
      },
      onSaved: (String value){
        model.tea= int.parse(value);
      },
      labelText: 'Tea',
      hintText: 'Enter Tea cost of today',
      keyboardType:TextInputType.number,
    );
  }

  Widget _buildOther(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Other costs is required';
        }
        return null;
      },
      onSaved: (String value){
        model.other= int.parse(value);
      },
      labelText: 'Other Costs',
      hintText: 'Enter Other cost of today',
      keyboardType:TextInputType.number,
    );
  }

  _getFrofit(){
    profit =double.parse((model.sale * (7/100)).toStringAsFixed(2));
  }


  _myRaisedButton(){
    return MyRaisedButton(
      onPressed:(){
        if(!_formKey.currentState.validate()){
                  return;
                  }
                    _formKey.currentState.save();
                    _getFrofit();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodaySummery(
                          month: _month,
                          year:_year,
                          sale: model.sale,
                          diesel: model.diesel,
                          employee: model.employee,
                          tea: model.tea,
                          other: model.other,
                          date:_date,
                          discount:disccount,
                          day:_day,
                          profit:profit

                        )));
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
        backgroundColor: Color(0xFF2d4059),
      appBar:AppBar(
        centerTitle:true,
        title:Text('Today Data')
      ),
      body: Form(
          key: _formKey,
          child:ListView(
            children:<Widget>[
              SizedBox(height:10.0),
              _selectDateButton(),
                SizedBox(height:10.0),
              _buildSale(),
              _buildDisccount(),
              _buildDiesel(),
              _buildEmployee(),
              _buildTea(),
              _buildOther(),
              SizedBox(height:50.0),
              _myRaisedButton(),
            ]
          )
        )
    );
  }
}