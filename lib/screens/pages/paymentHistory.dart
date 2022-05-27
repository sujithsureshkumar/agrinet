import 'package:AgriNet/widget/paymentHistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';

class PaymentHistory extends StatefulWidget {
  PaymentHistory({Key key}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(
          title: "Booking History",
          child: DefaultBackButton(),
        ),
        body:SingleChildScrollView(
        child: Column(
    children: [
      PaymentHistoryCard(),
      PaymentHistoryCard(),
    ]
        )
        )


    );
  }
}