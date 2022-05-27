import 'package:AgriNet/models/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PaymentProvider extends ChangeNotifier {
  List<Payment> PaymentList=[];
  Future<void> getPaymentSnapShot(String uid) async {
    //List<Product> newList = [];
    QuerySnapshot _paymentSnapShot = await FirebaseFirestore.instance.collection('payment')
        //.where('participants', arrayContains: uid)
        .where('uid', isEqualTo: uid)
        .get();
    PaymentList=_paymentSnapShot.docs.map((snap) {
      return Payment(
          docid:snap.get('docid'),
         fromType:snap.get('fromType'),
      fromName:snap.get('fromName'),
      fromOwnerName:snap.get('fromOwnerName'),
          price:snap.get('price'),
          uid:snap.get('uid'),
         toid:snap.get('toid'),
         toType:snap.get('toType'),
      toName:snap.get('toName'),
      toOwnerName:snap.get('toOwnerName'),
      bookingId:snap.get('bookingId'),
      createdOn:snap.get('createdOn').toDate(),
      status:snap.get('status'),
      paymentDate:snap.get('paymentDate').toDate(),
      payment_id:snap.get('payment_id'),
      payment_order_id:snap.get('payment_order_id'),
       payment_signature:snap.get('payment_signature'),
       //farmerPaymentDirection:snap.get('farmerPaymentDirection'),
       //spPaymentDirection:snap.get('spPaymentDirection'),
       //laborPaymentDirection:snap.get('laborPaymentDirection'),
        //serv_prov_name:
      );

    }).toList();
    notifyListeners();
  }
}