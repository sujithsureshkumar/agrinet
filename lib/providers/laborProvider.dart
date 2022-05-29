import 'package:AgriNet/models/labor.dart';
import 'package:AgriNet/models/laborHiring.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class LaborProvider extends ChangeNotifier {
  bool loading=false;
  List<Labor> laborList=[];
  Future<void> getLaborSnapShot() async {
    //List<Product> newList = [];
    QuerySnapshot _laborSnapShot = await FirebaseFirestore.instance.collection('labor')
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

  bool _profileStatus = false;
  bool get profileStatus => _profileStatus;
  Future<bool> spFormFillCheck(String uid) async {
    DocumentSnapshot featureSnapShot =
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();
    _profileStatus = featureSnapShot.get('laborFormFill');
    notifyListeners();
  }

  List<LaborHiring> LaborHiringList;
  Future<void> getLaborHiringSnapShot(String firestoreField,String uid) async {
    LaborHiringList = [];
    QuerySnapshot _laborHiringSnapShot = await FirebaseFirestore.instance
        .collection('laborHiring')
        .where(firestoreField, isEqualTo: uid)
        .get();
    LaborHiringList=_laborHiringSnapShot.docs.map((snap) {
      // final user = snap.data();
      return LaborHiring(
        docid: snap.get('docid'),
        hiringId:snap.get('hiringId'),
        hiringType: snap.get('hiringType'),
        hirerName:snap.get('hirerName'),
        hirerLocality: snap.get('hirerLocality'),
        hirerdistrict: snap.get('hirerdistrict'),
        //phone_number= json['spid'];
        hirerState: snap.get('hirerState'),
        hirerPincode: snap.get('hirerPincode'),
        hirerPhone_number:snap.get('hirerPhone_number'),
        uid: snap.get('uid'),
        laborPhone_number: snap.get('laborPhone_number'),
        laborid: snap.get('laborid'),
        laborName:snap.get('laborName'),
        laborSkill: snap.get('laborSkill'),
        laborlocality: snap.get('laborlocality'),
        labordistrict: snap.get('labordistrict'),
        laborstate: snap.get('laborstate'),
        laborpincode: snap.get('laborpincode'),
        Startdate:snap.get('startTime').toDate(),
        Enddate:snap.get('endTime').toDate(),
        createdOn: snap.get('createdOn').toDate(),
        status:snap.get('status'),
        statusOn:snap.get('statusOn').toDate(),

        contractLabor:snap.get('contractLabor'),
        isLaborPaymentDone:snap.get('isLaborPaymentDone'),
        laborPaymentDate:snap.get('laborPaymentDate').toDate(),
        labor_payment_id:snap.get('labor_payment_id'),
        labor_order_id:snap.get('labor_order_id'),
        labor_signature:snap.get('labor_signature'),
        contractOtherParty:snap.get('contractOtherParty'),
        otherPartyPaymentDate:snap.get('otherPartyPaymentDate').toDate(),
        isOtherPartyPaymentDone:snap.get('isOtherPartyPaymentDone'),
        otherParty_payment_id:snap.get('otherParty_payment_id'),
        otherParty_order_id:snap.get('otherParty_order_id'),
        otherParty_signature:snap.get('otherParty_signature'),
      );

    }).toList();
    notifyListeners();
  }


}