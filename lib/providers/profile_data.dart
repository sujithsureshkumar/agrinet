import 'package:AgriNet/models/labor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/profile.dart';

class ProfileData extends ChangeNotifier{
  //List<bool> _setProfile=[false, false, false];

  //List<bool> _tempSetProfile=[false, false, false];

  //List<bool> get getProfile => _setProfile;
  int _count=0;
  int _x=0;
  int _profileSetCount=0;
  bool _profileStatus = false;
  bool _userExist;
  bool _loading=true;
  bool _loading2=true;

  //List<bool> get getTempProfile => _tempSetProfile;

  List<Profile> _profiles = [
    Profile("Farmer", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbCtIuT92c5b4YgL4lqKnww5Gn12arzdaARA&usqp=CAU", true),
    Profile("Service Provider", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMyf6QUQof7CNOUniNSeEU-EE0a8DgQZAaQ&usqp=CAU", true),
    Profile("Labour", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr_oUHRKOiReFYPu9v4ZWyARmtRv4oaEgkbw&usqp=CAU", true),
  ];

  List<Profile> _profileSelect = [
    Profile("Farmer", "https://png.pngtree.com/thumb_back/fw800/back_our/20190623/ourmid/pngtree-summer-summer-green-background-banner-image_252424.jpg", false),
    Profile("Service Provider", "https://i.pinimg.com/originals/d1/eb/9b/d1eb9b366cfb90bb317ec56c6f1b2d3d.jpg", false),
    Profile("Labour", "https://png.pngtree.com/thumb_back/fh260/background/20190220/ourmid/pngtree-ocean-blue-summer-banner-image_8350.jpg", false),
  ];

  List<Profile> _selectedProfiles = [];

  List<Profile> get profiles => _profiles;
  List<Profile> get profileSelect => _profileSelect;

  List<Profile> get selectedProfiles => _selectedProfiles;

  bool get profileStatus => _profileStatus;
  bool get loading => _loading;
  bool get loading2 => _loading2;

  int get count => _count;
  int get x => _x;

  int get profileSetCount => _profileSetCount;
  bool get userExist => _userExist;

   getProfileSetCount() {
    _profileSetCount=0;
    for (var i = 0; i < 3; i++) {
      if (_profiles[i].isSelected) {
        _profileSetCount++;
      }
    }
    //notifyListeners();
  }


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

  Future<void> fetchFirebaseProfile(String uid) async {
    //print("1.1");
   // _loading=true;
    DocumentSnapshot featureSnapShot =
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();
    // print("1.2");
    _profiles[0].isSelected=featureSnapShot.get("farmer");
    _profiles[1].isSelected=featureSnapShot.get("serviceProvider");
    _profiles[2].isSelected=featureSnapShot.get("labour");
    // _loading=false;
    //notifyListeners();
   }

 
  Future<void> updateFirebaseProfile(String uid,bool farmer, bool service , bool labour) async {
    FirebaseFirestore.instance.collection('Users')
        .doc(uid)
        .update({
      'farmer': farmer,
      'serviceProvider' :service,
      'labour' : labour
    });
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


  Future<bool> spFormFillCheck(String uid) async {
    DocumentSnapshot featureSnapShot =
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();
   _profileStatus = featureSnapShot.get("spFormFill");
    notifyListeners();
  }

  bool _farmerProfileStatus = false;
  bool get farmerProfileStatus => _farmerProfileStatus;
  Future<bool> FarmerFormFillCheck(String uid) async {
    DocumentSnapshot featureSnapShot =
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();
    _farmerProfileStatus = featureSnapShot.get("farmerFormFill");
    notifyListeners();
  }

  Future<bool> checkIfDocExists(String docId) async {
    print("2.1");
    _loading2=true;
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('Users');

      var doc = await collectionRef.doc(docId).get();
      //return doc.exists;
      _userExist=doc.exists;
      print("2.2");
      _loading2=false;
      print("2.3");
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  setloadingtrue(){
    _loading=true;
   _loading2=true;
   notifyListeners();
  }


  Labor _labor;
  Labor get laborDetails => _labor;
  bool isloading =false;
  Future<bool> getLaborDetails(String docid) async {
    isloading = true;
    DocumentSnapshot laborSnapShot =
    await FirebaseFirestore.instance
        .collection('labor')
        .doc(docid)
        .get();
    //_serviceProviderName = spSnapShot.get('service_provider_name');
    _labor=Labor(
      docid:laborSnapShot.get('docid'),
      name: laborSnapShot.get('name'),
      phone_number:laborSnapShot.get('phone_number'),
      skill:laborSnapShot.get('skill'),
      locality: laborSnapShot.get('locality'),
      district:laborSnapShot.get('district'),
      state: laborSnapShot.get('state'),
      pincode:laborSnapShot.get('pincode'),
      account_holder_name:laborSnapShot.get('account_holder_name'),
      account_number: laborSnapShot.get('account_number'),
      ifs_code:laborSnapShot.get('ifs_code'),
      bank_name:laborSnapShot.get('bank_name'),
      imageUrl: laborSnapShot.get('imagerUrl'),
      createdOn: laborSnapShot.get('createdOn').toDate(),
      //serv_prov_name:
    );

    isloading =false;
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