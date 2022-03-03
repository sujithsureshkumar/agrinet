import 'package:AgriNet/FarmHome.dart';
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
                      'Service Provider',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
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
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            FarmHome(),
            FarmHome(),
            FarmHome(),
            FarmHome(),
            FarmHome(),

          ],
          // If you want to disable swiping in tab the use below code
          physics: NeverScrollableScrollPhysics(),

        ),
        bottomNavigationBar:Container(
        padding: EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
          child: Container(
            color: Colors.black26,
            child: TabBar(
              labelColor: Color(0xFFC41A3B),
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 10.0),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black54, width: 0.0),
                insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              ),
              //For Indicator Show and Customization
              indicatorColor: Colors.black54,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home,
                    size: 24.0,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Icons.category,
                    size: 24.0,
                  ),
                  text: 'Department',
                ),
                Tab(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 24.0,
                  ),
                  text: 'Cart',
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                    size: 24.0,
                  ),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(
                    Icons.more,
                    size: 24.0,
                  ),
                  text: 'More',
                ),
              ],

            ),
          ),
        ),
      ),
    ),
    );
  }
}