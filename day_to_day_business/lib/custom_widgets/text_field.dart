import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final Function validator;
  final bool addValidator;
  final Function onSaved;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function onTap;
  final TextEditingController textEditingController;

  MyTextFormField({
    this.labelText,
    this.validator,
    this.addValidator = false,
    this.onSaved,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onFieldSubmitted,
    this.onTap,
    this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF19769F), width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF19769F), width: 2.0)),
        ),
        obscureText: isPassword ? true : false,
        validator: addValidator
            ? validator
            : (String value) {
                if (value.isEmpty) {
                  return ' $labelText is required';
                }
                return null;
              },
        onSaved: onSaved,
        keyboardType: keyboardType,
        onTap: onTap,
      ),
    );
  }
}
