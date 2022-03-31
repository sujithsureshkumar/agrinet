

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('service_providers');

Future sp_onboarding(String service_provider_name,String service_type,
    String location,String phone_number,String account_holder_name,
    String account_number,String ifs_code,String bank_name,String pincode ) async {
  return serviceProvidersCollectionReference
      .add({
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