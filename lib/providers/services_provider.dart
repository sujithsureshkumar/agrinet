import 'package:AgriNet/models/booking.dart';
import 'package:AgriNet/models/serviceProvModel.dart';
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
  ServiceProvModel _serviceProvModel;
  ServiceProvModel get serviceProvModel => _serviceProvModel;
  List<Service> newList=[];

  String get docid => _docid;

  Timestamp startTimeStamp,endTimeStamp;

  String _serviceProviderName;
  String get serviceProviderName => _serviceProviderName;



 Future<bool> getServiceProviderDetails(String docid) async {
   DocumentSnapshot spSnapShot =
   await FirebaseFirestore.instance
       .collection('service_providers')
       .doc(docid)
       .get();
   //_serviceProviderName = spSnapShot.get('service_provider_name');
   _serviceProvModel=ServiceProvModel(
       name: spSnapShot.get('name'),
      phone_number: spSnapShot.get('phone_number'),
      account_holder_name: spSnapShot.get('account_holder_name'),
      ifs_code: spSnapShot.get('ifs_code'),
      account_number: spSnapShot.get('account_number'),
   );
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
          spName:snap.get('spName'),
          phone_number:snap.get('phone_number'),
          account_holder_name:snap.get('account_holder_name'),
          ifs_code:snap.get('ifs_code'),
          account_number:snap.get('account_number'),
          reviewList: List.from(snap.get("reviewList"))
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
      String price_per_unit,String description ,List<String> imageurl,String equipments ,ServiceProvModel spData) async {
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
      'equipments':equipments,
      'likecount':0,
      'isLiked':false,
      'spName':spData.name,
      'phone_number':spData.phone_number,
      'account_holder_name':spData.account_holder_name,
      'ifs_code':spData.ifs_code,
      'account_number':spData.account_number,
      'reviewList':[],


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

  /*Future<void> getserviceSnapShot1() async {
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
  }*/

  bool _reviewExist=false;
  bool get reviewExist => _reviewExist;
  Future<bool> checkIfReviewExists(String docId) async {
    _reviewExist=false;
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('services');

      var doc = await collectionRef.doc(docId).get();
      //return doc.exists;
      _reviewExist=doc.exists;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  List<Booking> bookingList;
  Future<void> getBookingSnapShot(String firestoreField,String uid) async {
    bookingList = [];
    QuerySnapshot _bookingSnapShot = await FirebaseFirestore.instance
        .collection('Bookings')
        .where(firestoreField, isEqualTo: uid)
        .get();
    bookingList=_bookingSnapShot.docs.map((snap) {
      // final user = snap.data();
      return Booking(
          docid: snap.get('docid'),
          farmType: snap.get('farmType'),
          farmName:snap.get('farmName'),
          uid: snap.get('uid'),
          price: snap.get('price'),
      //phone_number= json['spid'];
         spid:snap.get('spid'),
         spName: snap.get('spName'),
         serviceName: snap.get('serviceName'),
        Startdate:snap.get('startTime').toDate(),
        Enddate:snap.get('endTime').toDate(),
        createdOn: snap.get('createdOn').toDate(),
        status:snap.get('status'),
        statusOn:snap.get('statusOn').toDate(),
      );

    }).toList();
    notifyListeners();
  }

}