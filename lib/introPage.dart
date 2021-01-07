import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'home.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return OnBoardingPage();
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0, color: Colors.black);
    const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 19.0, fontWeight: FontWeight.w700, color: Colors.black),
        bodyTextStyle: bodyStyle,
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        pageColor: const Color.fromARGB(0, 245, 246, 250),
        imagePadding: EdgeInsets.only(top: 0.0));
    //footerPadding: EdgeInsets.only(top: 75));

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: translator.currentLanguage == "ar"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text(
                        translator.translate('skip'),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ],
              ),
            ),
            body: IntroductionScreen(
              key: introKey,
              pages: [
                PageViewModel(
                    titleWidget: Container(
                      child: Column(
                        children: [
                          Text(
                            translator.translate('maintxt'),
                          )
                        ],
                      ),
                    ),
                    body: translator.translate('exp'),
                    image: Image.asset('assets/images/s1.png'),
                    decoration: pageDecoration,
                    footer: Align(
                        alignment: translator.currentLanguage == "ar"
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight,
                        child: Row(
                            mainAxisAlignment:
                                translator.currentLanguage == "ar"
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  introKey.currentState?.animateScroll(1);
                                },
                                child: Text(
                                  translator.translate('next'),
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ]))),
                PageViewModel(
                    titleWidget: Container(
                      child: Column(
                        children: [
                          Text(
                            translator.translate('maintxt'),
                          )
                        ],
                      ),
                    ),
                    body: translator.translate('exp'),
                    image: Image.asset('assets/images/s2.png'),
                    decoration: pageDecoration,
                    footer: Row(
                        mainAxisAlignment: translator.currentLanguage == "ar"
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              introKey.currentState?.animateScroll(0);
                            },
                            child: Text(
                              translator.translate('prev'),
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                          ),
                          RaisedButton(
                            onPressed: () {
                              introKey.currentState?.animateScroll(2);
                            },
                            child: Text(
                              translator.translate('next'),
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ])),
                PageViewModel(
                  titleWidget: Container(
                    child: Column(
                      children: [
                        Text(
                          translator.translate('maintxt'),
                        )
                      ],
                    ),
                  ),
                  body: translator.translate('exp'),
                  image: Image.asset('assets/images/s3.png'),
                  footer: Row(
                      mainAxisAlignment: translator.currentLanguage == "ar"
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            introKey.currentState?.animateScroll(1);
                          },
                          child: Text(
                            translator.translate('prev'),
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                          child: Text(
                            translator.translate('start'),
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ]),
                  decoration: pageDecoration,
                ),
              ],
              dotsDecorator: const DotsDecorator(
                spacing: EdgeInsets.only(bottom: 100),
                size: Size(10.0, 5.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(10.0, 10.0),
                activeColor: Colors.lightBlue,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),
              ),
              onSkip: () {
                introKey.currentState?.animateScroll(0);
              },
              onDone: () {},
              showSkipButton: false,
              showNextButton: false,
              skipFlex: 0,
              nextFlex: 0,
              done: Container(
                  height: 0.1,
                  width: 0.1,
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    enableFeedback: false,
                    onPressed: null,
                  )),
            )));
  }
}
