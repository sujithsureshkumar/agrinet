import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class nested_tab_bar1 extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _nested_tab_barState createState() => _nested_tab_barState();
}

class _nested_tab_barState extends State<nested_tab_bar1> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Cutom_App_bar(),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'Home',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Game',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Music',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Book',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Movie',
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
              HomeTopTabs(),
              HomeTopTabs(),
            ],
          ),
        ));
  }

  Cutom_App_bar() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.horizontal_split),
              color: Colors.blueGrey,
              onPressed: () {},
            ),
          ),
          Container(
              child: Text(
                'Google Play',
                style: TextStyle(color: Colors.grey),
              )),
          Container(
            child: IconButton(
              icon: Icon(Icons.mic),
              color: Colors.blueGrey,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  HomeTopTabs() {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: 6.0,
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.trending_up,
                  color: Colors.green,
                ),
                child: Text(
                  'Trending',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.assessment,
                  color: Colors.green,
                ),
                child: Text(
                  'Top Chart',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.green,
                ),
                child: Text(
                  'New',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.category,
                  color: Colors.green,
                ),
                child: Text(
                  'Category',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.green,
                ),
                child: Text(
                  'Monrtization',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              color: Colors.purple,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.yellow,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}