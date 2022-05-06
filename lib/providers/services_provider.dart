import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class ServicesProvider extends ChangeNotifier {
 // QuerySnapshot _serviceSnapShot;
  List<String> wishlist=[];
  List<Service> serviceList=[];
  List<Service> serviceWishlist=[];
  String _docid;

  List<Service> newList=[];

  String get docid => _docid;

  Timestamp startTimeStamp,endTimeStamp;

  String _serviceProviderName;
  String get serviceProviderName => _serviceProviderName;


 Future<bool> getServiceProviderDetails(String docid) async {
   _serviceProviderName = '';
   DocumentSnapshot spSnapShot =
   await FirebaseFirestore.instance
       .collection('service_providers')
       .doc(docid)
       .get();
   _serviceProviderName = spSnapShot.get('service_provider_name');
   notifyListeners();
 }

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
        imageUrl: List.from(snap.get("imageUrl")),
        price:snap.get('price'),
        likeCount:snap.get('likecount'),
          description:snap.get('description'),
          serv_prov_id:snap.get('serv_prov_id'),
        //serv_prov_name:
      );

    }).toList();
    notifyListeners();
  }

  Future<void> getserviceSnapShotForWishlist() async {
    QuerySnapshot _serviceSnapShot = await FirebaseFirestore.instance.collection('services').get();
    serviceWishlist=_serviceSnapShot.docs.map((snap) {
      if(wishlist.contains(snap.get('docid'))) {
        return Service(
          isLiked: wishlist.contains(snap.get('docid')) ? true : false,
          docid: snap.get('docid'),
          name: snap.get('name'),
          //imageUrl: snap.get('imageUrl'),
          imageUrl: List.from(snap.get("imageUrl")),
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
      String price_per_unit,String description ,List<String> imageurl) async {
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
      //'no_of_service':no_of_service,
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

  Future<void> getserviceListing(String uid) async {
    //List<Product> newList = [];
    QuerySnapshot _serviceSnapShot = await FirebaseFirestore
        .instance.collection('services')
        .where('serv_prov_id', isEqualTo: uid)
        .get();
    serviceList=_serviceSnapShot.docs.map((snap) {
      // final user = snap.data();
      return Service(
          isLiked:wishlist.contains(snap.get('docid'))?true:false,
          docid:snap.get('docid'),
          name: snap.get('name'),
          //imageUrl: snap.get('imageUrl'),
          imageUrl: List.from(snap.get("imageUrl")),
          price:snap.get('price'),
          likeCount:snap.get('likecount'),
          description:snap.get('description'),
          serv_prov_id:snap.get('serv_prov_id')
      );

    }).toList();
    notifyListeners();
  }

  Future<void> getserviceSnapShot1() async {
    newList = [];
    Service obj;
    QuerySnapshot _serviceSnapShot = await FirebaseFirestore.instance.collection('services').get();

    _serviceSnapShot.docs.forEach((snap) async {
      _serviceProviderName='';
      //DocumentSnapshot spSnapShot =
      await FirebaseFirestore.instance
          .collection('service_providers')
          .doc(snap.get('serv_prov_id'))
          .get().
      then((value) {

        obj= Service(
          isLiked:wishlist.contains(snap.get('docid'))?true:false,
          docid:snap.get('docid'),
          name: snap.get('name'),
          //imageUrl: snap.get('imageUrl'),
          imageUrl: List.from(snap.get("imageUrl")),
          price:snap.get('price'),
          likeCount:snap.get('likecount'),
          description:snap.get('description'),
          serv_prov_id:snap.get('serv_prov_id'),
          serv_prov_name:value.get('service_provider_name'),
        );
        //return null;
      });
      //_serviceProviderName = spSnapShot.get('service_provider_name');
     

      newList.add(obj);
    });
    serviceList=newList;
    notifyListeners();
  }
}