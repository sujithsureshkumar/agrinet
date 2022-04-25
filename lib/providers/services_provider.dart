import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class ServicesProvider extends ChangeNotifier {
 // QuerySnapshot _serviceSnapShot;
  List<String> wishlist=[];
  List<Service> serviceList=[];
  String _docid;

  String get docid => _docid;

  Future<void> fetchFirebaseWishlist(String uid) async {
    DocumentSnapshot farmUserSnapShot =
    await FirebaseFirestore.instance
        .collection('farmUser')
        .doc(uid)
        .get();
    wishlist= List.from(farmUserSnapShot.get("wishlist"));
  }

  Future<void> getserviceSnapShot() async {
    //List<Product> newList = [];
    QuerySnapshot _serviceSnapShot = await FirebaseFirestore.instance.collection('services').get();
    serviceList=_serviceSnapShot.docs.map((snap) {
      // final user = snap.data();
      return Service(
        isLiked:wishlist.contains(snap.get('docid'))?true:false,
        docid:snap.get('docid'),
        name: snap.get('name'),
        //imageUrl: snap.get('imageUrl'),
        imageUrl: List.from(snap.get("imageUrl"))[0],
        price:snap.get('price'),
        likeCount:snap.get('likecount'),
      );

    }).toList();
    notifyListeners();
  }

  Future<void> getserviceSnapShotForWishlist() async {
    QuerySnapshot _serviceSnapShot = await FirebaseFirestore.instance.collection('services').get();
    serviceList=_serviceSnapShot.docs.map((snap) {
      if(wishlist.contains(snap.get('docid'))) {
        return Service(
          isLiked: wishlist.contains(snap.get('docid')) ? true : false,
          docid: snap.get('docid'),
          name: snap.get('name'),
          //imageUrl: snap.get('imageUrl'),
          imageUrl: List.from(snap.get("image"))[0],
          price: snap.get('price'),
          likeCount: snap.get('likecount'),
        );
      }

    }).toList();
    notifyListeners();
  }

    /*List<Service> get serviceList => _serviceSnapShot.docs.map((snap) {
      // final user = snap.data();
      return Service(
        isLiked:wishlist.contains(snap.get('docid'))?true:false,
        docid:snap.get('docid'),
        name: snap.get('name'),
        imageUrl: snap.get('imageUrl'),
        price:snap.get('price'),
        likeCount:snap.get('likecount'),
      );

    }).toList();*/

  Future sp_addservice(String uid,String service_name,String category,
      String price_per_unit,String no_of_service,String description ,List<String> imageurl) async {
    _docid = Uuid().v1();
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('services');
    return serviceProvidersCollectionReference.doc(_docid)
        .set({
      'docid':_docid,
      'serv_prov_id': uid,
      'name': service_name,
      'category': category,
      'price':price_per_unit,
      'no_of_service':no_of_service,
      'description':description,
      'imageUrl':imageurl,
      'likecount':0,
      'isLiked':false,


    })
        .then((value) {
          print("Service Added");
        })
        .catchError((error) => print("Failed to add Service: $error"));
  }

}