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


  Widget ProfileItem(String name, String image, bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        child: GestureDetector(
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
                              image: NetworkImage('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80')
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