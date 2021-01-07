import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        // height: 1000.0,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/shafy-30562.appspot.com/o/logo2.png?alt=media&token=63fb7ca7-6faf-463e-88c4-5095892124ae"),
                  fit: BoxFit.contain),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: translator.currentLanguage == "ar"
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  translator.translate('about'),
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Assawt',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.phone_android,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: translator.currentLanguage == "ar"
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  translator.translate('contact'),
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Assawt',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.headset,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: translator.currentLanguage == "ar"
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  translator.translate('medins'),
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Assawt',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.people,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
            child: Row(
              mainAxisAlignment: translator.currentLanguage == "ar"
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  translator.translate('settings'),
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Assawt',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
