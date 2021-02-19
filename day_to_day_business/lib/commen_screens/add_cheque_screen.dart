import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_field.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCheque extends StatefulWidget {
  final Function uploadData;

  const AddCheque({Key key, this.uploadData}) : super(key: key);

  @override
  _AddChequeState createState() => _AddChequeState();
}

class _AddChequeState extends State<AddCheque> {
  TextEditingController _bankDateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _valueController = TextEditingController();

  FocusNode _nameFocus = FocusNode();
  FocusNode _areaFocus = FocusNode();
  FocusNode _numberFocus = FocusNode();
  FocusNode _valueFocus = FocusNode();

  String _date;

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
      _bankDateController.text = _date;
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final date = Provider.of<GetDate>(context, listen: false);

    void _submitForm() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      Map<String, dynamic> data = {
        'Date': date.date,
        'Name': _nameController.text,
        'Area': _areaController.text,
        'Number': _numberController.text,
        'Value': int.parse(_valueController.text),
        'BankDate': _bankDateController.text
      };
      Alerts.dataConfirmAlert(context, data, widget.uploadData);
    }

    return Scaffold(
      backgroundColor: Color(0xFF2d4059),
      appBar: AppBar(centerTitle: true, title: Text('Enter Check')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30),
                MyTextFormField(
                  labelText: 'Name',
                  textEditingController: _nameController,
                  focusNode: _nameFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _nameFocus, _areaFocus);
                  },
                ),
                MyTextFormField(
                  labelText: 'Area',
                  textEditingController: _areaController,
                  focusNode: _areaFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _areaFocus, _numberFocus);
                  },
                ),
                MyTextFormField(
                  labelText: 'Cheque Number',
                  keyboardType: TextInputType.number,
                  textEditingController: _numberController,
                  focusNode: _numberFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _numberFocus, _valueFocus);
                  },
                ),
                MyTextFormField(
                  labelText: 'Value',
                  keyboardType: TextInputType.number,
                  textEditingController: _valueController,
                  focusNode: _valueFocus,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (term) {
                    _valueFocus.unfocus();
                  },
                ),
                MyTextFormField(
                  textEditingController: _bankDateController,
                  labelText: 'Bank Date',
                  onTap: () {
                    _dateFlicker();
                  },
                ),
                SizedBox(height: 20),
                MyRaisedButton(
                  label: 'Submit',
                  onPressed: _submitForm,
                )
              ],
            )),
      ),
    );
  }
}
