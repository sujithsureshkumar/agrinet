import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:AgriNet/screens/authenticate/authenticate.dart';
import 'package:AgriNet/screens/pages/profile_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/pages/serviceProviderHome.dart';
import '../widget/loading.dart';

class WrapperNxt extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context,listen:false);
    //return Home();
    print(user);

    User currentUser = FirebaseAuth.instance.currentUser;
    ProfileData profile = Provider.of<ProfileData>(context,listen:false);

    if (user == null) {
      return Authenticate();
    } else {
      profile.checkIfDocExists(user.uid);
      print(profile.loading2);
      if (!profile.loading2) {
        if (!profile.userExist) {
          return ProfileSelection();
          //setUserProfile(user.uid,false,false,false,true);
        }
        else {
          profile.fetchFirebaseProfile(user.uid);
          if (!profile.loading) {
            return Home();
          }
          else {
            return Loading();
          }
        }
      } else {
        print(profile.loading2);
        return Loading();
      }
    }
  }
}
