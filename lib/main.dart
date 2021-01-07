import 'package:elagy/signin.dart';
import 'package:flutter/material.dart';
import 'grad.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await translator
      .init(languagesList: ['ar', 'en'], assetsDirectory: 'assets/langs/');
  await Firebase.initializeApp();
  runApp(LocalizedApp(child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: translator.delegates,
        locale: translator.locale,
        supportedLocales: translator.locals(),
        home: AnimatedSplashScreen(
          splash: Lolo(),
          splashIconSize: 1500,
          nextScreen: Signin(),
          splashTransition: null,
        ));
  }

  gradientcolor() {}
}
