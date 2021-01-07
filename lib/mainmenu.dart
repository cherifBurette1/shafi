import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Mainmenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 20.0),
          // height: 1000.0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              cara(),
              SizedBox(
                height: 20,
              ),
              secondcard(),
              Divider(
                color: Colors.black,
                thickness: 0.2,
              ),
              nearestshow(translator.translate('showall'),
                  translator.translate('nearestdoctor')),
              generatelist(),
              nearestshow(translator.translate('showall'),
                  translator.translate('nearesthospital')),
              generatelist(),
              nearestshow(translator.translate('showall'),
                  translator.translate('nearestpharma')),
              generatelist(),
            ],
          )),
    );
  }

  generatelist() {
    return Container(
      height: 160,
      width: 340,
      child: Expanded(
          child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          thirdcont(),
          SizedBox(
            width: 10,
          ),
          thirdcont(),
          SizedBox(
            width: 10,
          ),
          thirdcont(),
          SizedBox(
            width: 10,
          ),
          thirdcont(),
        ],
      )),
    );
  }

  firstcard() {
    return Container(
      color: Colors.white,
      height: 100,
      width: 340.0,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/pic.png'),
            Text(translator.translate('ad')),
          ],
        ),
      ),
    );
  }

  secondcard() {
    return Container(
        height: 150,
        width: 360,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
            onTap: () {},
            child: Column(children: [
              Container(
                height: 103,
                width: 103,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(10.0))),
                child: Image.asset('assets/images/alarm.png'),
              ),
              Text(
                translator.translate('medalarm'),
                style: TextStyle(
                    fontFamily: 'Janna', color: Colors.grey[800], fontSize: 18),
              )
            ]),
          ),
          GestureDetector(
            onTap: () {},
            child: Column(children: [
              Container(
                height: 103,
                width: 103,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(10.0))),
                child: Image.asset('assets/images/para.png'),
              ),
              Text(
                translator.translate('doctor'),
                style: TextStyle(
                    fontFamily: 'Janna', color: Colors.grey[800], fontSize: 18),
              )
            ]),
          ),
          GestureDetector(
            onTap: () {
              print('tapped');
            },
            child: Column(children: [
              Container(
                height: 103,
                width: 103,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(10.0))),
                child: Image.asset('assets/images/hosp.png'),
              ),
              Text(
                translator.translate('hospitals'),
                style: TextStyle(
                    fontFamily: 'Janna', color: Colors.grey[800], fontSize: 18),
              )
            ]),
          ),
        ]));
  }

  cara() {
    return CarouselSlider(
        items: [
          firstcard(),
          firstcard(),
          firstcard(),
          firstcard(),
          firstcard(),
        ],
        options: CarouselOptions(
          height: 167,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
        ));
  }

  thirdcont() {
    return Container(
      height: 150,
      width: 340,
      child: new FittedBox(
        child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Container(
                              child: Text(
                            translator.translate('city'),
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                translator.translate('docname'),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14.0,
                                ),
                              )),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                            ],
                          )),
                        ),
                        Container(
                            child: Text(
                          translator.translate('specialization'),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12.0,
                          ),
                        )),
                        RaisedButton(
                          child: Text(translator.translate('km')),
                          onPressed: () {},
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image.asset(
                      'assets/images/pic1.png',
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  nearestshow(String fname, String sname) {
    return Container(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(fname,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                sname,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}
