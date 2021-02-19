import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/commen_screens/today_reports_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_add-cheque_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_add_credit.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_cash_settle_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_enter_data_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_search_delegate.dart';
import 'package:flutter/material.dart';

class WijayaTodayReports extends StatefulWidget {
  const WijayaTodayReports({Key key}) : super(key: key);

  @override
  _WijayaTodayReportsState createState() => _WijayaTodayReportsState();
}

class _WijayaTodayReportsState extends State<WijayaTodayReports> {
  @override
  Widget build(BuildContext context) {
    Stream stream = FirebaseFirestore.instance
        .collection('wijaya/day-to-day-reports/today-credit')
        .snapshots();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('wijaya/day-to-day-reports/today-report')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            List<String> dates;
            dates = [];
            if (snapshot.data.docs.length > 0) {
              print(snapshot.data.docs[0]['Date']);
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                dates.add(snapshot.data.docs[i]['Date'].toString());
              }
            }
            return TodayReport(
              image: 'wijaya.jpg',
              enterDataPage: WijayaEnterData(),
              addChequePage: WijayaAddCheque(),
              addCreditPage: WijayaAddCredit(),
              cashSettlePage: WijayaCashSettle(),
              searchDelegate: WijayaSearchDelegate(stream),
              allReadyAddedDates: dates,
            );
          }
        });
  }
}
