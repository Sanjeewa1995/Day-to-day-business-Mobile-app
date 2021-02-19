import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/commen_screens/cash_setle_screen.dart';
import 'package:day_to_day_business/custom_widgets/progress_dialog.dart';
import 'package:day_to_day_business/serviceess/firebase_service/firebase_service.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../select_compant_screen.dart';
import 'wijaya_tabbar_screen.dart';

class WijayaCashSettle extends StatefulWidget {
  WijayaCashSettle({Key key}) : super(key: key);

  @override
  _WijayaCashSettleState createState() => _WijayaCashSettleState();
}

class _WijayaCashSettleState extends State<WijayaCashSettle> {
  FirebaseService firebaseService = FirebaseService();

  ProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final datePicker = Provider.of<GetDate>(context, listen: false);
    void uploadData(Map<String, dynamic> data) async {
      _dialog.show();
      await FirebaseFirestore.instance
          .collection('wijaya/day-to-day-reports/today-report')
          .doc(datePicker.date)
          .update(data)
          .then((value) {
        _dialog.hide();
        String message = 'Data added success';
        Alerts.showMessage(context, message,
            hideCancleButton: true, title: 'Response', responseFunction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
              ModalRoute.withName(SelectCompany.routeName));
        });
      }).catchError((error) {
        _dialog.hide();
        Alerts.showMessage(context, error.toString(), hideCancleButton: true,
            responseFunction: () {
          Navigator.of(context).pop();
        });
      });
    }

    return Scaffold(
      body: MultiProvider(
          providers: [
            FutureProvider(
              create: (ctx) =>
                  firebaseService.fetchCashSettleData(datePicker.date, context),
            ),
            FutureProvider(
                create: (ctx) =>
                    firebaseService.fetchTodayData(datePicker.date, context))
          ],
          child: Consumer<CashSetleData>(
              builder: (context, cashSettleData, widgt) {
            return (cashSettleData != null)
                ? Consumer<Map>(builder: (context, todayData, widget) {
                    int outcome = 0;
                    if (todayData != null) {
                      outcome = todayData['Employee'] +
                          todayData['Disccount'] +
                          todayData['Diesel'] +
                          todayData['OtherCost'] +
                          todayData['Tea'];
                    }

                    return (cashSettleData != null && todayData != null)
                        ? CashSetle(
                            outcome: outcome,
                            cheque: cashSettleData.totleCheque,
                            credit: cashSettleData.totleCredit,
                            cashReceipts: todayData['TodayPayCash'],
                            sale: todayData['Sale'],
                            uploadData: uploadData)
                        : Center(
                            child: SpinKitCircle(
                                color: Color(0xFF85091B), size: 60));
                  })
                : Center(
                    child: SpinKitCircle(color: Color(0xFF85091B), size: 60));
          })),
    );
  }
}
