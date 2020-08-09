import 'package:day_to_day_business/raigam/check_owner.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UseSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){query = '';}
          )
      ];
    }

    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, null);
        }
        );
    }

    @override
    Widget buildResults(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Raigam Cheque').snapshots(),
      builder: (context , snapshot){
        if(!snapshot.hasData)
          return Center(child:CircularProgressIndicator(),);
        final results = snapshot.data.documents.where((DocumentSnapshot a){
          return a.data['Name'].toString().contains(query);
          });
        return ListView(
            children: results.map<Widget>((a){
            return ListTile(
              title:Text(a.data['Name'].toString()),
              onTap: (){
                query = a.data['Name'];
              },
            );
            }).toList(),
          );
        }
      );
    }

    @override
    Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Raigam Cheque').snapshots(),
      builder: (context , snapshot){
        if(!snapshot.hasData)
          return Center(child:CircularProgressIndicator(),);
        final results = snapshot.data.documents.where((DocumentSnapshot a){
          return a.data['Name'].toLowerCase().contains(query);
          });
        return ListView(
            children: results.map<Widget>((a){
            return ListTile(
              title:Text(a.data['Name'],
                style: TextStyle(
                  fontSize:25.0,
                  color:Colors.blue
                ),
              ),
              leading: Icon(Icons.account_balance),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (cotext)=> CheckOwner(name: a.data['Name'],)));
                query = a.data['Name'];
              },
            );
            }).toList(),
          );
        }
      );
  }

}