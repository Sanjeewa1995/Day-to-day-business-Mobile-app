import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final Function onTap;
  final TextInputType keyboardType;

MyTextFormField({
    this.hintText,
    this.labelText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.onTap,
    this.keyboardType
  });
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType:keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding: EdgeInsets.all(15.0),
          border:InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide:BorderSide(color: Colors.green , width:2.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:BorderSide(color: Colors.blue , width:2.0)
          ),
          errorBorder: OutlineInputBorder(
            borderSide:BorderSide(color: Colors.blue , width:2.0)
          ),
          focusedErrorBorder:  OutlineInputBorder(
            borderSide:BorderSide(color: Colors.green , width:2.0)
          ),
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        onTap: onTap,
      ),
    );
  }
}

class Model {
  String date;
  int sale;
  int diesel;
  int employee;
  int tea;
  int other;
  double discount;
  String month;
  String name;

Model({this.date, this.sale, this.diesel, this.employee, this.tea, this.other ,this.discount, this.month, this.name });
}



