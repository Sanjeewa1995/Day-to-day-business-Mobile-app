import 'package:day_to_day_business/custom_widgets/buttons.dart';
import 'package:day_to_day_business/custom_widgets/text_field.dart';
import 'package:day_to_day_business/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget _email() {
    return MyTextFormField(
      textEditingController: _emailController,
      labelText: 'Email',
      focusNode: _emailFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _emailFocus, _passwordFocus);
      },
    );
  }

  _buildPassword() {
    return MyTextFormField(
      textEditingController: _passwordController,
      labelText: 'Password',
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocus,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
      },
    );
  }

  _submitLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((user) {
        print(user);
         Navigator.push(
              context, MaterialPageRoute(builder: (context) => SplashScreen()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[_email(), _buildPassword(), MyRaisedButton(
            label: 'Login',
            roundedBorde: true,
            onPressed: _submitLogin,
          )],
        ),
      ),
    );
  }
}
