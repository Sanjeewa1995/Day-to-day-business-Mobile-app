import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:day_to_day_business/custom_widgets/progress_view.dart';

BuildContext _context ,  _dismissingContext;
bool _isShowing = false;
bool _barrierDismissible = true , _showLogs;

Curve _insetAnimCurve = Curves.easeInOut;

class ProgressDialog {
  ProgressView _dialog;

  ProgressDialog(BuildContext context) {
    _context = context;
  }

  Future<bool> hide() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Navigator.of(_dismissingContext).pop(true);
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      if (_showLogs) debugPrint('ProgressDialog already dismissed');
      return Future.value(false);
    }
  }

  void show() {
    if (!_isShowing) {
      _dialog = ProgressView();
      _isShowing = true;

      showDialog<dynamic>(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return WillPopScope(
            onWillPop: () {
              return Future.value(_barrierDismissible);
            },
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetAnimationCurve: _insetAnimCurve,
              insetAnimationDuration: Duration(milliseconds: 100),
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[_dialog],
              ),
            ),
          );
        },
      );
    }
  }
}
