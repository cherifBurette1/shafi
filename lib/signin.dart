import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:provider/provider.dart';
import 'googlesignin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'base.dart';
import 'introPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

dynamic _userData;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
FocusNode _loginFocusnode = FocusNode();
FocusNode _passwordFocusNode = FocusNode();
FocusNode _phoneFocusNode = FocusNode();
bool secured1 = true;
String bphone;
String bpassword;

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: body(),
    );
  }

  appbar() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(130.0, 20.0, 0.0),
        child: Text(
          translator.translate('signin'),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  logo() {
    return Container(
        child: Transform(
      // you can forcefully translate values left side using Transform
      transform: Matrix4.translationValues(0, -70, 0.0),
      child: Image.asset(
        'assets/images/logo2.png',
        height: 200,
        width: 700,
      ),
    ));
  }

  body() {
    return SingleChildScrollView(
        child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                appbar(),
                logo(),
                createSigninForm(context),
              ],
            )));
  }

  Container submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width * (4 / 5),
      height: 35,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: RaisedButton(
        focusNode: _loginFocusnode,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          //side: BorderSide(color: Colors.red),
        ),
        child: Text(
          translator.translate('signin'),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        color: Colors.blue,
        // color: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {});
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            getUserInfo(bphone, bpassword, context);
          }
        },
      ),
    );
  }

  dynamic googleButton() {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return Container(
                width: MediaQuery.of(context).size.width * (4 / 5),
                height: 35,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      //side: BorderSide(color: Colors.red),
                    ),
                    child: Row(
                        mainAxisAlignment: translator.currentLanguage == "ar"
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(
                            translator.translate('signingoogle'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(30.0))),
                            child: Image.asset("assets/images/google.png"),
                          ),
                        ]),
                    color: Colors.blue,
                    // color: Theme.of(context).primaryColor,
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      if (provider.isSigningIn) {
                        return buildLoading();
                      } else if (snapshot.hasData) {
                        capturegoogledata();
                        Fluttertoast.showToast(msg: 'welcome' + Base.fname);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) => Onboarding()));
                        provider.login();
                      }
                    }),
              );
            }));
  }

  Container facebookButton() {
    return Container(
      width: MediaQuery.of(context).size.width * (4 / 5),
      height: 35,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: RaisedButton(
        focusNode: _loginFocusnode,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          //side: BorderSide(color: Colors.red),
        ),
        child: Row(
            mainAxisAlignment: translator.currentLanguage == "ar"
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(
                translator.translate('signinfb'),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(10.0))),
                child: Image.asset("assets/images/fb.png"),
              ),
            ]),
        color: Colors.blue,
        // color: Theme.of(context).primaryColor,
        onPressed: () {
          _loginfb();
        },
      ),
    );
  }

  Container skipButton() {
    return Container(
      width: MediaQuery.of(context).size.width * (4 / 5),
      height: 35,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: RaisedButton(
        focusNode: _loginFocusnode,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          //side: BorderSide(color: Colors.red),
        ),
        child: Text(
          translator.translate('skipsign'),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        color: Colors.blue,
        // color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Onboarding()));
        },
      ),
    );
  }

  Widget passwordInput() {
    return TextFormField(
      focusNode: _passwordFocusNode,
      keyboardType: TextInputType.text,
      obscureText: secured1,
      decoration: InputDecoration(
          labelText: translator.translate('password'),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          fillColor: Colors.blue,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                secured1 = !secured1;
              });
            },
            child: Icon(secured1 ? Icons.visibility_off : Icons.visibility),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue,
          )),
      textInputAction: TextInputAction.done,
      onSaved: (password) => bpassword = password,
    );
  }

  Widget phoneInput() {
    return TextFormField(
      focusNode: _phoneFocusNode,
      maxLength: 11,
      style: TextStyle(color: Colors.grey),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      //controller: MaskedTextController(mask: "(000) 000-00000"),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1)),
        // counterText: "",
        fillColor: Colors.blue,
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.blue,
        ),
        labelText: translator.translate('phone'),
        hintText: "e.g 01287473131",
        // labelStyle: TextStyle(
        //   color:labelgrey
        // ),
        contentPadding: EdgeInsets.all(1.0), // Inside box padding
      ),
      textInputAction: TextInputAction.next,
      validator: (phone) {
        if (phone.length < 1)
          return 'Please enter a phone number';
        else if (phone.length < 8)
          return 'Invalid Phone Numbers';
        else if (phone.length > 15)
          return 'Invalid Phone Numberx';
        else
          return null;
      },
      onSaved: (phone) => bphone = "+2" + phone,
      onFieldSubmitted: (_) {
        //fieldFocusChange(context, _phoneFocusNode, _cityFocusNode);
      },
    );
  }

  createSigninForm(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  phoneInput(),
                  SizedBox(
                    height: 2,
                  ),
                  passwordInput(),
                  SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    child: Align(
                      alignment: translator.currentLanguage == "ar"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      //widthFactor: 10,
                      child: Text(
                        translator.translate('fpass'),
                        textAlign: translator.currentLanguage == "ar"
                            ? TextAlign.left
                            : TextAlign.right,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    onTap: () {
                      /*   Navigator.push(context,
                         MaterialPageRoute(
                             builder: (BuildContext ctx) => RetrivePassword())); */
                    },
                    splashColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Hero(tag: 'submit', child: submitButton()),
                  divider(),
                  Hero(tag: 'fb', child: facebookButton()),
                  SizedBox(
                    height: 5,
                  ),
                  Hero(tag: 'google', child: googleButton()),
                  SizedBox(
                    height: 5,
                  ),
                  skipButton(),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      child: Align(
                        alignment: Alignment.center,
                        //widthFactor: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(translator.translate('createnacc'),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontSize: 18)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                translator.translate('donthavacc'),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ]),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => SignUp()));
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  divider() {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Colors.black,
              height: 1.0,
            )),
      ),
      Text(translator.translate('or')),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: 1.0,
            )),
      )
    ]);
  }

  _loginfb() async {
    try {
      _userData = await FacebookAuth.instance.login();

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      print(_userData.toString());
      capturefbdata(_userData["name"], _userData["email"], _userData["id"]);
      fbtoast();
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext ctx) => Onboarding()));
    } on FacebookAuthException catch (e) {
      print(e.message);
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    }
  }

  fbtoast() {
    return Fluttertoast.showToast(msg: "welcome " + Base.fname);
  }
}
