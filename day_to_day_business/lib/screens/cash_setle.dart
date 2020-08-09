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
  FocusNode _c5000Focus = FocusNode();
  FocusNode _c1000Focus = FocusNode();
  FocusNode _c500Focus = FocusNode();
  FocusNode _c100Focus = FocusNode();
  FocusNode _c50Focus = FocusNode();
  FocusNode _c20Focus = FocusNode();
  FocusNode _coinFocus = FocusNode();

  TextEditingController _c5000Controller = TextEditingController();
  TextEditingController _c1000Controller = TextEditingController();
  TextEditingController _c500Controller = TextEditingController();
  TextEditingController _c100Controller = TextEditingController();
  TextEditingController _c50Controller = TextEditingController();
  TextEditingController _c20Controller = TextEditingController();
  TextEditingController _coinController = TextEditingController();

  int cash5000;
  int cash1000;
  int cash500;
  int cash100;
  int cash50;
  int cash20;
  int coin;
  int tCash;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  _selectDate() {
    return MyRaisedButton(
      onPressed: () {
        _dateFlicker();
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: _date,
      roundedBorde: false,
    );
  }

  _tCash() {
    tCash = int.parse(_c5000Controller.text) * 5000 +
        int.parse(_c1000Controller.text) * 1000 +
        int.parse(_c100Controller.text) * 100 +
        int.parse(_c500Controller.text) * 500 +
        int.parse(_c50Controller.text) * 50 +
        int.parse(_c20Controller.text) * 20 +
        int.parse(_coinController.text);
  }

  _save() {
    return MyRaisedButton(
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        _tCash();
        if (tCash != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TSummery(
                        tCash: tCash,
                        year: _year,
                        month: _month,
                        day: _day,
                        date: _date,
                      )));
        } else {
          Text('Loding......');
        }
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Submit',
      roundedBorde: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2d4059),
        appBar: AppBar(centerTitle: true, title: Text('Cash Setle')),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            _selectDate(),
            SizedBox(height: 15.0),
            Center(
              child: Text(
                'Enter Cash',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ReuseTextField(
                      label: '5000',
                      controller: _c5000Controller,
                      focusNode: _c5000Focus,
                      nextNode: _c1000Focus,
                    ),
                    ReuseTextField(
                      label: '1000',
                      controller: _c1000Controller,
                      focusNode: _c1000Focus,
                      nextNode: _c500Focus,
                    ),
                    ReuseTextField(
                      label: '500',
                      controller: _c500Controller,
                      focusNode: _c500Focus,
                      nextNode: _c100Focus,
                    ),
                    ReuseTextField(
                      label: '100',
                      controller: _c100Controller,
                      focusNode: _c100Focus,
                      nextNode: _c50Focus,
                    ),
                    ReuseTextField(
                      label: '50',
                      controller: _c50Controller,
                      focusNode: _c50Focus,
                      nextNode: _c20Focus,
                    ),
                    ReuseTextField(
                      label: '20',
                      controller: _c20Controller,
                      focusNode: _c20Focus,
                      nextNode: _coinFocus,
                    ),
                    ReuseTextField(
                      label: 'Coin',
                      controller: _coinController,
                      focusNode: _coinFocus,
                      //nextNode: _1000Focus,
                    ),
                  ],
                )),
            _save(),
          ],
        ));
  }
}

class ReuseTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final String label;

  const ReuseTextField(
      {Key key, this.controller, this.focusNode, this.nextNode, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      controller: controller,
      labelText: label,
      errorMsg: 'Cash is required',
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      nextNode: nextNode,
    );
  }
}
