import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class Lolo extends StatefulWidget {
  @override
  _LoloState createState() => _LoloState();
}

double _width = 300;

class _LoloState extends State<Lolo> {
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xff3DBCA7),
            Color(0xff007AE7),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: MirrorAnimation<double>(
                tween: Tween(
                    begin: -5, end: 5), // <-- value for offset x-coordinate
                duration: Duration(milliseconds: 150),
                curve: Curves.linear, // <-- non-linear animation
                builder: (context, child, value) {
                  return Transform.translate(
                      offset: Offset(value, 0),
                      child: Container(
                          width: _width,
                          height: MediaQuery.of(context).size.height,
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                            image:
                                new AssetImage("assets/images/thatthing.png"),
                            fit: BoxFit.fill,
                          ))));
                }),
          ),
          Expanded(
              flex: 6,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ))),
          Expanded(
            flex: 2,
            child: MirrorAnimation<double>(
                tween: Tween(
                    begin: -5, end: 5), // <-- value for offset x-coordinate
                duration: Duration(milliseconds: 150),
                curve: Curves.linear, // <-- non-linear animation
                builder: (context, child, value) {
                  return Transform.translate(
                      offset: Offset(value, 0),
                      child: Container(
                          width: _width,
                          height: MediaQuery.of(context).size.height,
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                            image:
                                new AssetImage("assets/images/thatthing.png"),
                            fit: BoxFit.fill,
                          ))));
                }),
          ),
        ],
      ),
    );
  }
}
