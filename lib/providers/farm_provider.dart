import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FarmProvider extends ChangeNotifier {
  String _docid;
  String get docid => _docid;

  List<String> _groupList=[];
  List<String> get groupList => _groupList;

  Future farmer_addfarm(String uid,String name,String category,String subCategory,
      String landarea) async {
    //_docid = Uuid().v1();
    _docid =name;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference serviceProvidersCollectionReference = await firebaseFirestore.collection('farmUser');
    //return
      serviceProvidersCollectionReference.doc(uid)
        .collection("farms")
        .doc(_docid)
        .set({
      'name':name,
      'category': category,
      'subcategory': subCategory,
      'category': category,
      'landarea':landarea,
      'location':GeoPoint(0,0),
      'imageUrl':[],
    })
        .then((value) {
      print("new Farm Added");
    })
        .catchError((error) => print("Failed to add Farm: $error"));

   serviceProvidersCollectionReference.doc(uid)
        .collection("allfarms")
        .doc("allFarm")
        .update({
      'allFarm': FieldValue.arrayUnion([_docid])
    });


  }



  Future<void> fetchUserGroup(String uid) async {
    _groupList=[];
    QuerySnapshot groupSnapShot =
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get();

    groupSnapShot.docs.forEach((result) {
      _groupList.add(result.get('name'));
    });
    /*_groupList=groupSnapShot.docs.map((snap) {
      return snap.get('name');
    }).toList();*/

    notifyListeners();
  }

  Future<void> fetchUserFarm(String uid) async {
    _groupList=[];
    QuerySnapshot userFarmSnapShot =
    await FirebaseFirestore.instance
        .collection('farmUser')
        .doc(uid)
        .collection('farms')
        .get();

    userFarmSnapShot.docs.forEach((result) {
      _groupList.add(result.get('name'));
    });

    notifyListeners();
  }
}
