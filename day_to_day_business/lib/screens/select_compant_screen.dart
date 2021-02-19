
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_display_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:flutter/material.dart';

import '../const_value.dart';

class SelectCompany extends StatelessWidget {
  static const routeName = '/selectCompany';

  @override
  Widget build(BuildContext context) {
    final topSpace = MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    _myRaisedButton() {
      return MyRaisedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WijayaTabBar()));
        },
        width: deviceWidth * 0.7,
        label: 'Wijaya Product',
        roundedBorde: true,
      );
    }

    _myRaisedButtonRaigam() {
      return MyRaisedButton(
        onPressed: () {
          // Navigator.push(
          //    context, MaterialPageRoute(builder: (context) => RaigamHome()));
        },
        width: deviceWidth * 0.7,
        label: 'Raigam Product',
        roundedBorde: true,
      );
    }

    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(height: topSpace),
              Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: deviceWidth * 0.2),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Select Your Company',
                                style: headerStyle,
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Image.asset(
                            'assets/images/c1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _myRaisedButton(),
                      SizedBox(height: 20),
                      _myRaisedButtonRaigam(),
                    ],
                  ))
            ]));
  }
}
