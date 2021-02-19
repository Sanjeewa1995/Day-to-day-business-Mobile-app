import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_field.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCredit extends StatefulWidget {
  final Function uploadData;

  const AddCredit({Key key, this.uploadData}) : super(key: key);

  @override
  _AddCreditState createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _invoiceController = TextEditingController();
  TextEditingController _valueController = TextEditingController();

  FocusNode _nameFocus = FocusNode();
  FocusNode _areaFocus = FocusNode();
  FocusNode _invoiceFocus = FocusNode();
  FocusNode _valueFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

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
        'Invoice Number': _invoiceController.text,
        'Value': int.parse(_valueController.text),
        'TotolPayCash': 0,
        'PaidSummery': [],
        'isPaided': false
      };
      Alerts.dataConfirmAlert(context, data, widget.uploadData);
    }

    return Scaffold(
      backgroundColor: Color(0xFF2d4059),
      appBar: AppBar(centerTitle: true, title: Text('Enter Credit')),
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
                    _fieldFocusChange(context, _areaFocus, _invoiceFocus);
                  },
                ),
                MyTextFormField(
                  labelText: 'Invoice Number',
                  keyboardType: TextInputType.number,
                  textEditingController: _invoiceController,
                  focusNode: _invoiceFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _invoiceFocus, _valueFocus);
                  },
                ),
                MyTextFormField(
                  labelText: 'Value',
                  textEditingController: _valueController,
                  keyboardType: TextInputType.number,
                  focusNode: _valueFocus,
                  onFieldSubmitted: (term) {
                    _valueFocus.unfocus();
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
