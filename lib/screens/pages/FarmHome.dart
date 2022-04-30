import 'package:AgriNet/screens/pages/service_catalog.dart';
import 'package:AgriNet/screens/pages/wishlist_catalog.dart';
import 'package:AgriNet/widget/bookingSummaryCard.dart';
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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Stack(
      children: <Widget>[


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
                color: Colors.black26,
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
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => GroupChatHomeScreen(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.schema,
                                size: 33.0 ,
                                color: Color(0xffedf1f0)
                              ),
                              //label: Text('Home')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 1.0, 2.0, 2.0),
                            child: Text(
                              "Join",
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
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => BookingSummaryCard(),
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
                              icon: Icon(Icons.category,
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
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    //builder: (ctx) => MyHomePage(),
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
                                    builder: (ctx) => WishlistCatalog(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.favorite,
                                size: 33.0 ,
                                  color: Color(0xffedf1f0)
                              ),
                              //label: Text('Home')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 2.0),
                            child: Text(
                              "Fav",
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
}