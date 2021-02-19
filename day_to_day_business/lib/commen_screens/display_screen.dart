import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Display extends StatelessWidget {
  final String image;
  final Widget nextPage;

  const Display({Key key, @required this.image, @required this.nextPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage('assets/images/$image'),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Builder(
                builder: (BuildContext newContext) {
                  return MyRaisedButton(
                    label: 'Day Wise Summary',
                    onPressed: () async {
                      context.read<GetDate>().selectDate(
                          context: newContext,
                          nextPage: nextPage,
                          title: 'getData');
                      // date.selectDate(context: context, nextPage: nextPage, title: 'getData');
                    },
                  );
                },
              ),
              MyRaisedButton(
                label: 'Month Wise Summery',
                onPressed: () {},
              ),
              MyRaisedButton(
                label: 'Summery Of Cheque',
                onPressed: () {},
              ),
              MyRaisedButton(
                label: 'Summery Of Credit',
                onPressed: () {},
              )
            ],
          ))
        ],
      ),
    );
  }
}
