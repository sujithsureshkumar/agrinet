

import 'package:AgriNet/models/labor.dart';
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
      .then((value) async {
        print("User Added");

      })
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
      .update({
    'farmer': farmer,
    'labour': serviceProvider,
    'serviceProvider': labour,
    'spFormFill': spFormFill,
  });
}






Future sp_addservice(String uid,String service_name,String category,
    String price_per_unit,String description ,List<String> imageurl,) async {
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
    'locationSet':true,
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


Future addBooking(Service service, Users user,String bookingId,
    String farmType,String farmName,String serviceCategory,
    String serviceSubCategory,Timestamp startTime,Timestamp endTime
    ,farmLocation) async {
  String _docid = Uuid().v1();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('Bookings');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .set({
    'docid':_docid,
    'bookingId':bookingId,
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
    'contractFarmer':false,
    'isFarmerPaymentDone':false,
    'farmerPaymentDate':FieldValue.serverTimestamp(),
    "farmer_payment_id": "pay_29QQoUBi66xm2f",
    "farmer_order_id": "order_9A33XWu170gUtm",
    "farmer_signature": "9ef4dffbfd84f1318f6739a3ce19f9d85851857ae648f114332d8401e0949a3d",
    'contractSp':false,
    'spPaymentDate':FieldValue.serverTimestamp(),
    'isSpPaymentDone':false,
    "Sp_payment_id": "pay_29QQoUBi66xm2f",
    "Sp_order_id": "order_9A33XWu170gUtm",
    "Sp_signature": "9ef4dffbfd84f1318f6739a3ce19f9d85851857ae648f114332d8401e0949a3d",

    "farmLocation":farmLocation,


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


Future farmer_onboarding(String uid,String name,String phone_number,String account_holder_name,
    String account_number,String ifs_code,String bank_name,bool formStatus ) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('farmUser');
  return serviceProvidersCollectionReference
      .doc(uid)
      .set({
    'docid':uid,
    'name': name,
    'phone_number':phone_number,
    'account_holder_name':account_holder_name,
    'account_number':account_number,
    'ifs_code':ifs_code,
    'bank_name':bank_name,
    'createdOn':FieldValue.serverTimestamp(),
    'wishlist':[],
    'allFarm': [],

  })
      .then((value) async {
        print("User Added");
        firebaseFirestore.collection('Users')
            .doc(uid)
            .update({
          'farmerFormFill': formStatus,
        }).then((value) async {
          print("Status Changed");
          await firebaseFirestore.collection('farmUser').doc(uid)
              .collection("allfarms")
              .doc("allFarm")
              .set({
            'allFarm': []
          });
        });

      })
      .catchError((error) => print("Failed to add user: $error"));
}

Future labour_onboarding(String uid,String name,String phone_number,String skill,String _locality,
    String _district,String _state,String pincode,String account_holder_name, String account_number,String ifs_code,
    String bank_name,bool formStatus ) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('labor');
  return serviceProvidersCollectionReference
      .doc(uid)
      .set({
    'docid':uid,
    'name': name,
    'phone_number':phone_number,
    'skill':skill,
    'locality':_locality,
    'district':_district,
    'state':_state,
    'pincode':pincode,
    'account_holder_name':account_holder_name,
    'account_number':account_number,
    'ifs_code':ifs_code,
    'bank_name':bank_name,
    'imagerUrl':"hfjhdfjdj",
  'createdOn':FieldValue.serverTimestamp(),

  })
      .then((value) async {
    print("Labour Added");
    firebaseFirestore.collection('Users')
        .doc(uid)
        .update({
      'laborFormFill': formStatus,
    }).then((value) async {
      print("Status Changed");
    });

  })
      .catchError((error) => print("Failed to add user: $error"));
}


Future addLaborHiring(Labor labor, Users user,String hiringId,
    String hiringType,String hirerName,String hirerLocality,
    String hirerdistrict,String hirerState,String hirerPincode,String hirerPhone_number
    ,Timestamp startTime,Timestamp endTime) async {
  String _docid = Uuid().v1();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('laborHiring');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .set({
    'docid':_docid,
    'hiringId':hiringId,
    'hiringType':hiringType,
    'hirerName':hirerName,
    'hirerLocality':hirerLocality,
    'hirerdistrict':hirerdistrict,
    'hirerState':hirerState,
    'hirerPincode':hirerPincode,
    'hirerPhone_number':hirerPhone_number,
    'uid':user.uid,
    'laborPhone_number':labor.phone_number,
    'laborid':labor.docid,
    'laborName':labor.name,
    'laborSkill':labor.skill,
    'laborlocality':labor.locality,
    'labordistrict':labor.district,
    'laborstate':labor.state,
    'laborpincode':labor.pincode,
    'startTime': startTime,
    'endTime': endTime,
    'createdOn':FieldValue.serverTimestamp(),
    'status':'Pending',
    'statusOn':FieldValue.serverTimestamp(),

    'contractLabor':false,
    'isLaborPaymentDone':false,
    'laborPaymentDate':FieldValue.serverTimestamp(),
    "labor_payment_id": "pay_29QQoUBi66xm2f",
    "labor_order_id": "order_9A33XWu170gUtm",
    "labor_signature": "9ef4dffbfd84f1318f6739a3ce19f9d85851857ae648f114332d8401e0949a3d",
    'contractOtherParty':false,
    'otherPartyPaymentDate':FieldValue.serverTimestamp(),
    'isOtherPartyPaymentDone':false,
    "otherParty_payment_id": "pay_29QQoUBi66xm2f",
    "otherParty_order_id": "order_9A33XWu170gUtm",
    "otherParty_signature": "9ef4dffbfd84f1318f6739a3ce19f9d85851857ae648f114332d8401e0949a3d"


  })
      .then((value) {
    print("addLaborHiring Added");
  })
      .catchError((error) => print("Failed to addLaborHiring: $error"));
}

Future updateLaborHiring(String docid,String status) async {
  await FirebaseFirestore.instance.collection('laborHiring')
      .doc(docid)
      .update({
    'status': status,
    'statusOn':FieldValue.serverTimestamp(),
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Updated Booking"))
      .catchError((error) => print("Failed to Update Booking: $error"));
}


Future updatelabourProfile(String uid,String name,String phone_no,String skill) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('labor');
  return serviceProvidersCollectionReference
      .doc(uid)
      .update({
    'docid':uid,
    'name': name,
    'phone_number':phone_no,
    'skill':skill,

  })
      .then((value) async {
    print("Labour Profile data updated");

  })
      .catchError((error) => print("Failed to update: $error"));
}

Future updateBankAccount(String firestorefield,String uid,String account_holder_name,
    String account_number,String ifsc_code) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection(firestorefield);
  return serviceProvidersCollectionReference
      .doc(uid)
      .update({
    'account_holder_name':account_holder_name,
    'account_number':account_number,
    'ifs_code':ifsc_code,

  })
      .then((value) async {
    print("Labour Profile data updated");

  })
      .catchError((error) => print("Failed to update: $error"));
}

Future updatelocation(String firestorefield,String uid,String _locality,
    String _district,String _state,String pincode) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection(firestorefield);
  //'labor'
  return serviceProvidersCollectionReference
      .doc(uid)
      .update({
    'locality':_locality,
    'district':_district,
    'state':_state,
    'pincode':pincode,

  })
      .then((value) async {
    print("Labour location data updated");

  })
      .catchError((error) => print("Failed to update: $error"));
}

Future capturePaymentDetails(String uid, String fromType, String fromName, String fromOwnerName, String price,
String toid, String toType, String toName, String toOwnerName, String bookingId, String status, String payment_id,
String payment_order_id, String payment_signature,
    ) async {
  String _docid = Uuid().v1();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('payment');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .set({
    'docid':_docid,
    'fromType':fromType,
    'fromName':fromName,
    'fromOwnerName':fromOwnerName,
    'price':price,
    'uid':uid,
    'toid':toid,
    'toType':toType,
    'toName':toName,
    'toOwnerName':toOwnerName,
    'bookingId':bookingId,
    'createdOn':FieldValue.serverTimestamp(),
    'status':status,
    'paymentDate':FieldValue.serverTimestamp(),
    'payment_id':payment_id,
   'payment_order_id':payment_order_id,
    'payment_signature':payment_signature,
    //'farmerPaymentDirection':farmerPaymentDirection,
    //'spPaymentDirection':spPaymentDirection,
   //'laborPaymentDirection':laborPaymentDirection,
    //'participants':[uid,toid],

  })
      .then((value) async {
    print("Payment Capture Successfuly");

  })
      .catchError((error) => print("Failed to Capture Payment: $error"));
}

Future updatePaymentInBookingFarmer(String docid,String farmer_payment_id,String farmer_order_id,
    String farmer_signature
    ) async {
  await FirebaseFirestore.instance.collection('Bookings')
      .doc(docid)
      .update({
    'statusOn':FieldValue.serverTimestamp(),
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
    'isFarmerPaymentDone':true,
    'farmerPaymentDate':FieldValue.serverTimestamp(),
    "farmer_payment_id": farmer_payment_id,
    "farmer_order_id": farmer_order_id,
    "farmer_signature": farmer_signature,
  })
      .then((value) => print("Updated Payment in Booking"))
      .catchError((error) => print("Failed to Updated Payment in Booking: $error"));
}


Future updateContractSignInBookingSp(String _docid,bool contractSp) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('Bookings');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .update({
    'contractSp':contractSp,
  })
      .then((value) {
    print("updated");
  })
      .catchError((error) => print("Failed to update: $error"));
}

