import 'package:AgriNet/widget/laborDashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabourHome extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _LabourHomeState createState() => _LabourHomeState();
}

class _LabourHomeState extends State<LabourHome> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Johny",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Home",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Color(0xffa29aac),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            LaborDashboard()
          ],
        ),


      ],
    );
  }
}