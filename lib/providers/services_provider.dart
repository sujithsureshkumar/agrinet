import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';


class ServicesProvider extends ChangeNotifier {
 // QuerySnapshot _serviceSnapShot;
  List<String> wishlist=[];
  List<Service> serviceList=[];

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
    QuerySnapshot _serviceSnapShot = await FirebaseFirestore.instance.collection('users').get();
    serviceList=_serviceSnapShot.docs.map((snap) {
      // final user = snap.data();
      return Service(
        isLiked:wishlist.contains(snap.get('docid'))?true:false,
        docid:snap.get('docid'),
        name: snap.get('name'),
        imageUrl: snap.get('imageUrl'),
        price:snap.get('price'),
        likeCount:snap.get('likecount'),
      );

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

}