import 'package:day_to_day_business/screens/credit_summery.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class AddCredit extends StatefulWidget {
  AddCredit({Key key}) : super(key: key);

  _AddCreditState createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String pNumber;
  String invoice;
  int cValue;
  String adress;

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
      labelText: 'Name Of The Owner',
      hintText: 'Enter Name',
    );
  }

   Widget _buildPNumber(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Phone Number is required';
        }
        return null;
      },
      onSaved: (String value){
        pNumber = value;
      },
      labelText: 'Phone Number',
      hintText: 'Enter Phone Number',
    );
  }

   Widget _buildInvoice(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Invoice is required';
        }
        return null;
      },
      onSaved: (String value){
        invoice = value;
      },
      labelText: 'Invoice Number',
      hintText: 'Enter Invoice Number',
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
        cValue=  int.parse(value);
      },
      labelText: 'Value of Bill',
      hintText: 'Enter Value',
      keyboardType:TextInputType.number,
    );
  }

  Widget _buildAdress(){
    return MyTextFormField(
      validator:(String value){
        if(value.isEmpty){
          return 'Adress is required';
        }
        return null;
      },
      onSaved: (String value){
        adress =  value;
      },
      labelText: 'Adress Of The Owner',
      hintText: 'Enter Adress',
    );
  }

   _myRaisedButton(){
    return MyRaisedButton(
      onPressed:(){
        if(!_formKey.currentState.validate()){
                  return;
                  }
                    _formKey.currentState.save();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreditSummery(
                          month: _month,
                          year:_year,
                          name: name,
                          pNumber: pNumber,
                          cValue: cValue,
                          invoice:invoice,
                          date:_date,
                          day:_date,
                          adress:adress,
                        )));
      },
      size: 200.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Check Credit',
      roundedBorde: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title:Text('Add Check')
      ),
      body: Form(
        key: _formKey,
        child:ListView(children: <Widget>[
          SizedBox(height:20.0),
          _selectDateButton(),
          SizedBox(height:20.0),
          _buildName(),
          _buildAdress(),
          _buildPNumber(),
          _buildInvoice(),
          _buildValue(),
          SizedBox(height:20.0),
          _myRaisedButton()
        ],)
      ),
    );
  }
}