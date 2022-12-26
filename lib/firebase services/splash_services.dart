import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/home_screen.dart';
import 'package:firebase_authentication/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class SplashServices {
  void isLogIn(BuildContext context) {

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(
        const Duration(seconds: 3),
            () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())),
      );
    }else{
      Timer(
        const Duration(seconds: 3),
            () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignInScreen())),
      );
    }
  }
}
