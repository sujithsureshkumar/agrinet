import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/service_catalogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FarmHome.dart';

class Home extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    _selectedTab = getTabs();
    _tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool farmer = false;
  bool serviceProvider = true;
  bool labour = true;

  List<Widget> _selectedWidgets = [];

  List<Tab> _selectedTab = [];

  List<Tab> _tabs = [
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

  ];

  List<Widget> _allWidgets = [
    FarmHome(),
    FarmHome(),
    FarmHome(),
  ];

  List<Widget> getWidgets() {
    _selectedWidgets.clear();
    ProfileData provider =Provider.of<ProfileData>(context, listen: false);
      var i=0;
     while(i<3){
       if(provider.getProfile[i]){
         _selectedWidgets.add(_allWidgets[i]);
       }
       i++;
     }

    return _selectedWidgets;
  }

 /* List<Widget> getWidgets() {
    _selectedWidgets.clear();
    if(farmer){
      _selectedWidgets.add(_allWidgets[0]);
    }

    if(serviceProvider){
      _selectedWidgets.add(_allWidgets[1]);
    }

    if(labour){
      _selectedWidgets.add(_allWidgets[2]);
    }

    return _selectedWidgets;
  }*/

  List<Tab> getTabs() {
    _selectedTab.clear();
    ProfileData provider =Provider.of<ProfileData>(context, listen: false);
      var i = 0;
      while (i < 3) {
        if (provider.getProfile[i]) {
          _selectedTab.add(_tabs[i]);
        }
        i++;
      }

    return _selectedTab;
  }


  /*List<Tab> getTabs() {
    _selectedTab.clear();
    if(farmer){
      _selectedTab.add(_tabs[0]);
    }

    if(serviceProvider){
      _selectedTab.add(_tabs[1]);
    }

    if(labour){
      _selectedTab.add(_tabs[2]);
    }
    return _selectedTab;
  }*/

  TabController getTabController() {
    return TabController(length: _selectedTab.length, vsync: this)..addListener(_updatePage);
  }

  void _updatePage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child:Center(
          child:Text("AgriNet")
          ),
        ),
        bottom: TabBar(
          tabs: _selectedTab,
          controller: _tabController,
        ),
      ),

      body: TabBarView(
        children: getWidgets(),
        controller: _tabController,
      ),
    );
  }
}