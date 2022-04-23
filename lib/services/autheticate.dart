
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/authenticate/loginScreen.dart';
import '../screens/pages/home.dart';


class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Home();
    } else {
      return LoginScreen();
    }
  }
}