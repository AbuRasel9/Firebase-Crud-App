import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_cli/ui/home/home_screen.dart';

import '../ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    //
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(uid: _auth.currentUser?.uid ?? "",),
                ),
                (route) => false,
              ) /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ))*/
          );
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                (route) => false,
              ) /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ))*/
          );
    }
  }
}
