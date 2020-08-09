import 'package:day_to_day_business/screens/enter_data.dart';
import 'package:day_to_day_business/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'add_check.dart';
import 'add_credit.dart';
import 'cash_setle.dart';
import 'company_cheque.dart';

class AddData extends StatelessWidget {
  const AddData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Data'),
          backgroundColor: Color(0xFF19769F),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ReusableButton(
                labelText: 'Add Data',
                nextPage: EnterData(),
              ),
              ReusableButton(
                labelText: 'Add Cheque',
                nextPage: AddCheck(),
              ),
              ReusableButton(
                labelText: 'Add Credit',
                nextPage: AddCredit(),
              ),
              ReusableButton(
                labelText: 'Company Cheque',
                nextPage: CompanyCheque(),
              ),
              ReusableButton(
                labelText: 'Cash Setle',
                nextPage: CashSetle(),
              ),
              ReusableButton(
                labelText: 'Home',
                nextPage: Home(),
              ),
            ],
          ),
        ));
  }
}

class ReusableButton extends StatelessWidget {
  final String labelText;
  final Widget nextPage;

  const ReusableButton({@required this.labelText, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: MyRaisedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextPage));
        },
        size: MediaQuery.of(context).size.width,
        textColor: Colors.white,
        label: labelText,
        roundedBorde: false,
      ),
    );
  }
}
