import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressView extends StatefulWidget {
  ProgressView({Key key}) : super(key: key);

  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80.0),
      child: Container(
        width: 70.0,
        height: 70.0,
        child: SizedBox(
          height: 60.0,
          width: 60.0,
          child: SpinKitCircle(color: Color(0xFF85091B), size: 60),
        ),
      ),
    );
  }
}
