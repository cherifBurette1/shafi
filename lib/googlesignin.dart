import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'base.dart';
import 'background_painter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'introPage.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

capturegoogledata() {
  final user = FirebaseAuth.instance.currentUser;
  Base.fname = user.displayName;
  Base.email = user.email;
  Base.phoneno = user.phoneNumber;
  Base.id = user.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  users.add({
    'displayName': Base.fname,
    'uid': Base.id,
    'email': Base.email,
    'phone': Base.phoneno
  });
  return;
}

Widget buildLoading() => Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: BackgroundPainter()),
        Center(child: CircularProgressIndicator()),
      ],
    );
capturefbdata(String fname, String email, String id) {
  Base.fname = fname;
  Base.email = email;
  Base.id = id;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  users.add({
    'displayName': Base.fname,
    'uid': Base.id,
    'email': Base.email,
    'phone': ""
  });
  return;
}

getUserInfo(String phone, String password, BuildContext context) {
  // ignore: unused_local_variable
  var firebaseId = FirebaseFirestore.instance
      .collection('Users')
      .where('phone', isEqualTo: phone)
      // ignore: deprecated_member_use
      .getDocuments()
      .then((QuerySnapshot shot) {
    if (shot.docs.isNotEmpty) {
      var userd = shot.docs[0].id;
      print(userd.toString());
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userd)
          .get()
          .then((value) {
        print(value.data());
        var akh = value.data().values;
        print(akh.toList().toString());
        if (akh.elementAt(1) == password) {
          Base.password = akh.elementAt(1);
          Base.phoneno = akh.elementAt(2);
          Base.fname = akh.elementAt(3);
          Base.email = akh.elementAt(4);
          toast("Welcome back! " + Base.fname);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Onboarding()));
        } else {
          toast("Wrong information");
        }
      });
    }
  });
}

toast(String text) {
  return Fluttertoast.showToast(msg: text);
}
