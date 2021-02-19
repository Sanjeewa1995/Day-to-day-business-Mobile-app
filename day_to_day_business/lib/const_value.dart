import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const titleStyle2 = TextStyle(
  fontSize: 20,
  color: Color(0xFF19769F),
  fontWeight: FontWeight.bold,
);

final headerStyle = GoogleFonts.yanoneKaffeesatz(
  color: Color(0xFF19769F),
  textStyle: TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
  ),
);

const alertStyle = AlertStyle(
    isOverlayTapDismiss: false,
    backgroundColor: Color(0xFFf5f5f5),
    titleStyle: TextStyle(
      color: Color(0xFF19769F),
    ));
