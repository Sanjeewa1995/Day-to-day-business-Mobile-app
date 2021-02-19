import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';

import 'package:day_to_day_business/utils/alerts.dart';

class GetDate with ChangeNotifier {
  String _date;
  String _month;
  String _year;
  String get date {
    return _date;
  }

  String get month {
    return _month;
  }

  String get year {
    return _year;
  }

  void selectDate(
      {@required BuildContext context,
      @required Widget nextPage,
      @required String title,
      List allReadyAddedDates}) {
    showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 16,
      theme: ThemeData.dark(),
    ).then((date) {
      _date = DateFormat('yyyy.MM.dd').format(date);
      _month = DateFormat().add_M().format(date);
      _year = DateFormat().add_y().format(date);

      bool isAdded = allReadyAddedDates == null
          ? false
          : allReadyAddedDates.contains(_date);
      String msg =
          'This date is allready added.if you want remove privious data click ok';

      if (title == 'addData' && isAdded == true) {
        Alerts.showMessage(context, msg, responseFunction: () {
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => nextPage));
          notifyListeners();
        });
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => nextPage));
        notifyListeners();
      }
    });
  }
}
