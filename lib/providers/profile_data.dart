import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/profile.dart';

class ProfileData extends ChangeNotifier{
  //List<bool> _setProfile=[false, false, false];

  //List<bool> _tempSetProfile=[false, false, false];

  //List<bool> get getProfile => _setProfile;

  int _count=0;

  //List<bool> get getTempProfile => _tempSetProfile;

  List<Profile> _profiles = [
    Profile("Farmer", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbCtIuT92c5b4YgL4lqKnww5Gn12arzdaARA&usqp=CAU", false),
    Profile("Service Provider", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMyf6QUQof7CNOUniNSeEU-EE0a8DgQZAaQ&usqp=CAU", false),
    Profile("Labour", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr_oUHRKOiReFYPu9v4ZWyARmtRv4oaEgkbw&usqp=CAU", false),
  ];

  List<Profile> _selectedProfiles = [];

  List<Profile> get profiles => _profiles;

  List<Profile> get selectedProfiles => _selectedProfiles;

  int get count => _count;

  void incCount(){
    _count++;
    notifyListeners();
  }

  void decCount(){
    _count--;
    notifyListeners();
  }

  void assignSelectProfile() {
    _selectedProfiles = _profiles;
    notifyListeners();
  }

    void assignProfile(){
      _profiles=_selectedProfiles;
      notifyListeners();
    }

  Future<void> getFirebaseProfile() async {
    List<String> newList = [];
    DocumentSnapshot featureSnapShot =
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('userId')
        .get();

    //Map<String, dynamic> data = featureSnapShot.data.data() as Map<String, dynamic>;
        _profiles[0].isSelected=featureSnapShot.get("farmer");


    notifyListeners();
  }

  Future<void> getHomeFeatureData() async {
    //List<Product> newList = [];
    QuerySnapshot featureSnapShot =
    await FirebaseFirestore.instance.collection("homefeature").where('uid', isEqualTo: '111').get();
    featureSnapShot.docs.forEach(
          (element) {
            _profiles[0].isSelected=element.get("image");

      },
    );
    notifyListeners();
  }

  /*void setProfile(int index){
    _setProfile[index] =!_setProfile[index];
    notifyListeners();
  }*/

  /*void setTempProfile(int index){
    _tempSetProfile[index] =!_tempSetProfile[index];
    notifyListeners();
  }*/

  /*void assignToTempProfile(){
    _tempSetProfile=_setProfile;
    notifyListeners();
  }*/

  /*void assignToProfile(){
    _setProfile=_tempSetProfile;
    notifyListeners();
  }*/

}