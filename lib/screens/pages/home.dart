
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/authenticate/loginScreen.dart';
import 'package:AgriNet/screens/pages/labourHome.dart';
import 'package:AgriNet/screens/pages/paymentHistory.dart';
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
    LabourHome(),
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
                    image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq20VSp1ZPAJ00A4EaQtARiqvA3N4HDW3-yQ&usqp=CAU"),

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
                      backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-sa_II3GuTyXT0EGyW7sKvep9GTL1lmIZW2RjO98L8DgGeZ4iD4ussfCcQgW22FiFnMo&usqp=CAU"),
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
                    'Name',
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
                  await _auth.signOut().then((value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => PaymentHistory())));
                },
                leading: Icon(Icons.payments),
                title: Text("Payment History"),
              ),
              ListTile(
                onTap: () async{
                  await _auth.signOut().then((value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => LoginScreen())));
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
        backgroundColor: Color(0xffa694a7),
        title: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child:Text("AgriNet"),
        ),
        bottom: TabBar(
          //isScrollable: true,
          unselectedLabelColor:Color(0xffe85f5f),
          indicatorSize:TabBarIndicatorSize.tab,
          indicator:BoxDecoration(
              gradient:LinearGradient(colors:[Color(0xffb199b1),Color(
                  0xffc9bfcb)]),
            borderRadius:BorderRadius.circular(50),
              color:Color(0xffd469cc)),
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