import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/serviceListingCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class ServiceListing extends StatefulWidget {
  ServiceListing({Key key}) : super(key: key);

  @override
  _ServiceListingState createState() => _ServiceListingState();
}

class _ServiceListingState extends State<ServiceListing> {
  @override
  Widget build(BuildContext context) {
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    final user = Provider.of<Users>(context);
    servicesProvider.getserviceListing(user.uid);
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(title: "My Listings"),

        body: Consumer<ServicesProvider>(
          builder: (context, servicesProvider, _)  {
            return ListView(
              //padding: EdgeInsets.all(12),
              children: [
                Column(
                  children: <Widget>[
                    Column(
                        children: servicesProvider.serviceList.map((p) {
                          return ServiceListingCard(service: p);
                        }).toList()
                    ),
                  ],
                ),
              ],
            );
          }
        ),
    );
  }
}