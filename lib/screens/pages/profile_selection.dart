import 'package:flutter/material.dart';

import '../../models/profile.dart';

class ProfileSelection extends StatefulWidget {
  @override
  _ProfileSelectionState createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection > {

  List<Profile> profiles = [
    Profile("Farmer", "0778979454", false),
    Profile("Service Provider", "0766223795", false),
    Profile("Labour", "0749112016", false),
  ];

  List<Profile> selectedProfiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Selection ListView"),
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
                      print("Delete List Lenght: ${selectedProfiles.length}");
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

  Widget ProfileItem(
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
  }
}