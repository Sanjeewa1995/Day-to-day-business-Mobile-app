import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final Color textColor;
  final double size;
  final String label;
  final bool roundedBorde;


  MyRaisedButton({
    this.onPressed,
    this.color,
    this.textColor,
    this.size,
    this.label,
    this.roundedBorde,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child:  Container(
        width: size,
        height: 50.0,
        child: RaisedButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(0.0),
        child:  Container(
             // height: 50.0,
             // width: 150.0,
              decoration:   BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
                borderRadius: roundedBorde? BorderRadius.circular(20.0) :  BorderRadius.circular(0.0)
              ),
              child:Center(
                child: Text(label, style: TextStyle(fontSize: 20)),
              ),
            ),
        color: color,
        textColor: textColor,
        shape:  RoundedRectangleBorder(
        borderRadius:  roundedBorde? BorderRadius.circular(20.0) :  BorderRadius.circular(0.0)
        ),
        ),
      ) ,
      );
  }
}