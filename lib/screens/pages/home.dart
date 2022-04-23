
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/profilepage.dart';
import 'package:AgriNet/screens/pages/serviceProviderHome.dart';
import 'package:AgriNet/screens/pages/service_catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AgriNet/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/profile.dart';
import '../../models/users.dart';
import 'FarmHome.dart';
import 'drawerProfileSelection.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';

class Home extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  final AuthService _auth =AuthService();

  TabController _tabController;

  @override
  void initState() {
    _selectedTab = getTabs();
    _selectedWidgets =getWidgets();
    _tabController = getTabController();
    //_selectedTab = getTabs();
    //_selectedWidgets =getWidgets();
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

  ];

  List<Widget> _allWidgets = [
    FarmHome(),
    ServiceProviderHome(),
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
    final user = Provider.of<Users>(context);
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
          profileProvider.updateFirebaseProfile(user.uid,
              profileProvider.profiles[0].isSelected,
              profileProvider.profiles[1].isSelected,
              profileProvider.profiles[2].isSelected
          );
        }else{
            data.isSelected = !data.isSelected;
            profileProvider.updateFirebaseProfile(user.uid,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://media.istockphoto.com/photos/summer-sunset-with-a-red-barn-in-rural-montana-and-rocky-mountains-picture-id863542630?k=20&m=863542630&s=612x612&w=0&h=4-udm8ANCd3yZwfEW00QDBrqnwYXFaOGhbM2Rlcobdk="),

                    ),
                ),
              padding: EdgeInsets.all(0),
              child: Container(
              child: Column(
            children: [
                const SizedBox(
                    height: 10,
                    ),
                GestureDetector(
                child:CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage("http://cdn.onlinewebfonts.com/svg/img_364496.png"),
                      ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ProfilePage(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                   height: 10,
                    ),
              Text(
                    'Gabc efg',
                  style: GoogleFonts.sanchez(
                  fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                    ),
                    ),
                const SizedBox(
                  height: 5,
                  ),
                Text(
                    'abc@def.com',
                  style: GoogleFonts.sanchez(
                  fontSize: 10,
                color: Colors.black,
              fontWeight: FontWeight.w400,
                    ),
                  ),
               ],
               ),
            ),
          ),
      Expanded(
        child: ListView(
            children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => DrawerprofileSelection()));
          },
          leading: Icon(Icons.person),
          title: Text("Profile"),
        ),
              ListTile(
                onTap: () async{
                  await _auth.signOut();
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
        ]
    ),
      ),
  ]
    ),
    );
  }


@override
  Widget build(BuildContext context) {

  //_selectedTab = getTabs();
  //_tabController = getTabController();
    return Scaffold(
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child:Text("AgriNet"),
        ),
        bottom: TabBar(
          //isScrollable: true,
          unselectedLabelColor:Colors.redAccent,
          indicatorSize:TabBarIndicatorSize.tab,
          indicator:BoxDecoration(
              gradient:LinearGradient(colors:[Colors.redAccent,Colors.orange]),
            borderRadius:BorderRadius.circular(50),
              color:Colors.redAccent),
          tabs: _selectedTab,
          controller: _tabController,
        ),
      ),

      body: TabBarView(
        children: _selectedWidgets,
        controller: _tabController,
      ),
    );
  }


}