
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('services');

Future sp_addservice(String service_name,String category,
    String price_per_unit,String no_of_service,String description) async {
  return serviceProvidersCollectionReference
      .add({
    'service_name': service_name,
    'category': category,
    'price_per_unit':price_per_unit,
    'no_of_service':no_of_service,
    'description':description,


  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}