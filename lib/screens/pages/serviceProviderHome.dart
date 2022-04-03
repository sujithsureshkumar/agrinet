import 'package:AgriNet/screens/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../providers/profile_data.dart';
import '../../services/firebase_api_methods.dart';
import '../../widget/navigationServiceProvider.dart';
import 'SPOonBoarding.dart';


class ServiceProviderHome extends StatefulWidget {
  @override
  _ServiceProviderHomeState createState() => _ServiceProviderHomeState();
}


class _ServiceProviderHomeState extends State<ServiceProviderHome> {
 ProfileData profile;
  @override
  void initState() {

    super.initState();
  }
  @override
  void didChangeDependencies() {
    final user = Provider.of<Users>(context);
    profile =Provider.of<ProfileData>(context, listen: true);
    profile.spFormFillCheck(user.uid);
    print(profile.profileStatus);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        //backgroundColor: Colors.grey[900],

        body: Stack(
          children: [
            profile.profileStatus ?Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => SPOnBoarding(),
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
                                'Service Provider',
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
            ): Container(),

            Positioned(
            bottom:20,
            child:NavigationServiceProvider()
            ),
          ],
        ),
    );


  }
}