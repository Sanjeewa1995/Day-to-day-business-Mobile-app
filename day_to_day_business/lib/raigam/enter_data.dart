import 'package:day_to_day_business/raigam/today_summery.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/text_form.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class EnterData extends StatefulWidget {
  EnterData({Key key}) : super(key: key);

  _EnterDataState createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterData> {
  FocusNode _dateFocus = FocusNode();
  FocusNode _saleFocus = FocusNode();
  FocusNode _disccountFocus = FocusNode();
  FocusNode _dieselFocus = FocusNode();
  FocusNode _employeeFocus = FocusNode();
  FocusNode _teaFocus = FocusNode();
  FocusNode _otherCostFocus = FocusNode();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _saleController = TextEditingController();
  TextEditingController _disccountController = TextEditingController();
  TextEditingController _dieselController = TextEditingController();
  TextEditingController _employeeController = TextEditingController();
  TextEditingController _teaController = TextEditingController();
  TextEditingController _otherCostController = TextEditingController();

  int disccount;
  double profit;
  bool validDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Model model = Model();
  String _date;
  String _month;
  String _year;
  String _day;

  Future<String> _dateFlicker() async {
    DateTime _dateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 16,
      theme: ThemeData.dark(),
    );
    _date = DateFormat.yMMMMd().format(_dateTime);
    print(_dateTime);
    _month = DateFormat().add_M().format(_dateTime);
    _year = _dateTime.year.toString();
    _day = _dateTime.day.toString();
    return _date;
  }

  _getFrofit() {
    profit = double.parse(
        (int.parse(_saleController.text) * (7 / 100)).toStringAsFixed(2));
  }

  _myRaisedButton() {
    return MyRaisedButton(
      onPressed: () async {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        await _getFrofit();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodaySummery(
                      date: _dateController.text,
                      sale: int.parse(_saleController.text),
                      discount: int.parse(_disccountController.text),
                      diesel: int.parse(_dieselController.text),
                      employee: int.parse(_employeeController.text),
                      tea: int.parse(_teaController.text),
                      other: int.parse(_otherCostController.text),
                      profit: profit,
                      year: _year,
                      month: _month,
                      day: _day,
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
        appBar: AppBar(centerTitle: true, title: Text('Today Data')),
        body: Form(
            key: _formKey,
            child: ListView(padding: EdgeInsets.all(10.0), children: <Widget>[
              MyTextFormField(
                controller: _dateController,
                labelText: "Date",
                errorMsg: 'Date is required',
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  await _dateFlicker();
                  setState(() {
                    _dateController.text = _date;
                  });
                },
                textInputAction: TextInputAction.next,
                focusNode: _dateFocus,
                nextNode: _saleFocus,
              ),
              MyTextFormField(
                controller: _saleController,
                keyboardType: TextInputType.number,
                labelText: 'Sale',
                errorMsg: 'Sale is required',
                textInputAction: TextInputAction.next,
                focusNode: _saleFocus,
                nextNode: _disccountFocus,
              ),
              MyTextFormField(
                controller: _disccountController,
                keyboardType: TextInputType.number,
                labelText: 'Disccount',
                errorMsg: 'Disccount is required',
                textInputAction: TextInputAction.next,
                focusNode: _disccountFocus,
                nextNode: _dieselFocus,
              ),
              MyTextFormField(
                controller: _dieselController,
                keyboardType: TextInputType.number,
                labelText: 'Diesel',
                errorMsg: 'Diesel is required',
                textInputAction: TextInputAction.next,
                focusNode: _dieselFocus,
                nextNode: _employeeFocus,
              ),
              MyTextFormField(
                controller: _employeeController,
                keyboardType: TextInputType.number,
                labelText: 'Employee',
                errorMsg: 'Employee is required',
                textInputAction: TextInputAction.next,
                focusNode: _employeeFocus,
                nextNode: _teaFocus,
              ),
              MyTextFormField(
                controller: _teaController,
                keyboardType: TextInputType.number,
                labelText: 'Tea',
                errorMsg: 'Tea is required',
                textInputAction: TextInputAction.next,
                focusNode: _teaFocus,
                nextNode: _otherCostFocus,
              ),
              MyTextFormField(
                controller: _otherCostController,
                keyboardType: TextInputType.number,
                labelText: 'Other Cost',
                errorMsg: 'Other cost is required',
                textInputAction: TextInputAction.done,
                focusNode: _otherCostFocus,
              ),
              _myRaisedButton(),
            ])));
  }
}
