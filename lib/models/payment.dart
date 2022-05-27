import 'package:flutter/foundation.dart';
class Payment {
  String docid;
  String fromType;
  String fromName;
  String fromOwnerName;
  String price;
  String uid;
  String toid;
  String toType;
  String toName;
  String toOwnerName;
  String bookingId;
  DateTime createdOn;
  String status;
  DateTime paymentDate;
  String payment_id;
  String payment_order_id;
  String payment_signature;
  String farmerPaymentDirection;
  String spPaymentDirection;
  String laborPaymentDirection;
  Payment({
    @required this.docid,
    @required this.fromType,
    @required this.fromName,
    @required this.fromOwnerName,
    @required this.price,
    @required this.uid,
    @required this.toid,
    @required this.toType,
    @required this.toName,
    @required this.toOwnerName,
    @required this.bookingId,
    @required this.createdOn,
    @required this.status,
    @required this.paymentDate,
    @required this.payment_id,
    @required this.payment_order_id,
    @required this.payment_signature,
    @required this.farmerPaymentDirection,
    @required this.spPaymentDirection,
    @required this.laborPaymentDirection,
  });

}