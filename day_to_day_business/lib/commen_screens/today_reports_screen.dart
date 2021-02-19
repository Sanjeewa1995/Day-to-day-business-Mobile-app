import 'package:day_to_day_business/commen_screens/enter_data_screen.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_search_delegate.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_enter_data_screen.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayReport extends StatefulWidget {
  final String image;
  final Widget enterDataPage;
  final Widget addChequePage;
  final Widget addCreditPage;
  final Widget cashSettlePage;
  final SearchDelegate searchDelegate;
  final List<String> allReadyAddedDates;

  const TodayReport(
      {Key key,
      @required this.image,
      @required this.enterDataPage,
      @required this.addChequePage,
      @required this.addCreditPage,
      @required this.cashSettlePage,
      @required this.searchDelegate,
      @required this.allReadyAddedDates})
      : super(key: key);

  @override
  _TodayReportState createState() => _TodayReportState();
}

class _TodayReportState extends State<TodayReport> {
  @override
  Widget build(BuildContext context) {
    final datePicker = Provider.of<GetDate>(context);
   // List<String> allreadyAddedDates = Provider.of<List<String>>(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    return widget.allReadyAddedDates == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Image(
                    image: AssetImage('assets/images/${widget.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        MyRaisedButton(
                          width: deviceWidth * 0.8,
                          label: 'Enter Data',
                          onPressed: () {
                            datePicker.selectDate(
                                context: context,
                                nextPage: widget.enterDataPage,
                                title: 'addData',
                                allReadyAddedDates: widget.allReadyAddedDates);
                          },
                        ),
                        MyRaisedButton(
                          width: deviceWidth * 0.8,
                          label: 'Add Cheque',
                          onPressed: () {
                            datePicker.selectDate(
                                context: context,
                                nextPage: widget.addChequePage,
                                title: 'getData');
                          },
                        ),
                        MyRaisedButton(
                          width: deviceWidth * 0.8,
                          label: 'Add Credit',
                          onPressed: () {
                            datePicker.selectDate(
                                context: context,
                                nextPage: widget.addCreditPage,
                                title: 'getData');
                          },
                        ),
                        MyRaisedButton(
                          width: deviceWidth * 0.8,
                          label: 'Add Credit Receipts',
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: widget.searchDelegate);
                          },
                        ),
                        MyRaisedButton(
                          width: deviceWidth * 0.8,
                          label: 'Cash Settle',
                          onPressed: () {
                            datePicker.selectDate(
                                context: context,
                                nextPage: widget.cashSettlePage,
                                title: 'getData');
                          },
                        ),
                      ],
                    )),
              ],
            ));
  }
}
