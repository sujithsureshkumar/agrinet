
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/users.dart';
import '../screens/authenticate/loginScreen.dart';
import '../screens/pages/home.dart';
import 'package:provider/provider.dart';


class Authenticate extends StatelessWidget {
  //final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print(user);
    if (user != null) {
      return Home();
    } else {
      return LoginScreen();
    }
  }
}