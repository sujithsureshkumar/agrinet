import 'package:flutter/material.dart';
import 'package:AgriNet/services/auth.dart';

class SignOut extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);



  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _auth.signOut();
      },
      child: const Text(
        'Click to Sign Out',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}