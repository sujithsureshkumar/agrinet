
import 'package:AgriNet/screens/pages/addImage.dart';
import 'package:AgriNet/screens/pages/laborProfile.dart';
import 'package:AgriNet/test/location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaborDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Profile",
      icon:Icons.person,
      widget:LaborProfile()
  );


  Items item2 = new Items(
    title: "Location",
      icon:Icons.location_on,
      widget:Location()
  );
  Items item3 = new Items(
    title: "Bank Account",
      icon: Icons.account_balance_wallet,
      widget:AddImage()
  );
  Items item4 = new Items(
    title: "Activity",
      icon: Icons.local_activity,
      widget:LaborProfile()
  );
  Items item5 = new Items(
    title: "To do",
      icon:Icons.person,
      widget:LaborProfile()
  );
  Items item6 = new Items(
    title: "Settings",
      icon:Icons.person,
      widget:LaborProfile()
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4,];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => data.widget
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffb9b3c2),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Icon(
                    data.icon,
                    size: 66,
                    color: Color(0xff83b13a),
                  ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  IconData icon;
  Widget widget;
  Items({this.title, this.subtitle, this.event, this.img,this.icon,this.widget});
}
