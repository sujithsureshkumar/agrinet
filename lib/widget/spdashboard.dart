import 'package:flutter/material.dart';
import 'package:AgriNet/widget/customCard.dart';
class SpDashboard extends StatelessWidget {
  final double appBarHeight = AppBar().preferredSize.height;
  final double navBarHeight = 100.0;
  final double extendedAppBarHeight = 50.0;
  final double topCardHeight = 175.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text(
              'SP_Dashboard',
            ),
          ),

    body: Column(
      children: <Widget>[
        // Container(
        //     height: ((MediaQuery.of(context).size.height) -
        //         appBarHeight -
        //         navBarHeight -
        //         extendedAppBarHeight -
        //         topCardHeight) *
        //         .35,
        //     width: MediaQuery.of(context).size.width * .5,
        //     child: customCard(
        //       "Farm Groups", "Joy of Join Farming", Icons.groups,
        //           () {
        //         // Navigator.of(context).push(
        //         //   MaterialPageRoute(
        //         //       builder: (ctx) => GroupInfoPage()
        //         //   ),
        //         // );
        //       },
        //     )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 175.0,
                width: MediaQuery.of(context).size.width,
                child: customCard(
                  "View Your Profile", "Now Here", Icons.search,
                      () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //       builder: (ctx) => ServiceCatalogue()
                    //   ),
                    // );
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
                        .85,
                    width: MediaQuery.of(context).size.width * .5,
                    child: customCard(
                      "Your services", "Explore Now", Icons.miscellaneous_services,
                          () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (ctx) => FarmListing()
                        //   ),
                        // );
                      },
                    )),
                // Container(
                //   height: ((MediaQuery.of(context).size.height) -
                //       appBarHeight -
                //       navBarHeight -
                //       extendedAppBarHeight -
                //       topCardHeight) *
                //       .35,
                //   width: MediaQuery.of(context).size.width * .5,
                //   child: customCard("Service Bookings", "History",
                //     Icons.access_alarm,
                //         () {
                //       // Navigator.of(context).push(
                //       //   MaterialPageRoute(
                //       //       builder: (ctx) => BookingListing()
                //       //   ),
                //       // );
                //     },
                //   ),
                // ),
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
                        .45,
                    width: MediaQuery.of(context).size.width * .5,
                    child: customCard(
                      "Find Labours", "Good At Task ", Icons.people,
                          () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (ctx) => GroupInfoPage()
                        //   ),
                        // );
                      },
                    )),
                Container(
                    height: ((MediaQuery.of(context).size.height) -
                        appBarHeight -
                        navBarHeight -
                        extendedAppBarHeight -
                        topCardHeight) *
                        .45,
                    width: MediaQuery.of(context).size.width * .5,
                    child: customCard(
                      "Service requests", "History", Icons.hourglass_bottom,
                          () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (ctx) => WishlistCatalog()
                        //   ),
                        // );
                      },
                    )),
              ],
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Container(
        //         height: 175.0,
        //         width: MediaQuery.of(context).size.width,
        //         child: customCard(
        //           "Contract Signing", "Now Easy", Icons.access_alarm,
        //               () {
        //             // Navigator.of(context).push(
        //             //   MaterialPageRoute(
        //             //       builder: (ctx) => ServiceCatalogue()
        //             //   ),
        //             // );
        //           },
        //         )),
        //   ],
        // ),
      ],
    )
    );
  }
}