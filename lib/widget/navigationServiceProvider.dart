import 'package:AgriNet/screens/pages/addService.dart';
import 'package:AgriNet/screens/pages/serviceDetails.dart';
import 'package:AgriNet/screens/pages/serviceListing.dart';
import 'package:flutter/material.dart';

class NavigationServiceProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              //builder: (ctx) => AddService(),
                            ),
                          );
                        },
                        icon: Icon(Icons.person,
                            size: 33.0 ,
                            color: Color(0xffedf1f0)
                        ),
                        //label: Text('Home')
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 1.0, 2.0, 2.0),
                      child: Text(
                        "Profile",
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
                              //builder: (ctx) => ServiceCatalogue(),
                            ),
                          );
                        },
                        icon: Icon(Icons.view_list,
                            size: 33.0 ,
                            color: Color(0xffedf1f0)
                        ),
                        //label: Text('Home')
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 2.0),
                      child: Text(
                        "Listings",
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
                              builder: (ctx) => AddService(),
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
                              builder: (ctx) => ServiceListing(),
                            ),
                          );
                        },
                        icon: Icon(Icons.receipt,
                            size: 33.0 ,
                            color: Color(0xffedf1f0)
                        ),
                        //label: Text('Home')
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 2.0),
                      child: Text(
                        "Request",
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
                              //builder: (ctx) => WishlistCatalog(),
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
    );
  }
}