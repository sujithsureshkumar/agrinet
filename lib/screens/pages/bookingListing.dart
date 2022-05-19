import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/widget/bookingListingCard.dart';
import 'package:AgriNet/widget/bookingSummaryCard.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingListing extends StatefulWidget {
  BookingListing({Key key}) : super(key: key);

  @override
  _BookingListingState createState() => _BookingListingState();
}

class _BookingListingState extends State<BookingListing> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    servicesProvider.getBookingSnapShot('uid',user.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Booking History",
        child: DefaultBackButton(),
      ),
      body:Consumer<ServicesProvider>(
        builder: (context, servicesProvider, _) {
          return ListView(
            //padding: EdgeInsets.all(12),
            children: [
              Column(
                children: <Widget>[
                  Column(
                      children: servicesProvider.bookingList.map((p) {
                        return BookingListingCard(
                            status: "Rejected",
                            serviceCategory: "Rubber",
                            price: p.price,
                            farmerName: p.farmName,
                            booking: p,
                        );
                      }).toList()
                  ),
                ],
              ),
            ],
          );
        }
      )


    );
  }
}