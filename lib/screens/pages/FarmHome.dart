import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/addfarm.dart';
import 'package:AgriNet/screens/pages/bookingListing.dart';
import 'package:AgriNet/screens/pages/bookingSummary.dart';
import 'package:AgriNet/screens/pages/dateFarmSelection.dart';
import 'package:AgriNet/screens/pages/editService.dart';
import 'package:AgriNet/screens/pages/farmerOnboarding.dart';
import 'package:AgriNet/screens/pages/laborCatalog.dart';
import 'package:AgriNet/screens/pages/profile_selection.dart';
import 'package:AgriNet/screens/pages/serviceListing.dart';
import 'package:AgriNet/screens/pages/service_catalog.dart';
import 'package:AgriNet/screens/pages/wishlist_catalog.dart';
import 'package:AgriNet/widget/bookingSummaryCard.dart';
import 'package:AgriNet/widget/customCardsPage.dart';
import 'package:AgriNet/widget/serviceListingCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../group_chats/group_chat_screen.dart';

class FarmHome extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _FarmHomeState createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  ProfileData profile;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);
    profile =Provider.of<ProfileData>(context, listen: false);
    profile.FarmerFormFillCheck(user.uid);
    return Consumer<ProfileData>(
      builder: (context, profileData, _) {
        profileData.farmerProfileStatus ?null:farmProvider.getFarmerDetails(user.uid);
        return profileData.farmerProfileStatus ?Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => FarmerOnboarding(),
                  ),
                );
              },
              child: Container(
                width:  MediaQuery
                    .of(context)
                    .size
                    .width *0.8,
                height: MediaQuery
                    .of(context)
                    .size
                    .height*0.4,
                decoration: BoxDecoration(
                  color:Color(0xffedf1f0),
                  //border: Border.all(color: Colors.red[500],),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        //flex: 2,
                        child: Text(
                          'WELCOME',
                          style: TextStyle(
                            color: Color(0xff27c791),
                            fontSize: 35,
                            fontWeight: FontWeight. bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 5,
                            //textAlign:Alignment.bottomRight,

                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'FARMER',
                          style: TextStyle(
                            color: Color(0xff27c791),
                            fontSize: 15,
                            fontWeight: FontWeight. bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Complete Your Profile',
                                style: TextStyle(
                                  color: Color(0xff27c791),
                                  fontSize: 15,
                                  fontWeight: FontWeight. bold,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 5,
                                ),),
                            ),
                            Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_forward_sharp, size: 44.0 ,
                                    color:Color(0xff27c791),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ),
        ):Stack(
          children: <Widget>[
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: CustomCardsPage()
            ),

            Positioned(
              bottom:20,
              child:Container(
                width: MediaQuery.of(context).size.width,
                //height: 100,
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  child: Container(
                    //color: Colors.black26,
                     color: Color(0xffa694a7),
                    child: Row(
                      children:<Widget> [
                        Container(
                          padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 1.0),
                                child: IconButton(

                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => GroupChatHomeScreen(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.groups,
                                    size: 33.0 ,
                                    color: Color(0xffedf1f0)
                                  ),
                                  //label: Text('Home')
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(14.0, 1.0, 2.0, 2.0),
                                child: Text(
                                  "Groups",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                      //fontSize: 12
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: IconButton(

                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => AddFarm(),
                                      ),
                                    );

                                  },
                                  icon: Icon(Icons.add,
                                      size: 33.0 ,
                                      color: Color(0xffedf1f0)
                                  ),
                                  //label: Text('Home')
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 2.0),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: IconButton(

                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => ServiceCatalogue(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.widgets,
                                    size: 33.0 ,
                                      color: Color(0xffedf1f0)
                                  ),
                                  //label: Text('Home')
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 2.0),
                                child: Text(
                                  "Catalogue",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: IconButton(

                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => BookingListing(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.assignment,
                                    size: 33.0 ,
                                      color: Color(0xffedf1f0)
                                  ),
                                  //label: Text('Home')
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 2.0),
                                child: Text(
                                  "Booking",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(12.0, 1.0, 2.0, 2.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: IconButton(

                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) =>LaborCatalog(hirer:"farmer",),
                                            //WishlistCatalog(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.person_add,
                                    size: 33.0 ,
                                      color: Color(0xffedf1f0)
                                  ),
                                  //label: Text('Home')
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 2.0),
                                child: Text(
                                  "Hire Labor",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        );
      }
    );
  }
}