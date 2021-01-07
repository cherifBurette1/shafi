import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Transform(
            transform: Matrix4.translationValues(200, 0, 0.0),
            child: Text(
              translator.translate('terms'),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Assawt',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              icon: translator.currentLanguage == "ar"
                  ? Icon(Icons.arrow_forward_rounded)
                  : Icon(Icons.arrow_back),
              onPressed: () {},
              color: Colors.white,
            )
          ],
        ),
        body: ListView(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: translator.currentLanguage == "ar"
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                Align(
                  alignment: translator.currentLanguage == "ar"
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Text(translator.translate('exptit'),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Assawt',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Text(translator.translate('web'),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Assawt',
                              fontSize: 16,
                            )),
                      )),
                ),
              ],
            ),
          )
        ]));
  }
}