Future updateContractSignInBookingFarmer(String _docid,bool contractFarmer) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('Bookings');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .update({
    'contractFarmer':contractFarmer,
  })
      .then((value) {
    print("updated");
  })
      .catchError((error) => print("Failed to update: $error"));
}

Future updateContractSignInLaborHIringOtherParty(String _docid,bool contractOtherParty) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('laborHiring');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .update({
    'contractOtherParty':contractOtherParty,
  })
      .then((value) {
    print("updated");
  })
      .catchError((error) => print("Failed to update: $error"));
}

Future updateContractSignInLaborHIringLabor(String _docid,bool contractLabor) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('laborHiring');
  return serviceProvidersCollectionReference
      .doc(_docid)
      .update({
    'contractLabor':contractLabor,
  })
      .then((value) {
    print("updated");
  })
      .catchError((error) => print("Failed to update: $error"));
}

Future updatePaymentInBookingSp(String docid,String sp_payment_id,String sp_order_id,
    String sp_signature
    ) async {
  await FirebaseFirestore.instance.collection('Bookings')
      .doc(docid)
      .update({
    'spPaymentDate':FieldValue.serverTimestamp(),
    'isSpPaymentDone':true,
    "Sp_payment_id": sp_payment_id,
    "Sp_order_id": sp_order_id,
    "Sp_signature": sp_signature,
  })
      .then((value) => print("Updated Payment in Booking"))
      .catchError((error) => print("Failed to Updated Payment in Booking: $error"));
}
/// Check If Document Exists








