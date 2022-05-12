import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/widget/bookingSummaryCard.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingSummary extends StatefulWidget {
  BookingSummary({Key key}) : super(key: key);

  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    servicesProvider.getBookingSnapShot('spid',user.uid);
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(
        title: "Service Requests",
        child: DefaultBackButton(),
    ),
    body:Consumer<ServicesProvider>(
        builder: (context, servicesProvider, _)  {
          return ListView(
            //padding: EdgeInsets.all(12),
            children: [
              Column(
                children: <Widget>[
                  Column(
                      children: servicesProvider.bookingList.map((p) {
                        return BookingSummaryCard(
                          booking: p,
                        );
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