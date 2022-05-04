import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FarmProvider extends ChangeNotifier {
  String _docid;
  String get docid => _docid;
  Future farmer_addfarm(String uid,String name,String category,String subCategory,
      String landarea,String location) async {
    _docid = Uuid().v1();
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('farmUser');
    return serviceProvidersCollectionReference.doc(uid)
        .collection("farms")
        .doc(_docid)
        .set({
      'name':name,
      'category': category,
      'subcategory': subCategory,
      'category': category,
      'landarea':landarea,
      'location':location,
      'imageUrl':[],
    })
        .then((value) {
      print("new Farm Added");
    })
        .catchError((error) => print("Failed to add Farm: $error"));
  }
}