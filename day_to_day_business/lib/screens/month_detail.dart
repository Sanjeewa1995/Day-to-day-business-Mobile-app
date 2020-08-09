// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MonthDetail extends StatefulWidget {
//   MonthDetail({Key key}) : super(key: key);

//   _MonthDetailState createState() => _MonthDetailState();
// }

// class _MonthDetailState extends State<MonthDetail> {

//        getData1() async {
//     var firestore = Firestore.instance;
//     var  qn = await firestore.collection('Wijaya Check').where('Date' , isEqualTo: '2020.05.05').snapshots();
//     return qn;
//     }

//     Stream _data;
//   int sumCheck =0;


 

//    @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//       getData1().then((result){
//         setState(() {
//           _data = result;
//         });
//       });
//   }

//   _mmm(){
//       var stream =  StreamBuilder(
//         stream: _data,
//         builder:(context , snapshot){
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return Center(
//               child:Text('Loading')
//             );
//           } else{
//               return ListView.builder(
//                 itemCount: 1,
//                 itemBuilder: (context , index){
//                   int i =1;
//                   int t =0;

//                   for(i; i<=snapshot.data.documents.length; i++){
//                     sumCheck +=  snapshot.data.documents[t].data['Value'];
//                     t++;
//                   } return Text('sumCheck.toString()');
//                 },
//               );
//             }
//         }
//       );
//     return stream;
//  }


//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     body: Column(
//     children:<Widget>[
//       _mmm(),
//     ]
//   )
//   );
 
//   }
// }