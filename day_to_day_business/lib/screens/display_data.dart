import 'display_check.dart';
import 'package:day_to_day_business/screens/day_wise_summery.dart';
import 'package:day_to_day_business/screens/display_check.dart';
import 'package:day_to_day_business/screens/month_wise_summery.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'display_credit.dart';

class DisplayData extends StatefulWidget {
  DisplayData({Key key}) : super(key: key);

  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {

  String _date ;
  String _month =DateTime.now().month.toString();
  String _year =DateTime.now().year.toString();
  String _day =DateTime.now().day.toString();

  _dateFlicker() async{

    DateTime _dateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 16,
      theme: ThemeData.dark(),
    );
    setState(() {
      _date =  DateFormat.yMMMMd().format( _dateTime);
      _month = _dateTime.month.toString();
      _year =_dateTime.year.toString();
      _day =_dateTime.day.toString();
    });
  }

  _dayWiseSummery(){
    return MyRaisedButton(
      onPressed:(){
        _dateFlicker();
        if( _date != null){
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DayWiseSummery(year: _year, month: _month, day: _day, date: _date,)));
        } else{
          Text('Loging.......');
        }
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Day Wise Summery',
      roundedBorde: false,
    );
  }

  _monthWiseSummery(){
    return MyRaisedButton(
      onPressed:(){
        _dateFlicker();
        if(_date != null){
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MonthWiseSummery(year: _year, month: _month, day: _day, date: _date,)));
        } else{
          Text('Loding......');
        }
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Month Wise Summery',
      roundedBorde: false,
    );
  }

  _check(){
    return MyRaisedButton(
      onPressed:(){
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayCheck()));
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Summery Of Check',
      roundedBorde: false,
    );
  }

  _credit(){
    return MyRaisedButton(
      onPressed:(){
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayCredit()));
      },
      size: 300.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Summery Of Credit',
      roundedBorde: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Display Data')
      ),
      body: Column(
        children:<Widget>[
          SizedBox(height:30.0),
          _dayWiseSummery(),
          SizedBox(height:20.0),
          _monthWiseSummery(),
          SizedBox(height:20.0),
          _check(),
          SizedBox(height:20.0),
          _credit()
        ]
      ),
    );
  }
}