import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 55.0;
  final Widget lead=null;
  final Widget traile;

  const CustomAppBar({Key key, this.title, this.traile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //width: double.infinity *1/3,
            child: lead != null
                ? lead
                : IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
          ),
          Container(
            // width: double.infinity *1/3,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 45,
            child: traile != null ? traile : Container(),
          )
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF19769F),
              Color(0xFF35D6A6),
            ],
            // begin: const FractionalOffset(0.0, 0.0),
            // end: const FractionalOffset(0.5, 0.0),
            // stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
