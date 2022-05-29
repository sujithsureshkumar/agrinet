import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/laborProvider.dart';
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/screens/pages/labourOnboarding.dart';
import 'package:AgriNet/widget/laborDashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LabourHome extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _LabourHomeState createState() => _LabourHomeState();
}

class _LabourHomeState extends State<LabourHome> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    LaborProvider laborData =Provider.of<LaborProvider>(context, listen: false);
    laborData.spFormFillCheck(user.uid);
    ProfileData profile =Provider.of<ProfileData>(context, listen: false);
    return Consumer<LaborProvider>(
      builder: (context, laborProvider, _) {
        laborProvider.profileStatus ?null:profile.getLaborDetails(user.uid);
        return laborProvider.profileStatus ?Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => LabourOnboarding(),
                  ),
                );
              },
              child: Container(
                width:  MediaQuery
                    .of(context)
                    .size
                    .width *0.8,
                height: MediaQuery
                    .of(context)
                    .size
                    .height*0.4,
                decoration: BoxDecoration(
                  color:Color(0xffedf1f0),
                  //border: Border.all(color: Colors.red[500],),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        //flex: 2,
                        child: Text(
                          'WELCOME',
                          style: TextStyle(
                            color: Color(0xff27c791),
                            fontSize: 35,
                            fontWeight: FontWeight. bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 5,
                            //textAlign:Alignment.bottomRight,

                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Labor',
                          style: TextStyle(
                            color: Color(0xff27c791),
                            fontSize: 15,
                            fontWeight: FontWeight. bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Complete Your Profile',
                                style: TextStyle(
                                  color: Color(0xff27c791),
                                  fontSize: 15,
                                  fontWeight: FontWeight. bold,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 5,
                                ),),
                            ),
                            Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_forward_sharp, size: 44.0 ,
                                    color:Color(0xff27c791),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ),
        ):Stack(
          children: <Widget>[
            Consumer<ProfileData>(
              builder: (context, data, child) {
                return data.isloading?Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ) : Column(
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
                                //"Johny",
                              data.laborDetails.name,
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
                    LaborDashboard(
                      account_holder_name: data.laborDetails.account_holder_name,
                      account_number: data.laborDetails.account_number,
                      ifsc_code: data.laborDetails.ifs_code,
                      locality: data.laborDetails.locality,
                      distric: data.laborDetails.district,
                      state: data.laborDetails.state,
                      pincode: data.laborDetails.pincode,
                    )
                  ],
                );
              }
            ),


          ],
        );
      }
    );
  }
}