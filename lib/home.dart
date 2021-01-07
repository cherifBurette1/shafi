import 'package:flutter/material.dart';
import 'mainmenu.dart';
import 'more.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int _currentNav = 3;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(60.0), // i want to set second AppBar's height
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Card(
                shadowColor: Colors.transparent,
                semanticContainer: true,
                child: Container(
                  height: 40,
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: translator.currentLanguage == "ar"
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.more_horiz,
                        color: Colors.grey[800],
                        size: 35,
                      ),
                      Text(
                        "1:30 PM",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Text(
                        translator.translate('notify'),
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        leading: Row(children: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: null),
        ]),
        actions: <Widget>[
          Row(
            mainAxisAlignment: translator.currentLanguage == "ar"
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: null),
              SizedBox(
                width: 165,
              )
            ],
          ),
          Align(
            alignment: translator.currentLanguage == "ar"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Text(
              translator.translate('appname'),
              style: TextStyle(fontSize: 25.0, fontFamily: 'Assawt'),
            ),
          ),
          Image.asset('assets/images/shafy.png'),
        ],
        backgroundColor: Colors.blue,
      ),
      body: checkbody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNav,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: translator.translate('more'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: translator.translate('account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: translator.translate('search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: translator.translate('main'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentNav = index;
          });
        },
      ),
    );
  }

  checkbody() {
    switch (_currentNav) {
      case 3:
        return Mainmenu();
        break;
      case 0:
        return More();
        break;
      /*    case 2:
        return 
        break;
      case 1:
        return 
        break;
        case 0:
        return 
        break; */
    }
  }
}
