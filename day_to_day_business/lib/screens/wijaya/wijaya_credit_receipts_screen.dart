import 'package:day_to_day_business/commen_screens/credit_receipts_screen.dart';
import 'package:flutter/material.dart';

class WijayaCreditReciepts extends StatelessWidget {
  final String name;

  const WijayaCreditReciepts({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreditReceipts(
      name: name,
      creditEndPoint: 'wijaya/day-to-day-reports/today-credit',
      todayReportsEndPoint: 'wijaya/day-to-day-reports/today-report',
    );
  }
}
