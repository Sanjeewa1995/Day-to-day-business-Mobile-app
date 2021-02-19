import 'package:day_to_day_business/login.dart';
import 'package:day_to_day_business/screens/select_compant_screen.dart';
import 'package:day_to_day_business/screens/splash_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_enter_data_screen.dart';
import 'package:day_to_day_business/screens/wijaya/wijaya_tabbar_screen.dart';
import 'package:day_to_day_business/serviceess/firebase_service/firebase_service.dart';
import 'package:day_to_day_business/serviceess/provider/date_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessControle extends StatefulWidget {
  AccessControle({Key key}) : super(key: key);

  @override
  _AccessControleState createState() => _AccessControleState();
}

class _AccessControleState extends State<AccessControle> {
  bool _loading = true;
  bool _isAuth = false;
  Widget activePage;

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      getIdTokenResult(auth.currentUser);
      print(auth.currentUser.uid);
      setState(() {
        _isAuth = true;
        _loading = false;
      });
    } else {
      setState(() {
        _isAuth = false;
        _loading = false;
      });
    }
  }

  getIdTokenResult(user) async {
    IdTokenResult result = await user.getIdTokenResult(true);
    print(result.claims['superAdmin']);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();
    if (_isAuth) {
      activePage = SelectCompany();
    } else {
      activePage = LogIn();
    }

    return _loading ? CircularProgressIndicator() : activePage;

    // return MultiProvider(providers: [
    //   ChangeNotifierProvider(create: (context) => GetDate()),
    //   FutureProvider(
    //       create: (context) => firebaseService.fetchAllradyAddedDates()),
    // ], child: _loading ? CircularProgressIndicator() : activePage);
  }
}
