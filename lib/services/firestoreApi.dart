import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:AgriNet/screens/home/sp_addservice.dart';

class FirestoreApi extends ChangeNotifier{
  List<dynamic> subCategoryList=[];
  String paddy="hello";

  Future<void> fetchFirebaseCategory() async {
    DocumentSnapshot categorySnapShot =
    await FirebaseFirestore.instance
        .collection('category')
        .doc('foodGrain')
        .get();
    subCategoryList = (categorySnapShot.data()as Map<String, dynamic>)['subcategory']['paddy'];
  }
}