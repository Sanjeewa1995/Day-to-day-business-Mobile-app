import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/commen_screens/tabbar_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_display_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_search_delegate.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_today_reports.dart';
import 'package:flutter/material.dart';

class WijayaTabBar extends StatelessWidget {
  static const routeName = '/WijayaTabBar';

  @override
  Widget build(BuildContext context) {
    return TabBarScreen(
      displayWidget: WijayaHome(),
      reportWidget: WijayaTodayReports(),
      title: 'Wijaya Home',
    );
  }
}
