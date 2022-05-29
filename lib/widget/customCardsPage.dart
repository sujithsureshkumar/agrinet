import 'package:AgriNet/screens/group_chats/group_chat_screen.dart';
import 'package:AgriNet/screens/pages/bookingListing.dart';
import 'package:AgriNet/screens/pages/farmListing.dart';
import 'package:AgriNet/screens/pages/groupInfoPage.dart';
import 'package:AgriNet/screens/pages/paymentHistory.dart';
import 'package:AgriNet/screens/pages/service_catalog.dart';
import 'package:AgriNet/screens/pages/wishlist_catalog.dart';
import 'package:AgriNet/widget/customCard.dart';
import 'package:AgriNet/widget/emptySection.dart';
import 'package:flutter/material.dart';

class CustomCardsPage extends StatelessWidget {
  final double appBarHeight = AppBar().preferredSize.height;
  final double navBarHeight = 100.0;
  final double extendedAppBarHeight = 50.0;
  final double topCardHeight = 175.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 175.0,
                width: MediaQuery.of(context).size.width,
                child: customCard(
                    "Farm Services", "Explore Now", Icons.search,
                   () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ServiceCatalogue()
                      ),
                    );
                  },
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    height: ((MediaQuery.of(context).size.height) -
                        appBarHeight -
                        navBarHeight -
                        extendedAppBarHeight -
                        topCardHeight) *
                        .35,
                    width: MediaQuery.of(context).size.width * .5,
                    child: customCard(
                        "Your Farms", "Now Here", Icons.accessibility,
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                 builder: (ctx) => FarmListing()
                               ),
                             );
                          },
                    )),
                Container(
                  height: ((MediaQuery.of(context).size.height) -
                      appBarHeight -
                      navBarHeight -
                      extendedAppBarHeight -
                      topCardHeight) *
                      .55,
                  width: MediaQuery.of(context).size.width * .5,
                  child: customCard("Service Bookings", "History",
                      Icons.access_alarm,
                        () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => BookingListing()
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                    height: ((MediaQuery.of(context).size.height) -
                        appBarHeight -
                        navBarHeight -
                        extendedAppBarHeight -
                        topCardHeight) *
                        .55,
                    width: MediaQuery.of(context).size.width * .5,
                    child: customCard(
                        "Farm Groups", "Joy of Join Farming", Icons.groups,
                          () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => GroupChatHomeScreen(),
                          ),
                        );
                      },
                    )),
                Container(
                    height: ((MediaQuery.of(context).size.height) -
                        appBarHeight -
                        navBarHeight -
                        extendedAppBarHeight -
                        topCardHeight) *
                        .35,
                    width: MediaQuery.of(context).size.width * .5,
                    child: customCard(
                        "WishList", "Services You Love", Icons.brightness_5,
                          () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => WishlistCatalog()
                          ),
                        );
                      },
                    )),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 175.0,
                width: MediaQuery.of(context).size.width,
                child: customCard(
                    "Payment History", "Check Now", Icons.access_alarm,
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => PaymentHistory()
                      ),
                    );
                  },
                )),
          ],
        ),
       SizedBox(
         height:100,
       )
      ],
    );
  }
}