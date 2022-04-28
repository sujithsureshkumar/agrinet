

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';


//final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('service_providers');
Future sp_onboarding(String uid,String service_provider_name,String service_type,
    String location,String phone_number,String account_holder_name,
    String account_number,String ifs_code,String bank_name,String pincode ) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('service_providers');
  return serviceProvidersCollectionReference
      .doc(uid)
      .set({
    'service_provider_name': service_provider_name, // John Doe
    'service_type': service_type, // Stokes and Sons
    'location': location, // 42
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
    String price_per_unit,String no_of_service,String description ,List<String> imageurl) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('services');
  return serviceProvidersCollectionReference
      .add({
    'serv_prov_id': uid,
    'service_name': service_name,
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
}
Future updateImage(List<String> imageurlList, String uid) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(uid)
      .update({
    'imageUrl':imageurlList
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Image added"))
      .catchError((error) => print("Failed to add image: $error"));
}

Future add_to_service_booking(String uid,String service_id,String category,
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
}

/// Check If Document Exists








