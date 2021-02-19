import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_credit_receipts_screen.dart';
import 'package:flutter/material.dart';

class WijayaSearchDelegate extends SearchDelegate {
  final Stream<dynamic> stream;

  WijayaSearchDelegate(this.stream);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wijaya/day-to-day-reports/today-credit')
            .where('isPaided', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          final results = snapshot.data.docs.where((DocumentSnapshot a) {
            return a.data()['Name'].toString().contains(query);
          });
          print(snapshot.data.docs[0].data().toString());
          return ListView(
            children: results.map<Widget>((a) {
              return ListTile(
                title: Text(a.data()['Name'].toString()),
                onTap: () {
                  query = a.data()['Name'];
                },
              );
            }).toList(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wijaya/day-to-day-reports/today-credit')
            .where('isPaided', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          final results = snapshot.data.docs.where((DocumentSnapshot a) {
            return a.data()['Name'].toLowerCase().contains(query);
          });
          print(snapshot.data.docs.length);
          return ListView(
            children: results.map<Widget>((a) {
              return ListTile(
                title: Text(
                  a.data()['Name'],
                  style: TextStyle(fontSize: 25.0, color: Colors.blue),
                ),
                leading: Icon(Icons.account_balance),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (cotext) => WijayaCreditReciepts(
                                name: a.data()['Name'],
                              )));
                  query = a.data()['Name'];
                },
              );
            }).toList(),
          );
        });
  }
}
