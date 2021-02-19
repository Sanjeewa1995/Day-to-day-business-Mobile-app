
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/const_value.dart';
import 'package:day_to_day_business/custom_widgets/progress_dialog.dart';
import 'package:day_to_day_business/custom_widgets/text_field.dart';
import 'package:day_to_day_business/screens/select_compant_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:day_to_day_business/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CreditReceipts extends StatefulWidget {
  final String name;
  final String creditEndPoint;
  final String todayReportsEndPoint;

  const CreditReceipts(
      {Key key,
      @required this.name,
      @required this.creditEndPoint,
      @required this.todayReportsEndPoint})
      : super(key: key);

  @override
  _CreditReceiptsState createState() => _CreditReceiptsState();
}

class _CreditReceiptsState extends State<CreditReceipts> {
  ProgressDialog _dialog;
  final GlobalKey<FormState> _payCashFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
  }

  _dateFlicker(String id, List data, int value, int totolPayCash) async {
    showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 16,
      theme: ThemeData.dark(),
    ).then((day) async {
      _dialog.show();
      String date = DateFormat('yyyy.MM.dd').format(day);
      List allData = [
        ...data,
        {date: value}
      ];
      await FirebaseFirestore.instance
          .collection(widget.todayReportsEndPoint)
          .where('Date', isEqualTo: date)
          .get()
          .then((documents) async {
        int todayPayCash = documents.docs[0].data()['TodayPayCash'];
        int newPayCash = todayPayCash + value;
        await FirebaseFirestore.instance
            .collection(widget.todayReportsEndPoint)
            .doc(documents.docs[0].id)
            .update({'TodayPayCash': newPayCash});
      });
      await FirebaseFirestore.instance
          .collection(widget.creditEndPoint)
          .doc(id)
          .update({'PaidSummery': allData, 'TotolPayCash': totolPayCash}).then(
              (value) {
        _dialog.hide();
        Alerts.showMessage(context, 'Data added success',
            title: '', hideCancleButton: true, responseFunction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(WijayaTabBar.routeName,
              ModalRoute.withName(SelectCompany.routeName));
        });
      }).catchError((error) {
        _dialog.hide();
        Alerts.showMessage(context, error.toString(), responseFunction: () {
          Navigator.of(context).pop();
        });
      });
    });
  }

  _addPayCashAlert(String id, List data, int totolPayCash) {
    final TextEditingController _valueController = TextEditingController();
    return Alert(
        style: alertStyle,
        title: 'Add Pay Credit',
        context: context,
        content: Builder(builder: (BuildContext context) {
          return Form(
            key: _payCashFormKey,
            child: Column(
              children: <Widget>[
                MyTextFormField(
                  textEditingController: _valueController,
                  labelText: 'Value',
                ),
              ],
            ),
          );
        }),
        buttons: [
          DialogButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (!_payCashFormKey.currentState.validate()) {
                return;
              }
              int newTotolPayCash =
                  totolPayCash + int.parse(_valueController.text);
              Navigator.of(context).pop();
              _dateFlicker(
                  id, data, int.parse(_valueController.text), newTotolPayCash);
            },
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF19769F),
                Color(0xFF35D6A6),
              ],
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.name);
    return Scaffold(
      appBar: AppBar(title: Text(widget.name.toUpperCase()), centerTitle: true),
      body: Container(
        height: 500,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(widget.creditEndPoint)
                .where('Name', isEqualTo: widget.name)
                .where('isPaided', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Map document = snapshot.data.docs[index].data();
                      String name = document['Name'];
                      String invoice = document['Invoice Number'];
                      int value = document['Value'];
                      bool isPaided = document['isPaided'];
                      int totolPayCash = document['TotolPayCash'];
                      List payCash = document['PaidSummery'];
                      List<Widget> list = [];

                      for (int i = 0; i < payCash.length; i++) {
                        List<Widget> list1 = [
                          ...payCash[i].keys.map((key) => Text(
                                '$key- Rs${payCash[i][key]}',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xFF19769F),
                                    fontWeight: FontWeight.bold),
                              ))
                        ];
                        list = List.from(list)..addAll(list1);
                      }

                      print(list.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Card(
                          color: Color(0xFFa6e3e9),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: $name', style: titleStyle2),
                                Text(
                                  'Invoice Number: $invoice',
                                  style: titleStyle2,
                                ),
                                Text('Value: $value', style: titleStyle2),
                                Text('Totol Pay Cash: $totolPayCash',
                                    style: titleStyle2),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pay Summery: ',
                                        style: titleStyle2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...list,
                                          FlatButton(
                                              color: Color(0xFFf07b3f),
                                              child: Text('Add'),
                                              onPressed: () {
                                                _addPayCashAlert(
                                                    snapshot
                                                        .data.docs[index].id,
                                                    payCash,
                                                    totolPayCash);
                                              }),
                                        ],
                                      )
                                    ]),
                                Row(
                                  children: [
                                    Text(
                                      'Bill Settle: ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Checkbox(
                                        activeColor: Colors.green,
                                        value: isPaided,
                                        onChanged: (bool value) {
                                          FirebaseFirestore.instance
                                              .collection(widget.creditEndPoint)
                                              .doc(snapshot.data.docs[index].id)
                                              .update({'isPaided': true});
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
