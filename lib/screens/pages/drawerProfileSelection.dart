import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:flutter/material.dart';

import '../../models/profile.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';

class DrawerprofileSelection extends StatefulWidget {
  @override
  _DrawerprofileSelectionState createState() => _DrawerprofileSelectionState();
}

class _DrawerprofileSelectionState extends State<DrawerprofileSelection> {

  Widget ProfileItem(Profile data) {
    final user = Provider.of<Users>(context);
    return ListTile(
      title: Text(
        data.name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: data.isSelected
          ? Icon(
        Icons.check_circle,
        color: Colors.green[700],
      )
          : Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      ),
      onTap: () {
        ProfileData profileProvider =Provider.of<ProfileData>(context, listen: false);

        setState(() {
          profileProvider.getProfileSetCount();
          if (profileProvider.profileSetCount<2){
            data.isSelected = true;
            profileProvider.updateFirebaseProfile(user.uid,
                profileProvider.profiles[0].isSelected,
                profileProvider.profiles[1].isSelected,
                profileProvider.profiles[2].isSelected
            );
          }else{
            data.isSelected = !data.isSelected;
            profileProvider.updateFirebaseProfile(user.uid,
                profileProvider.profiles[0].isSelected,
                profileProvider.profiles[1].isSelected,
                profileProvider.profiles[2].isSelected
            );
          }

        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    ProfileData profileProvider =Provider.of<ProfileData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Selection"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: profileProvider.profiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return item
                      return ProfileItem(
                          profileProvider.profiles[index]
                      );
                    }),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green[700],
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      //print("Delete List Lenght: ${selectedProfiles.length}");
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => Home()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}