import 'package:day_to_day_business/commen_screens/today_reports_screen.dart';
import 'package:day_to_day_business/custom_widgets/app_bar.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:flutter/material.dart';

class TabBarScreen extends StatelessWidget {
  final Widget reportWidget;
  final Widget displayWidget;
  final String title;

  const TabBarScreen(
      {Key key,
      @required this.reportWidget,
      @required this.displayWidget,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          bottom:
              TabBar(tabs: <Widget>[Tab(text: 'Display'), Tab(text: 'Report')]),
         
        ),
        body: TabBarView(children: [displayWidget, reportWidget]),
      ),
    );
  }
}

// Column(children: [
//             CustomAppBar(title: 'Home'),
//             Expanded(
//               flex: 7,
//               child: Image(
//                 image: AssetImage('assets/images/$image'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//                 flex: 3,
//                 child: Column(
//                   children: [
//                     MyRaisedButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => todayReportsWidget));
//                       },
//                       label: 'Today Reports',
//                       roundedBorde: true,
//                     ),
//                     SizedBox(height: 20),
//                     MyRaisedButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //     context, MaterialPageRoute(builder: (context) => DisplayData()));
//                       },
//                       label: 'Display Data',
//                       roundedBorde: true,
//                     )
//                   ],
//                 ))
//           ])
