import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:AgriNet/screens/authenticate/authenticate.dart';
import 'package:AgriNet/screens/pages/profile_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/firebase_api_methods.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);
    ProfileData profile =Provider.of<ProfileData>(context);
    //profile.getProfileSetCount();
    //print(user);
    //profile.fetchFirebaseProfile(user.uid);
    // return either the Home or Authenticate widget
    if (user == null ){
      return Authenticate();
    }
    //else if (profile.profileSetCount<1){return ProfileSelection();}
    else {
      profile.checkIfDocExists(user.uid);
      if(!profile.userExist) {
        setUserProfile(user.uid,false,false,false,true);
      }

      profile.fetchFirebaseProfile(user.uid);
      profile.getProfileSetCount();
      print(user);

      if (profile.profileSetCount<1){
        return ProfileSelection();
      }
      else{
      return Home();
      }
    }

  }
}