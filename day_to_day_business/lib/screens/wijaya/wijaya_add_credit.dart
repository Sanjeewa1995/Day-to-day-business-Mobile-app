import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/commen_screens/add_credit_screen.dart';
import 'package:day_to_day_business/custom_widgets/progress_dialog.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';

import '../select_compant_screen.dart';
import 'wijaya_tabbar_screen.dart';

class WijayaAddCredit extends StatefulWidget {
  const WijayaAddCredit({Key key}) : super(key: key);

  @override
  _WijayaAddCreditState createState() => _WijayaAddCreditState();
}

class _WijayaAddCreditState extends State<WijayaAddCredit> {
  ProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
  }

  void uploadData(Map data) {
    _dialog.show();
    FirebaseFirestore.instance
        .collection('wijaya/day-to-day-reports/today-credit')
        .doc()
        .set(data)
        .then((response) {
      _dialog.hide();
      Alerts.showMessage(context, 'Success', title: 'Response',
          responseFunction: () {
        Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
            ModalRoute.withName(SelectCompany.routeName));
      });
    }).catchError((error) {
      _dialog.hide();
      Alerts.showMessage(context, error, responseFunction: () {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddCredit(uploadData: uploadData);
  }
}
