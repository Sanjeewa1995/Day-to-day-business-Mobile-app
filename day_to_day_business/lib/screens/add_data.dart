import 'package:day_to_day_business/screens/enter_data.dart';
import 'package:day_to_day_business/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'add_check.dart';
import 'add_credit.dart';
import 'cash_setle.dart';
import 'company_cheque.dart';

class AddData extends StatefulWidget {
  AddData({Key key}) : super(key: key);

  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  _myRaisedButtonAddSale() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EnterData()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Add Data',
      roundedBorde: false,
    );
  }

  _myRaisedButtonAddCheck() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddCheck()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Add Cheque',
      roundedBorde: false,
    );
  }

  _myRaisedButtonAddCredit() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddCredit()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Add Credit',
      roundedBorde: false,
    );
  }

  _home() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Home',
      roundedBorde: false,
    );
  }

  _cashSetle() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CashSetle()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Cash Setle',
      roundedBorde: false,
    );
  }

  _companyCheque() {
    return MyRaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CompanyCheque()));
      },
      size: 250.0,
      color: Colors.blue,
      textColor: Colors.white,
      label: 'Company Cheque',
      roundedBorde: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2d4059),
        appBar: AppBar(centerTitle: true, title: Text('Add Data')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Center(child: _myRaisedButtonAddSale()),
            SizedBox(height: 20.0),
            Center(child: _myRaisedButtonAddCheck()),
            SizedBox(height: 20.0),
            Center(child: _myRaisedButtonAddCredit()),
            SizedBox(
              height: 20.0,
            ),
            _companyCheque(),
            SizedBox(height: 20.0),
            _cashSetle(),
            SizedBox(height: 20.0),
            _home()
          ],
        ));
  }
}
