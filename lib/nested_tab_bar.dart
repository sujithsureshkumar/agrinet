import 'package:AgriNet/FarmHome.dart';
import 'package:AgriNet/MyHomePage.dart';
import 'package:AgriNet/ServiceCatalogue.dart';
import 'package:AgriNet/navBar/signOut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class nested_tab_bar extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _nested_tab_barState createState() => _nested_tab_barState();
}

class _nested_tab_barState extends State<nested_tab_bar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child:Center(
              child:Text("AgriNet")
              ),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'Farmer',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'ServiceProvider',
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Labour',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),

          body: TabBarView(
            children: <Widget>[
              HomeTopTabs(),
              HomeTopTabs(),
              HomeTopTabs(),
            ],
          ),
        ));
  }



  HomeTopTabs() {
    return DefaultTabController(
      length: 5,

      child: Stack(
          children: <Widget>[

            Positioned(
              bottom:20,
        child:Container(
          width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16.0),
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
                        padding: const EdgeInsets.all(2.0),
                        child: IconButton(

                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => MyHomePage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.schema, size: 44.0 ,),
                          //label: Text('Home')
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
                        child: Text(
                          "Join",
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
                        padding: const EdgeInsets.all(2.0),
                        child: IconButton(

                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => MyHomePage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.category, size: 44.0 ,),
                          //label: Text('Home')
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
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
                        padding: const EdgeInsets.all(2.0),
                        child: IconButton(

                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => MyHomePage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.assignment, size: 44.0 ,),
                          //label: Text('Home')
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
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
                  padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: IconButton(

                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => MyHomePage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.favorite, size: 44.0 ,),
                          //label: Text('Home')
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
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
      ),
    );



  }
}