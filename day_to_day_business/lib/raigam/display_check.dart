
import 'package:day_to_day_business/raigam/cheque_bdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';

import 'package:day_to_day_business/raigam/cheque_owner_search.dart';

class DisplayCheck extends StatefulWidget {
  DisplayCheck({Key key}) : super(key: key);

  _DisplayCheckState createState() => _DisplayCheckState();
}

class _DisplayCheckState extends State<DisplayCheck> {

  String _date;

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
    
    });
  }

   _selectBankDateButton(){
    return MyRaisedButton(
      onPressed:(){
        _dateFlicker();
          if( _date != null){
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckBankDate( date: _date,)));
        } else{
          Text('Loging.......');
        }
      },
      color:Colors.blue,
      size:300.0,
      label: 'Bank Date',
      roundedBorde: false,

    );
  }

  _owner() {
    return MyRaisedButton(
      onPressed: () {
        showSearch(context: context, delegate: UseSearchDelegate());
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
    return Scaffold(
        appBar: AppBar(title: Text('Check')),
        body: Form(
            child: ListView(
          children: <Widget>[
            SizedBox(height: 30.0),
            _selectBankDateButton(),
            SizedBox(height: 10.0),
            _owner()
          ],
        )));
  }
}
