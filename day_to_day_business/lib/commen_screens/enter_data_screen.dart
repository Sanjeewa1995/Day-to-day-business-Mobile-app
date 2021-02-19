import 'package:day_to_day_business/custom_widgets/app_bar.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_field.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterData extends StatefulWidget {
  final Function uploadData;

  const EnterData({Key key, @required this.uploadData}) : super(key: key);

  @override
  _EnterDataState createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode _saleFocus = FocusNode();
  FocusNode _disccountFocus = FocusNode();
  FocusNode _dieselFocus = FocusNode();
  FocusNode _employeeFocus = FocusNode();
  FocusNode _teaFocus = FocusNode();
  FocusNode _otherCostFocus = FocusNode();

  TextEditingController _saleController = TextEditingController();
  TextEditingController _disccountController = TextEditingController();
  TextEditingController _dieselController = TextEditingController();
  TextEditingController _employeeController = TextEditingController();
  TextEditingController _teaController = TextEditingController();
  TextEditingController _otherCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final date = Provider.of<GetDate>(context, listen: false);

    _fieldFocusChange(
        BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    void _submitForm() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      Map<String, dynamic> data = {
        'Date': date.date,
        'Year': date.year,
        'Month': date.month,
        'Sale': int.parse(_saleController.text),
        'Disccount': int.parse(_disccountController.text),
        'Diesel': int.parse(_dieselController.text),
        'Employee': int.parse(_employeeController.text),
        'Tea': int.parse(_teaController.text),
        'OtherCost': int.parse(_otherCostController.text),
        'TodayPayCash': 0
      };
      print(data.toString());
      Alerts.dataConfirmAlert(context, data, widget.uploadData);
    }

    return Scaffold(
      body: ListView(
        children: [
          CustomAppBar(title: 'Today Data'),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      textEditingController: _saleController,
                      keyboardType: TextInputType.number,
                      labelText: 'Sale',
                      focusNode: _saleFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _saleFocus, _disccountFocus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _disccountController,
                      keyboardType: TextInputType.number,
                      labelText: 'Disccount',
                      focusNode: _disccountFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _disccountFocus, _dieselFocus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _dieselController,
                      keyboardType: TextInputType.number,
                      labelText: 'Diesel',
                      focusNode: _dieselFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _dieselFocus, _employeeFocus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _employeeController,
                      keyboardType: TextInputType.number,
                      labelText: 'Employee',
                      focusNode: _employeeFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _employeeFocus, _teaFocus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _teaController,
                      keyboardType: TextInputType.number,
                      labelText: 'Tea',
                      focusNode: _teaFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _teaFocus, _otherCostFocus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _otherCostController,
                      keyboardType: TextInputType.number,
                      labelText: 'Other Cost',
                      focusNode: _otherCostFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (term) {
                        _otherCostFocus.unfocus();
                      },
                    ),
                    SizedBox(height: 10.0),
                    MyRaisedButton(
                      label: 'Submit',
                      onPressed: _submitForm,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
