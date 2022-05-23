import 'package:AgriNet/screens/pages/bookingSummary.dart';
import 'package:AgriNet/screens/pages/laborCatalog.dart';
import 'package:AgriNet/screens/pages/serviceListing.dart';
import 'package:flutter/material.dart';
import 'package:AgriNet/widget/customCard.dart';
class SpDashboard extends StatelessWidget {
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
                      "View Your Profile", "Come Back!", Icons.remove_red_eye,
                          () {
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
                          "Your services", "Key For All", Icons.add_task,
                              () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => ServiceListing()
                                  ),
                                );
                          },
                        )),
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => LaborCatalog()
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
                            .45,
                        width: MediaQuery.of(context).size.width * .5,
                        child: customCard(
                          "Service requests", "Happy To Serve", Icons.hourglass_bottom,
                              () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => BookingSummary()
                                  ),
                                );
                          },
                        )),
                  ],
                ),
              ],
            ),
          ],
        );
  }
}