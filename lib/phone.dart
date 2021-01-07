import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'base.dart';
import 'home.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  FocusNode _codeFocusNode = FocusNode();
  FocusNode _codeupFocusnode = FocusNode();
  String code1;
  String verificationId1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body2(),
    );
  }

  body2() {
    return ListView(children: [
      Container(
          child: Column(children: [
        appbar(),
        logo(),
        codeinput1(),
        SizedBox(
          height: 30,
        ),
        submitbutton1(),
        SizedBox(
          height: 50,
        ),
        resend(),
        SizedBox(
          height: 120,
        ),
        signinback(),
      ]))
    ]);
  }

  appbar() {
    return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Column(children: [
          Transform(
              transform: Matrix4.translationValues(150.0, 20.0, 0.0),
              child: IconButton(
                  icon: translator.currentLanguage == "ar"
                      ? Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          Transform(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            child: Text(
              translator.translate('activatepn'),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ]));
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

  Widget codeinput1() {
    return Center(
        child: TextFormField(
      maxLength: 6,
      focusNode: _codeFocusNode,
      style: TextStyle(color: Colors.blue),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1)),
        fillColor: Colors.blue,
        hintText: " *  *  *  *  *  * ",
        contentPadding: EdgeInsets.all(12.0), // Inside box padding
      ),
      textInputAction: TextInputAction.next,
      onChanged: (code) {
        setState(() {
          code1 = code;
        });
      },
      onSaved: (code) {
        setState(() {
          code1 = code;
        });
      },
      onFieldSubmitted: (_) {},
    ));
  }

  resend() {
    return InkWell(
        child: Align(
          alignment: Alignment.centerRight,
          //widthFactor: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(translator.translate('resend'),
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Assawt')),
            SizedBox(
              width: 5,
            ),
            Text(
              translator.translate('didntgetcode'),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: 'Assawt',
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        onTap: () {
          verifyphone(Base.phoneno);
        });
  }

  signinback() {
    return InkWell(
        child: Align(
          alignment: Alignment.bottomCenter,
          //widthFactor: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(translator.translate('bktosi'),
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Assawt')),
          ]),
        ),
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => App()),
              (Route<dynamic> route) => false);
        });
  }

  Container submitbutton1() {
    return Container(
      width: MediaQuery.of(context).size.width * (4 / 5),
      height: 35,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: RaisedButton(
          focusNode: _codeupFocusnode,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            //side: BorderSide(color: Colors.red),
          ),
          child: Text(
            translator.translate('activate'),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          color: Colors.blue,
          // color: Theme.of(context).primaryColor,
          onPressed: () {
            verifycode(Base.verifi);
          }
          //handle_National_Id();

          ),
    );
  }

  void verifycode(String verificationId) async {
    final code = code1;
    // ignore: deprecated_member_use
    PhoneAuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      // ignore: deprecated_member_use
      User user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          Base.id = user.uid;
        });
        userSetup();
        Navigator.push(
            context, MaterialPageRoute(builder: (BuildContext ctx) => Home()));
        Fluttertoast.showToast(msg: "welcome " + Base.fname + " " + Base.lname);
      } else {
        setState(() {
          Base.token = "";
          Base.password = "";
          Base.verifi = "";
          Base.email = "";
          Base.fname = "";
          Base.lname = "";
          Base.id = "";
        });
      }
    } catch (err) {
      print(err);
      setState(() {
        Base.token = "";
        Base.password = "";
        Base.email = "";
        Base.fname = "";
        Base.lname = "";
        Base.id = "";
      });
      Fluttertoast.showToast(msg: err);
    }
  }

  Future<void> verifyphone(String phoneNo) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      verificationId1 = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      verificationId1 = verId;
      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext ctx) => Phone()));
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      Base.authy.signInWithCredential(auth).then((UserCredential value) {
        if (value.user != null) {
          // ignore: deprecated_member_use
          // FirebaseUser user = value.user;
          setState(() {
            verificationId1 = Base.verifi;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Phone()));
        } else {
          debugPrint('user not authorized');
        }
      }).catchError((error) {
        debugPrint('error: $error');
      });
    };
    final PhoneVerificationFailed veriFailed =
        (FirebaseAuthException exception) {
      print('${exception.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<void> userSetup() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    users.add({
      'displayName': Base.fname + " " + Base.lname,
      'uid': Base.id,
      'email': Base.email,
      'password': Base.password,
      'phone': Base.phoneno
    });
    return;
  }
}
