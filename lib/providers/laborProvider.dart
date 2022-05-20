import 'package:AgriNet/models/labor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class LaborProvider extends ChangeNotifier {
  List<Labor> laborList=[];
  Future<void> getLaborSnapShot(String uid) async {
    //List<Product> newList = [];
    QuerySnapshot _laborSnapShot = await FirebaseFirestore.instance.collection('labor')
        .doc(uid)
        .collection('farms')
        .get();
    laborList=_laborSnapShot.docs.map((snap) {
      return Labor(
        docid:snap.get('docid'),
        name: snap.get('name'),
        phone_number:snap.get('phone_number'),
        skill:snap.get('skill'),
        locality: snap.get('locality'),
        district:snap.get('district'),
        state: snap.get('state'),
        pincode:snap.get('pincode'),
        account_holder_name:snap.get('account_holder_name'),
        account_number: snap.get('account_number'),
        ifs_code:snap.get('ifs_code'),
        bank_name:snap.get('bank_name'),
        imageUrl: snap.get('imagerUrl'),
        createdOn: snap.get('createdOn').toDate(),
        //serv_prov_name:
      );

    }).toList();
    notifyListeners();
  }
}