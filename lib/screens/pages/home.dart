import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/service_catalogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/profile.dart';
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
    //_selectedTab = getTabs();
    //_tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

 // bool farmer = false;
  //bool serviceProvider = true;
  //bool labour = true;

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
       if(provider.profiles[i].isSelected){
         _selectedWidgets.add(_allWidgets[i]);
       }
       i++;
     }

    return _selectedWidgets;
  }


  List<Tab> getTabs() {
    _selectedTab.clear();
    ProfileData provider =Provider.of<ProfileData>(context, listen: false);
      var i = 0;
      while (i < 3) {
        if (provider.profiles[i].isSelected) {
          _selectedTab.add(_tabs[i]);
        }
        i++;
      }

    return _selectedTab;
  }


  TabController getTabController() {
    return TabController(length: _selectedTab.length, vsync: this)..addListener(_updatePage);
  }

  void _updatePage() {
    setState(() {});
  }

  Widget ProfileItem(Profile data) {
    return ListTile(
      title: Text(
        data.name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: data.isSelected
          ? Icon(
        Icons.check_circle,
        color: Colors.green[700],
      )
          : Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      ),
      onTap: () {
        ProfileData profileProvider =Provider.of<ProfileData>(context, listen: false);
        setState(() {
          profileProvider.getProfileSetCount();
          if (profileProvider.profileSetCount<2){
            data.isSelected = true;
          profileProvider.updateFirebaseProfile(
              profileProvider.profiles[0].isSelected,
              profileProvider.profiles[1].isSelected,
              profileProvider.profiles[2].isSelected
          );
        }else{
            data.isSelected = !data.isSelected;
            profileProvider.updateFirebaseProfile(
                profileProvider.profiles[0].isSelected,
                profileProvider.profiles[1].isSelected,
                profileProvider.profiles[2].isSelected
            );
          }

        });
      },
    );
  }

  Widget _buildMyDrawer() {
    ProfileData profileProvider =Provider.of<ProfileData>(context, listen: false);
    return Drawer(
      child:  SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: profileProvider.profiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return item
                      return ProfileItem(
                        profileProvider.profiles[index]
                      );
                    }),
              ),
              profileProvider.count> 0 ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green[700],
                    child: Text(
                      "Proceed (${profileProvider.count})",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      //print("Delete List Lenght: ${selectedProfiles.length}");
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => Home()));
                    },
                  ),
                ),
              ): Container(),
            ],
          ),
        ),
      ),
    );
  }



@override
  Widget build(BuildContext context) {
  _selectedTab = getTabs();
  _tabController = getTabController();
    return Scaffold(
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child:Center(
          child:Text("AgriNet")
          ),
        ),
        bottom: TabBar(
          //isScrollable: true,
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