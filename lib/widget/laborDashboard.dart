
import 'package:AgriNet/screens/pages/laborProfile.dart';
import 'package:AgriNet/screens/pages/laborRequestSummary.dart';
import 'package:AgriNet/screens/pages/locationDetails.dart';
import 'package:AgriNet/screens/pages/paymentHistory.dart';
import 'package:AgriNet/screens/pages/rasorpayPayment.dart';
import 'package:AgriNet/screens/pages/success.dart';
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
      widget:LocationDetails()
  );
  Items item3 = new Items(
    title: "Bank Account",
      icon: Icons.account_balance_wallet,
      widget:RasorpayPayment()
  );
  Items item4 = new Items(
    title: "Requests",
      icon: Icons.local_activity,
      widget:laborRequestSummary(),
  );
  Items item5 = new Items(
    title: "To do",
      icon:Icons.person,
      widget:LaborProfile()
  );
  Items item6 = new Items(
    title: "Settings",
      icon:Icons.person,
      widget:Success()
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
                    color: Colors.purple[400],
                    image: DecorationImage(
                      image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/Required%20files%2Fbanner2.jpg?alt=media&token=9a215c7b-6fde-4def-b988-c6e985c203cb"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Icon(
                      data.icon,
                      size: 30,
                      color: Colors.white,
                    ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
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
