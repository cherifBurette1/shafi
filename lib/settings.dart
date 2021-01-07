import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ExpandedTileController _controller;
  ExpandedTileController _controller2;
  void initState() {
    // initialize controller
    _controller = ExpandedTileController();
    _controller2 = ExpandedTileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app(context),
      body: body(),
    );
  }

  body() {
    return Container(
        child: Column(children: [
      ExpandedTile(
        controller: _controller,
        checkable: false, // check box enabled or not
        leading: Icon(
          Icons.public,
          color: Colors.blue,
        ),
        centerHeaderTitle: false,
        title: Text(
          translator.translate('settings'),
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        content: Container(
          child: Column(
            children: <Widget>[
              FlatButton(
                  child: Text(
                    "العربيه",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    translator.setNewLanguage(context,
                        newLanguage: 'ar', restart: true);
                  }),
              FlatButton(
                  child: Text(
                    "English",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    translator.setNewLanguage(context,
                        newLanguage: 'en', restart: true);
                  }),
            ],
          ),
        ),
      ),
      ExpandedTile(
        controller: _controller2,
        checkable: false, // check box enabled or not
        leading: Icon(
          Icons.public,
          color: Colors.blue,
        ),
        centerHeaderTitle: false,
        title: Text(
          translator.translate('appup'),
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    translator.translate('update'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Assawt",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {}),
              Text(
                "1.0.4",
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}

app(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: translator.currentLanguage == "ar"
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Text(translator.translate('settings'),
            style: TextStyle(
                fontFamily: "Assawt",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(
          width: 5,
        ),
        IconButton(
          icon: translator.currentLanguage == "ar"
              ? Icon(Icons.arrow_forward)
              : Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
