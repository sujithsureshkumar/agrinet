

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';

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


/// Check If Document Exists
Future<void> deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<void> deleteAppDir() async {
  final appDir = await getApplicationSupportDirectory();

  if(appDir.existsSync()){
    appDir.deleteSync(recursive: true);
  }
}



