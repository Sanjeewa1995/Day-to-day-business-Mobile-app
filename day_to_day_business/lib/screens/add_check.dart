import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'check_summery.dart';

class AddCheck extends StatefulWidget {
  AddCheck({Key key}) : super(key: key);

  _AddCheckState createState() => _AddCheckState();
}

class _AddCheckState extends State<AddCheck> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;
  int number;
  int cValue;
  bool isBankDate = false;
  String _bankDate;

  String adress;

  String _date = DateFormat.yMMMMd().format(DateTime.now());
  String _month = DateFormat().add_M().format(DateTime.now());
  String _year = DateTime.now().year.toString();
  String _day = DateTime.now().day.toString();

  _dateFlicker() async {
    DateTime _dateTime = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
        borderRadius: 16,
        theme: ThemeData.dark());
    setState(() {
      _date = DateFormat.yMMMMd().format(_dateTime);
      _month = DateFormat().add_M().format(_dateTime);
      _year = _dateTime.year.toString();
      _day = _dateTime.day.toString();
    });
  }

  _bankDateFlicker() async {
    DateTime _dateTime = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
        borderRadius: 16,
        theme: ThemeData.dark());
    setState(() {
      _bankDate = DateFormat.yMMMMd().format(_dateTime);
    });
  }

  _selectDateButton() {
    return MyRaisedButton(
      onPressed: () {
        _dateFlicker();
      },
      color: Colors.blue,
      size: 300.0,
      label: _date,
      roundedBorde: false,
    );
  }

  Widget _buildName() {
    return MyTextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value) {
        name = value;
      },
      labelText: 'Name Of The Owner',
      hintText: 'Enter Name',
    );
  }

  Widget _buildAdress() {
    return MyTextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Adress is required';
        }
        return null;
      },
      onSaved: (String value) {
        adress = value;
      },
      labelText: 'Adress Of The Owner',
      hintText: 'Enter Adress',
    );
  }

  Widget _buildNumber() {
    return MyTextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Cheque Number is required';
        }
        return null;
      },
      onSaved: (String value) {
        number = int.parse(value);
      },
      labelText: 'Cheque Number',
      hintText: 'Enter Number',
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildValue() {
    return MyTextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Value is required';
        }
        return null;
      },
      onSaved: (String value) {
        cValue = int.parse(value);
      },
      labelText: 'Value Of Cheque',
      hintText: 'Enter Value',
      keyboardType: TextInputType.number,
    );
  }

  _selectBankDateButton() {
    return MyRaisedButton(
      onPressed: () {
        _bankDateFlicker();
      },
      color: Colors.blue,
      size: 300.0,
      label: 'Bank Date',
      roundedBorde: false,
    );
  }

  _myRaisedButton() {
    return MyRaisedButton(
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        } else if (_bankDate == null) {
          setState(() {
            isBankDate = true;
          });
          return;
        }
        _formKey.currentState.save();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckSummery(
                      month: _month,
                      year: _year,
                      name: name,
                      number: number,
                      cValue: cValue,
                      bDate: _bankDate,
                      date: _date,
                      day: _date,
                      adress: adress,
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
      appBar: AppBar(title: Text('Add Check')),
      body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              _selectDateButton(),
              SizedBox(height: 20.0),
              _buildName(),
              _buildAdress(),
              _buildNumber(),
              _buildValue(),
              _selectBankDateButton(),
              isBankDate == false
                  ? Container()
                  : Center(
                      child: Text(
                      ' Required bank date',
                      style: TextStyle(color: Colors.red),
                    )),
              SizedBox(height: 20.0),
              _myRaisedButton()
            ],
          )),
    );
  }
}
