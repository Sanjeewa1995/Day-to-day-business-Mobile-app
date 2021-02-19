import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/screens/select_compant_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_display_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_enter_data_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Alerts {
  static void dataConfirmAlert(
      BuildContext context, Map data, Function upladData) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ...data.keys.map((key) {
                    return Text(
                      '$key : ${data[key]}',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    );
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.all(12),
                        color: Color(0xFF19769F),
                        child: Text(
                          'Cancle',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            upladData(data);
                          },
                          padding: EdgeInsets.all(12),
                          color: Color(0xFF19769F),
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showMessage(BuildContext context, String message,
      {String title = "Error",
      String button = "OK",
      bool hideCancleButton = false,
      @required Function responseFunction}) {
    showDialog(
      barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: double.infinity),
                    Text(
                      title,
                      style: TextStyle(color: Color(0xFF214252), fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: Color(0xFF214252),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: hideCancleButton
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      children: [
                        hideCancleButton
                            ? Container()
                            : SizedBox(
                                height: 48.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  padding: EdgeInsets.all(12),
                                  color: Color(0xFF19769F),
                                  child: Text(
                                    'Cancle',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 48.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              // Navigator.of(context).pop();
                              responseFunction();
                            },
                            padding: EdgeInsets.all(12),
                            color: Color(0xFF19769F),
                            child: Text(
                              button,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
