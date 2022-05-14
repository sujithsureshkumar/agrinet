import 'package:AgriNet/models/farm.dart';
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
    _docid = Uuid().v1();
    //_docid =name;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference serviceProvidersCollectionReference = await firebaseFirestore.collection('farmUser');
    //return
      serviceProvidersCollectionReference.doc(uid)
        .collection("farms")
        .doc(_docid)
        .set({
        'docid': _docid,
      'name':name,
      'category': category,
      'subcategory': subCategory,
      'landarea':landarea,
      'location':GeoPoint(0,0),
        'createdOn':FieldValue.serverTimestamp(),
      'imageUrl':["https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/Required%20files%2Fnoimage.png?alt=media&token=47ee7a64-0059-4527-a72f-3b983957d887"],
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

  List<dynamic> tempList;
  Future<void> fetchUserFarm(String uid) async {
    _groupList=[];
    DocumentSnapshot userFarmSnapShot =
    await FirebaseFirestore.instance
        .collection('farmUser')
        .doc(uid)
        .collection('allfarms')
        .doc('allFarm')
        .get();

    tempList = (userFarmSnapShot.data()as Map<String, dynamic>)['allFarm'];

    tempList.forEach((result){
      _groupList.add(result);
    });
    /*userFarmSnapShot.docs.forEach((result) {
      _groupList.add(result.get('name'));
    });*/

    notifyListeners();
  }

  List<Farm> farmList=[];
  Future<void> getFarmSnapShot(String uid) async {
    //List<Product> newList = [];
    QuerySnapshot _farmSnapShot = await FirebaseFirestore.instance.collection('farmUser')
        .doc(uid)
        .collection('farms')
        .get();
    farmList=_farmSnapShot.docs.map((snap) {
      // final user = snap.data();
      return Farm(
          docid:snap.get('docid'),
          name: snap.get('name'),
          category:snap.get('category'),
          subCategory:snap.get('subcategory'),
          landarea: snap.get('landarea'),
          location:snap.get('location'),
          imageUrl: List.from(snap.get("imageUrl")),
          createdOn: snap.get('createdOn').toDate(),
        //serv_prov_name:
      );

    }).toList();
    notifyListeners();
  }

  List _groupInfoList = [];
  List<String> _groupNameList=[];
  List<String> get groupNameList => _groupNameList;
  List<String> get groupInfoList => _groupInfoList;
  Future<void> fetchUserFarmWithInfo(String uid) async {
    _groupInfoList=[];
    _groupNameList=[];
    await FirebaseFirestore.instance
        .collection('farmUser')
        .doc(uid)
        .collection('farms')
        .get().then((value) {
      _groupInfoList = value.docs;
    });
    _groupInfoList.forEach((result) {
      _groupNameList.add(result['name']);
    });

    notifyListeners();
  }

  Future<String> selectedUserFarmDocid(String name) async {
    String docid;
    _groupInfoList.forEach((element) {
      if (element['name'] == name) {
        docid = element['docid'];
      }
    });
    return docid;
  }

  Future<String> updateFarmGroup(String docid,String uid,List membersList,String farmName,String farmid) async {

    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['uid'] == uid) {
        membersList[i]['myFarm']=farmName;
        membersList[i]['myFarmId']=farmid;
        membersList[i]['isFarmSet']=true;
      }
    }

    await FirebaseFirestore.instance
        .collection('groups')
        .doc(docid)
        .update({
      "members": membersList,
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('groups')
        .doc(docid)
        .update({

      'myFarm':farmName,
      'myFarmId':farmid,
      'isFarmSet':true,

    });
  }

}
