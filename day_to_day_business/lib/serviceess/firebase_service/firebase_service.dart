import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/screens/select_compant_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {
  Future<List<String>> fetchAllradyAddedDates() async {
    List<String> dates;
    FirebaseFirestore.instance
        .collection('wijaya/day-to-day-reports/today-report')
        .snapshots()
        .listen((value) {
      dates = [];
      if (value.docs.length > 0) {
        print(value.docs[0]['Date']);
        for (int i = 0; i < value.docs.length; i++) {
          dates.add(value.docs[i]['Date'].toString());
        }
      }
      return dates;
    }, onError: (error) {
      print(error);
    });
     return dates;
  }

  Future<CashSetleData> fetchCashSettleData(
      String date, BuildContext context) async {
    int totleCredit = 0;
    int totleCheque = 0;
    await FirebaseFirestore.instance
        .collection('wijaya/day-to-day-reports/today-credit')
        .where('Date', isEqualTo: date)
        .get()
        .then((doc) async {
      if (doc.docs.length > 0) {
        if (doc.docs.length > 0) {
          for (int i = 0; i < doc.docs.length; i++) {
            totleCredit += doc.docs[i]['Value'];
            print(doc.docs[0]['Value']);
          }
        }
      }

      await FirebaseFirestore.instance
          .collection('wijaya/day-to-day-reports/today-cheques')
          .where('Date', isEqualTo: date)
          .get()
          .then((doc) {
        if (doc.docs.length > 0) {
          if (doc.docs.length > 0) {
            for (int i = 0; i < doc.docs.length; i++) {
              totleCheque += doc.docs[i]['Value'];
              print(totleCheque);
            }
          }
        }
      }).catchError((error) {
        Alerts.showMessage(context, error.toString(), hideCancleButton: true,
            responseFunction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
              ModalRoute.withName(SelectCompany.routeName));
        });
      });
    }).catchError((error) {
      Alerts.showMessage(context, error.toString(), hideCancleButton: true,
          responseFunction: () {
        Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
            ModalRoute.withName(SelectCompany.routeName));
      });
    });

    return CashSetleData(totleCredit, totleCheque);
  }

  Future<Map> fetchTodayData(String date, BuildContext context) async {
    Map document;
    await FirebaseFirestore.instance
        .collection('wijaya/day-to-day-reports/today-report')
        .where('Date', isEqualTo: date)
        .get()
        .then((doc) {
      if (doc.docs.length > 0) {
        document = doc.docs[0].data();
      } else {
        String message = 'Today data is not added yet';
        Alerts.showMessage(context, message, hideCancleButton: true,
            responseFunction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
              ModalRoute.withName(SelectCompany.routeName));
        });
      }
    }).catchError((error) {
      Alerts.showMessage(context, error.toString(), hideCancleButton: true,
          responseFunction: () {
        Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
            ModalRoute.withName(SelectCompany.routeName));
      });
    });
    return document;
  }
}

class CashSetleData {
  final int totleCredit;
  final int totleCheque;

  CashSetleData(this.totleCredit, this.totleCheque);
}
