

import 'package:AgriNet/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/users.dart';


//final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('service_providers');
Future sp_onboarding(String uid,String name,
    String location,String phone_number,String account_holder_name,
    String account_number,String ifs_code,String bank_name,String pincode ) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('service_providers');
  return serviceProvidersCollectionReference
      .doc(uid)
      .set({
    'name': name,
    'location': location,
    'phone_number':phone_number,
    'account_holder_name':account_holder_name,
    'account_number':account_number,
    'ifs_code':ifs_code,
    'bank_name':bank_name,
    'pincode': pincode,

  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
Future<void> updateFirebaseProfileFillStatus(String uid, bool formStatus) async {
  FirebaseFirestore.instance.collection('Users')
      .doc(uid)
      .update({
    'spFormFill': formStatus,
  });
}
Future setUserProfile(String uid,bool farmer,bool serviceProvider,bool labour,bool spFormFill) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('Users');
  serviceProvidersCollectionReference
      .doc(uid)
      .set({
    'farmer': farmer, // John Doe
    'labour': serviceProvider, // Stokes and Sons
    'serviceProvider': labour,
    'spFormFill': spFormFill,

  });
}






Future sp_addservice(String uid,String service_name,String category,
    String price_per_unit,String description ,List<String> imageurl) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('services');
  return serviceProvidersCollectionReference
      .add({
    'serv_prov_id': uid,
    'service_name': service_name,
    'category': category,
    'price_per_unit':price_per_unit,
    //'no_of_service':no_of_service,
    'description':description,
    'imageUrl':imageurl,


  })
      .then((value) {
        print("Service Added");
        return value.id;
      })
      .catchError((error) => print("Failed to add Service: $error"));
}
Future updateImage(List<String> imageurlList, String docid) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(docid)
      .update({
    'imageUrl':imageurlList
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Image added"))
      .catchError((error) => print("Failed to add image: $error"));
}

/*Future add_to_service_booking(String uid,String service_id,String category,
    String price_per_unit,String no_of_service,String description ,List<String> imageurl) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('services');
  return serviceProvidersCollectionReference
      .add({
    'serv_prov_id': uid,
    'service_id': service_id,
    'category': category,
    'price_per_unit':price_per_unit,
    'no_of_service':no_of_service,
    'description':description,
    'imageUrl':imageurl,


  })
      .then((value) {
    print("Service Added");
    return value.id;
  })
      .catchError((error) => print("Failed to add Service: $error"));
}*/

Future UpdateImageFarmAdd(List<String> imageurlList,String uid, String docid,double latitude,double longitude) async {
  await FirebaseFirestore.instance.collection('farmUser')
      .doc(uid).collection("farms")
      .doc(docid)
      .update({
    'imageUrl':imageurlList,
    'location':GeoPoint(latitude,longitude),
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Image added"))
      .catchError((error) => print("Failed to add image: $error"));
}

Future sp_updateService(String docid,String service_name,String category,String subCategory,
    String price_per_unit,String equipments,String description ,List<String> imageurl) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(docid)
      .update({
    'name': service_name,
    'category': category,
    'subCategory': subCategory,
    'price':price_per_unit,
    'equipments':equipments,
    //'no_of_service':no_of_service,
    'description':description,
    'imageUrl':imageurl,
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Updated"))
      .catchError((error) => print("Failed to Updated: $error"));
}


Future addBooking(Service service, Users user,
    String farmType,String farmName,String serviceCategory,
    String serviceSubCategory,Timestamp startTime,Timestamp endTime) async {
  String _docid = Uuid().v1();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('Bookings');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .set({
    'docid':_docid,
    'farmType':farmType,
    'farmName':farmName,
    'price':service.price,
    'uid':user.uid,
    'spid':service.serv_prov_id,
    'spName':service.spName,
    'serviceName':service.name,
    'serviceCategory':serviceCategory,
    'serviceSubCategory':serviceSubCategory,
    'startTime': startTime,
    'endTime': endTime,
    'createdOn':FieldValue.serverTimestamp(),
    'status':'Pending',
    'statusOn':FieldValue.serverTimestamp(),


  })
      .then((value) {
    print("start&end time Added");
  })
      .catchError((error) => print("Failed to add start&end time: $error"));
}


Future addReview(String docid,String uid,String image,String name, String rating,String comment) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(docid).collection("Review")
      .doc(uid)
      .set({
    'image': image, // John Doe
    'name': name, // Stokes and Sons
    'rating': rating,
    'comment': comment,
    'createdOn':FieldValue.serverTimestamp(),
    'docid':uid
  });

  await FirebaseFirestore.instance.collection('services')
      .doc(docid)
      .update({
    'reviewList': FieldValue.arrayUnion([uid]), // John Doe

  });
}

Future updateBooking(String docid,String status) async {
  await FirebaseFirestore.instance.collection('Bookings')
      .doc(docid)
      .update({
    'status': status,
    'statusOn':FieldValue.serverTimestamp(),
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Updated Booking"))
      .catchError((error) => print("Failed to Update Booking: $error"));
}

Future getFarmDetails(String farmType,String uid,String name) async {
  if(farmType=='Individual') {
    return await FirebaseFirestore.instance
        .collection('farmUser')
        .doc(uid)
        .collection("farms")
        .where("name", isEqualTo: name)
        .get();
  }
  else if(farmType=='Groups'){
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('groups')
        .where("name", isEqualTo: name)
        .get();
  }
}


Future deleteService(String docid) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(docid)
      .delete()
      .then((value) {
        print("Updated Booking");

      })
      .catchError((error) => print("Failed to Update Booking: $error"));
}
/// Check If Document Exists








