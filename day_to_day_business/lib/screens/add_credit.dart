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

  FocusNode _nameFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _invoiceFocus = FocusNode();
  FocusNode _valueFocus = FocusNode();

  String name;
  String pNumber;
  String invoice;
  int cValue;
  String adress;

  String _date = DateFormat.yMMMMd().format(DateTime.now());
  String _month = DateFormat().add_M().format(DateTime.now());
  String _year = DateTime.now().year.toString();

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
      errorMsg: 'Name is required',
      onSaved: (String value) {
        name = value;
      },
      labelText: 'Name Of The Owner',
      hintText: 'Enter Name',
      textInputAction: TextInputAction.next,
      focusNode: _nameFocus,
      nextNode: _addressFocus,
    );
  }

  Widget _buildPNumber() {
    return MyTextFormField(
      errorMsg: 'Phone Number is required',
      onSaved: (String value) {
        pNumber = value;
      },
      labelText: 'Phone Number',
      hintText: 'Enter Phone Number',
      textInputAction: TextInputAction.next,
      focusNode: _phoneFocus,
      nextNode: _invoiceFocus,
    );
  }

  Widget _buildInvoice() {
    return MyTextFormField(
      errorMsg: 'Invoice is required',
      onSaved: (String value) {
        invoice = value;
      },
      labelText: 'Invoice Number',
      hintText: 'Enter Invoice Number',
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _invoiceFocus,
      nextNode: _valueFocus,
    );
  }

  Widget _buildValue() {
    return MyTextFormField(
      errorMsg: 'Value is required',
      onSaved: (String value) {
        cValue = int.parse(value);
      },
      labelText: 'Value of Bill',
      hintText: 'Enter Value',
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      focusNode: _valueFocus,
    );
  }

  Widget _buildAdress() {
    return MyTextFormField(
      errorMsg: 'Adress is required',
      onSaved: (String value) {
        adress = value;
      },
      labelText: 'Adress Of The Owner',
      hintText: 'Enter Adress',
      textInputAction: TextInputAction.next,
      focusNode: _addressFocus,
      nextNode: _phoneFocus,
    );
  }

  _myRaisedButton() {
    return MyRaisedButton(
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreditSummery(
                      month: _month,
                      year: _year,
                      name: name,
                      pNumber: pNumber,
                      cValue: cValue,
                      invoice: invoice,
                      date: _date,
                      day: _date,
                      adress: adress,
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
    return Scaffold(
      backgroundColor: Color(0xFF57DAD7),
      appBar: AppBar(centerTitle: true, title: Text('Add Credit')),
      body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              _selectDateButton(),
              SizedBox(height: 20.0),
              _buildName(),
              _buildAdress(),
              _buildPNumber(),
              _buildInvoice(),
              _buildValue(),
              SizedBox(height: 20.0),
              _myRaisedButton()
            ],
          )),
    );
  }
}
