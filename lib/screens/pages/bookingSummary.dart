import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/bookingSummaryCard.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:flutter/material.dart';

class BookingSummary extends StatefulWidget {
  BookingSummary({Key key}) : super(key: key);

  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(
        title: "Booking Requests",
        child: DefaultBackButton(),
    ),
    body:Column(
      children: [
        BookingSummaryCard(
          status: "Rejected",
          serviceCategory: "Rubber",
          price: "2000",
          farmerName: 'Alice',
        ),

        BookingSummaryCard(
          status: "Rejected",
          serviceCategory: "Rubber",
          price: "2000",
          farmerName: 'Alice',
        ),
      ],
    ),


    );
  }
}