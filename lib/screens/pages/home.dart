import 'package:AgriNet/screens/pages/service_catalogue.dart';
import 'package:flutter/material.dart';

import 'FarmHome.dart';

class Home extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              FarmHome(),
              FarmHome(),
              FarmHome(),
            ],
          ),
        ));
  }
}