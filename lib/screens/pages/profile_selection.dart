import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:flutter/material.dart';

import '../../models/profile.dart';
import 'package:provider/provider.dart';

class ProfileSelection extends StatefulWidget {
  @override
  _ProfileSelectionState createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection > {

  List<Profile> profiles = [
    Profile("Farmer", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbCtIuT92c5b4YgL4lqKnww5Gn12arzdaARA&usqp=CAU", false),
    Profile("Service Provider", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMyf6QUQof7CNOUniNSeEU-EE0a8DgQZAaQ&usqp=CAU", false),
    Profile("Labour", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr_oUHRKOiReFYPu9v4ZWyARmtRv4oaEgkbw&usqp=CAU", false),
  ];

  List<Profile> selectedProfiles = [];

  @override
  Widget build(BuildContext context) {
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
                    itemCount: profiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return item
                      return ProfileItem(
                        profiles[index].name,
                        profiles[index].image,
                        profiles[index].isSelected,
                        index,
                      );
                    }),
              ),
              selectedProfiles.length > 0 ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green[700],
                    child: Text(
                      "Proceed (${selectedProfiles.length})",
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
              ): Container(),
            ],
          ),
        ),
      ),
    );
  }


  Widget ProfileItem(String name, String image, bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        child: GestureDetector(
          onTap: () {
            setState(() {
              profiles[index].isSelected = !profiles[index].isSelected;
              Provider.of<ProfileData>(context, listen: false).setProfile(index);
              if (profiles[index].isSelected == true) {
                selectedProfiles.add(Profile(name, image, true));
              } else if (profiles[index].isSelected == false) {
                selectedProfiles
                    .removeWhere((element) => element.name == profiles[index].name);
              }
            });
          },

          child: Padding(
            padding: const EdgeInsets.all(8.0),


            child: Stack(
              children: <Widget>[
                Expanded(
                  child: Container(
                      //width: 150.0,
                      //height: 150.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(image)
                          )
                      )),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(name,
                          style: TextStyle (
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: isSelected
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

  /* Widget ProfileItem(
      String name, String image, bool isSelected, int index) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isSelected
          ? Icon(
        Icons.check_circle,
        color: Colors.green[700],
      )
          : Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      ),
      onTap: () {
        setState(() {
          profiles[index].isSelected = !profiles[index].isSelected;
          if (profiles[index].isSelected == true) {
            selectedProfiles.add(Profile(name, image, true));
          } else if (profiles[index].isSelected == false) {
            selectedProfiles
                .removeWhere((element) => element.name == profiles[index].name);
          }
        });
      },
    );
  }*/
}