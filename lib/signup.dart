import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'phone.dart';
import 'terms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'base.dart';
import 'package:provider/provider.dart';
import 'googlesignin.dart';
import 'introPage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  FocusNode _signupFocusnode = FocusNode();
  FocusNode _fnameFocusNode = FocusNode();
  FocusNode _lnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _signUpFocusnode = FocusNode();
  String firstname = "a";
  String lastname = "a";
  String aemail;
  String aphone;
  String apassword;
  String verificationId;
  String smssent;
  bool secured1 = true;
  dynamic _userData;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          translator.translate('createnacc'),
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
    return ListView(children: [
      Container(
        child: Form(
            key: _formKey1,
            child: Column(
              children: [
                appbar(),
                logo(),
                Hero(tag: 'fb', child: facebookbutton1()),
                Hero(tag: 'google', child: googlebutton1()),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    nameInput(_fnameFocusNode, _lnameFocusNode,
                        translator.translate('fname'), firstname, true),
                    SizedBox(
                      width: 10,
                    ),
                    nameInput(_lnameFocusNode, _lnameFocusNode,
                        translator.translate('lname'), lastname, false),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                emailInput(),
                phoneinput1(),
                passwordinput1(),
                InkWell(
                    child: Align(
                      alignment: translator.currentLanguage == "ar"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      //widthFactor: 1,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(translator.translate('terms'),
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              translator.translate('agree'),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Terms()));
                    }),
                Hero(tag: 'submit', child: submitbutton1()),
                //createSigninForm(context),
                InkWell(
                    child: Align(
                      alignment: translator.currentLanguage == "ar"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      //widthFactor: 1,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(translator.translate('signin'),
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              translator.translate('already'),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ]),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            )),
      )
    ]);
  }

  dynamic googlebutton1() {
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
                    focusNode: _signupFocusnode,
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

  facebookbutton1() {
    return Container(
      width: MediaQuery.of(context).size.width * (4 / 5),
      height: 35,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: RaisedButton(
        focusNode: _signupFocusnode,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
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

  Widget nameInput(FocusNode name, FocusNode nextfocus, String label,
      String global, bool namechoice) {
    return Container(
        width: MediaQuery.of(context).size.width / 2 - 15,
        child: TextFormField(
          focusNode: name,
          style: TextStyle(color: Colors.grey),
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          ],
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            fillColor: Colors.grey,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            labelText: label,
            hintText: "e.g Morgan",
            // labelStyle: TextStyle(
            //   color:labelgrey
            // ),
            contentPadding: EdgeInsets.all(12.0), // Inside box padding
          ),
          textInputAction: TextInputAction.next,
          validator: (name) {
            Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
            RegExp regex = new RegExp(pattern);
            if (name.length < 1)
              return 'First Name is required';
            else if (name.length > 25)
              return 'Too long';
            else if (!regex.hasMatch(name))
              return 'Invalid Name';
            else
              return null;
          },
          onSaved: (name) {
            global = name;
            if (namechoice == true) {
              setState(() {
                firstname = global;
              });
            } else if (namechoice == false) {
              setState(() {
                lastname = global;
              });
            }
          },
          onFieldSubmitted: (_) {
            fieldFocusChange(context, name, nextfocus);
          },
        ));
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget emailInput() {
    return TextFormField(
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1)),
        fillColor: Colors.blue,
        prefixIcon: Icon(
          Icons.email,
          color: Colors.blue,
        ),
        labelText: translator.translate('email'),
        hintText: "e.g abc@gmail.com",
        // labelStyle: TextStyle(
        //   color:labelgrey
        // ),
        contentPadding: EdgeInsets.all(12.0), // Inside box padding
      ),
      textInputAction: TextInputAction.next,
      validator: (email) =>
          EmailValidator.validate(email) ? null : "Invalid email address",
      onSaved: (email) => aemail = email,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _emailFocusNode, _phoneFocusNode);
      },
    );
  }

  Widget passwordinput1() {
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
      validator: (password) {
        //Minimum eight characters, at least one uppercase letter, one lowercase letter and one number:
        Pattern pattern =
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(password)) {
          Fluttertoast.showToast(
              msg:
                  "Password should be:\nMinimum six characters\nAt least one uppercase letter,\nOne lowercase letter\n one number\n and one secial char");
          return 'Invalid password Format';
        } else {
          apassword = password;
          return null;
        }
      },
      onSaved: (password) => apassword = password,
    );
  }

  Container submitbutton1() {
    return Container(
      width: MediaQuery.of(context).size.width * (4 / 5),
      height: 35,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: RaisedButton(
        focusNode: _signUpFocusnode,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          //side: BorderSide(color: Colors.red),
        ),
        child: Text(
          translator.translate('createnacc'),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        color: Colors.blue,
        // color: Theme.of(context).primaryColor,
        onPressed: () {
          if (_formKey1.currentState.validate()) {
            _formKey1.currentState.save();
            setState(() {
              Base.authy = firebaseAuth;
              Base.fname = firstname;
              Base.lname = lastname;
              Base.email = aemail;
              Base.password = apassword;
              Base.phoneno = aphone;
            });
            verifyphone(aphone);
          }
        },
      ),
    );
  }

  Widget phoneinput1() {
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
        contentPadding: EdgeInsets.all(12.0), // Inside box padding
      ),
      textInputAction: TextInputAction.next,
      validator: (phone) {
        if (phone.length < 1)
          return 'Please enter a phone number';
        else if (phone.length < 8)
          return 'Invalid Phone Numbers';
        else if (phone.length > 15)
          return 'Invalid Phone Numbers';
        else
          return null;
      },
      onSaved: (phone) => aphone = "+2" + phone,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _phoneFocusNode, _passwordFocusNode);
      },
    );
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
    } finally {
      // update the view

    }
  }

  fbtoast() {
    return Fluttertoast.showToast(msg: "welcome " + Base.fname);
  }

  Future<void> verifyphone(String phoneNo) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
      setState(() {
        Base.verifi = verificationId;
        Base.authy = firebaseAuth;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext ctx) => Phone()));
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      firebaseAuth.signInWithCredential(auth).then((UserCredential value) {
        if (value.user != null) {
          // ignore: deprecated_member_use
          // FirebaseUser user = value.user;

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
}
