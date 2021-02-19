import 'package:day_to_day_business/custom_widgets/app_bar.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_field.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashSetle extends StatefulWidget {
  final int sale;
  final int outcome;
  final int cheque;
  final int credit;
  final int cashReceipts;
  final Function uploadData;

  const CashSetle(
      {Key key,
      @required this.outcome,
      @required this.cheque,
      @required this.credit,
      @required this.cashReceipts,
      @required this.sale,
      @required this.uploadData})
      : super(key: key);

  @override
  _CashSetleState createState() => _CashSetleState();
}

class _CashSetleState extends State<CashSetle> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      int totleCash = int.parse(_c5000Controller.text) * 5000 +
          int.parse(_c1000Controller.text) * 1000 +
          int.parse(_c500Controller.text) * 500 +
          int.parse(_c100Controller.text) * 100 +
          int.parse(_c50Controller.text) * 50 +
          int.parse(_c20Controller.text) * 20 +
          int.parse(_coinController.text);

      int variance = totleCash +
          (widget.outcome + widget.credit + widget.cheque) -
          (widget.sale + widget.cashReceipts + 1000);
      Map<String, dynamic> data = {
        'Date': date.date,
        'Year': date.year,
        'Month': date.month,
        'Sale': widget.sale,
        'Outcome': widget.outcome,
        'Credit': widget.credit,
        'Cheque': widget.cheque,
        'Totle Cash': totleCash,
        'Variance': variance
      };
      print(data.toString());
      Alerts.dataConfirmAlert(context, data, widget.uploadData);
    }

    return Scaffold(
      body: ListView(
        children: [
          CustomAppBar(title: 'Cash Settle'),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      textEditingController: _c5000Controller,
                      keyboardType: TextInputType.number,
                      labelText: '5000',
                      focusNode: _c5000Focus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _c5000Focus, _c1000Focus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _c1000Controller,
                      keyboardType: TextInputType.number,
                      labelText: '1000',
                      focusNode: _c1000Focus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _c1000Focus, _c500Focus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _c500Controller,
                      keyboardType: TextInputType.number,
                      labelText: '500',
                      focusNode: _c500Focus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _c500Focus, _c100Focus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _c100Controller,
                      keyboardType: TextInputType.number,
                      labelText: '100',
                      focusNode: _c100Focus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _c100Focus, _c50Focus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _c50Controller,
                      keyboardType: TextInputType.number,
                      labelText: '50',
                      focusNode: _c50Focus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _c50Focus, _c20Focus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _c20Controller,
                      keyboardType: TextInputType.number,
                      labelText: '20',
                      focusNode: _c20Focus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _c20Focus, _coinFocus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _coinController,
                      keyboardType: TextInputType.number,
                      labelText: 'Coin',
                      focusNode: _coinFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (term) {
                        _coinFocus.unfocus();
                      },
                    ),
                    SizedBox(height: 10.0),
                    MyRaisedButton(
                      label: 'Submit',
                      roundedBorde: true,
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
