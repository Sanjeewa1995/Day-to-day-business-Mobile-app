import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/commen_screens/add_cheque_screen.dart';
import 'package:day_to_day_business/custom_widgets/progress_dialog.dart';
import 'package:day_to_day_business/screens/select_compant_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';

class WijayaAddCheque extends StatefulWidget {
  const WijayaAddCheque({Key key}) : super(key: key);

  @override
  _WijayaAddChequeState createState() => _WijayaAddChequeState();
}

class _WijayaAddChequeState extends State<WijayaAddCheque> {

   ProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
  }

   void uploadData(Map data) {
      _dialog.show();
      FirebaseFirestore.instance
          .collection('wijaya/day-to-day-reports/today-cheques')
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

    

    return AddCheque(uploadData: uploadData);
  }
}
