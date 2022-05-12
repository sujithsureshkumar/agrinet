import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/farmListingCard.dart';
import 'package:AgriNet/widget/serviceListingCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class FarmListing extends StatefulWidget {
  FarmListing({Key key}) : super(key: key);

  @override
  _FarmListingState createState() => _FarmListingState();
}

class _FarmListingState extends State<FarmListing> {
  @override
  Widget build(BuildContext context) {
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    final user = Provider.of<Users>(context);
    servicesProvider.getserviceListing(user.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(title: "My Listings"),

      body: Consumer<FarmProvider>(
          builder: (context, farmProvider, _)  {
            return ListView(
              //padding: EdgeInsets.all(12),
              children: [
                Column(
                  children: <Widget>[
                    Column(
                        children: farmProvider.serviceList.map((p) {
                          return FarmListingCard(service: p);
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