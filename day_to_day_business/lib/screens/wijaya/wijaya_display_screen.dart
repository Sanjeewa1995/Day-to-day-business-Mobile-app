import 'package:day_to_day_business/commen_screens/display_screen.dart';
import 'package:day_to_day_business/commen_screens/tabbar_screen.dart';
import 'package:day_to_day_business/commen_screens/today_reports_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WijayaHome extends StatelessWidget {
  const WijayaHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Display(image: 'wijaya.jpg', nextPage: WijayaTabBar(),);
  }
}
