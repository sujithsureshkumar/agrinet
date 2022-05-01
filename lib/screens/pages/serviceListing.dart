import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/serviceListingCard.dart';
import 'package:flutter/material.dart';




class ServiceListing extends StatefulWidget {
  ServiceListing({Key key}) : super(key: key);

  @override
  _ServiceListingState createState() => _ServiceListingState();
}

class _ServiceListingState extends State<ServiceListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(title: "My Listings"),

        body: ServiceListingCard()
    );
  }
}