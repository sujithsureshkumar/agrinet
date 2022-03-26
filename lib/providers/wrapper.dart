import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:AgriNet/screens/authenticate/authenticate.dart';
import 'package:AgriNet/screens/pages/profile_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);
    ProfileData profile =Provider.of<ProfileData>(context);
    print(user);
    profile.setFirebaseProfileCheck();
    // return either the Home or Authenticate widget
    if (user == null ){
      return Authenticate();
    }
    else {
      return Home();
    }

  }
}