import 'package:day_to_day_business/commen_screens/enter_data_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/custom_widgets/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../select_compant_screen.dart';

class WijayaEnterData extends StatefulWidget {
  static const routeName = '/WijayaEnterData';

  @override
  _WijayaEnterDataState createState() => _WijayaEnterDataState();
}

class _WijayaEnterDataState extends State<WijayaEnterData> {
  ProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final date = Provider.of<GetDate>(context, listen: false);
    void uploadData(Map data) {
      _dialog.show();
      FirebaseFirestore.instance
          .collection('wijaya/day-to-day-reports/today-report')
          .doc(date.date)
          .set(data)
          .then((response) {
        _dialog.hide();
        Alerts.showMessage(context, 'Data added success', title: 'Response',hideCancleButton: true,
            responseFunction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
              ModalRoute.withName(SelectCompany.routeName));
        });
      }).catchError((error) {
        _dialog.hide();
        Alerts.showMessage(context, error, hideCancleButton: true, responseFunction: () {
          Navigator.of(context).pop();
        });
      });
    }

    return EnterData(
      uploadData: uploadData,
    );
  }
}
