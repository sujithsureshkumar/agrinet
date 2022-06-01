import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';

import '../../models/profile.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../services/firebase_api_methods.dart';

class ProfileSelection extends StatefulWidget {
  @override
  _ProfileSelectionState createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection > {

 /* List<Profile> profiles = [
    Profile("Farmer", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbCtIuT92c5b4YgL4lqKnww5Gn12arzdaARA&usqp=CAU", false),
    Profile("Service Provider", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMyf6QUQof7CNOUniNSeEU-EE0a8DgQZAaQ&usqp=CAU", false),
    Profile("Labour", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr_oUHRKOiReFYPu9v4ZWyARmtRv4oaEgkbw&usqp=CAU", false),
  ]; */


  //List<Profile> selectedProfiles = [];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    ProfileData profileProvider =Provider.of<ProfileData>(context, listen: false);
    return Scaffold(
      appBar:  DefaultAppBar(title: "Profile Selection"),
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
                        profileProvider.profileSelect[index]
                      );
                    }),
              ),
              profileProvider.count > 0 ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.cyan,
                    child: Text(
                        "Proceed (${profileProvider.count})",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    onPressed: () {
                      //print("Delete List Lenght: ${selectedProfiles.length}");
                      //profileProvider.assignSelectProfile();
                     /* profileProvider.updateFirebaseProfile(user.uid,
                          profileProvider.profileSelect[0].isSelected,
                          profileProvider.profileSelect[1].isSelected,
                          profileProvider.profileSelect[2].isSelected
                      );*/
                      //profileProvider.getProfileSetCount();
                      //return Wrapper() ;
                      setUserProfile(user.uid,
                          profileProvider.profileSelect[0].isSelected,
                          profileProvider.profileSelect[1].isSelected,
                          profileProvider.profileSelect[2].isSelected,
                          true
                      ).then((value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => Home())));

                      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Wrapper()));
                    },
                  ),
                ),
              ): Container(),
            ],
          ),
        ),
      ),
    );
  }


  Widget ProfileItem(Profile data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        child: GestureDetector(
          onTap: () {
            setState(() {
              ProfileData profileProvider =Provider.of<ProfileData>(context, listen: false);
              data.isSelected = !data.isSelected;
              if (data.isSelected) {
                profileProvider.incCount();
              } else {
                profileProvider.decCount();
              }
            });
          },

          child: Padding(
            padding: const EdgeInsets.all(8.0),


            child: Stack(
              children: <Widget>[
                Container(
                    //width: 150.0,
                    //height: 150.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data.image)
                        )
                    )),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data.name,
                          style: TextStyle (
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: data.isSelected
                                ? Icon(
                              Icons.check_circle,
                              color: Colors.green[700],
                            )
                                : Icon(
                              Icons.check_circle_outline,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}