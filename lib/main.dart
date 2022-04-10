import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/imgProvider.dart';
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/providers/wrapperNew.dart';
import 'package:AgriNet/providers/wrapperNext.dart';
import 'package:AgriNet/providers/wrapperNxt.dart';
import 'package:AgriNet/screens/pages/addImage.dart';
import 'package:AgriNet/screens/pages/addService.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:AgriNet/screens/pages/profile_selection.dart';
import 'package:AgriNet/screens/pages/serviceProviderHome.dart';
import 'package:AgriNet/screens/pages/service_catalogue.dart';
import 'package:AgriNet/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:AgriNet/providers/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dynamic_tab_bar_test/dynamic_tab_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //initilization of Firebase app

  // other Firebase service initialization

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context)=>ProfileData()),
      StreamProvider<Users>.value(value: AuthService().user),
      ChangeNotifierProvider(create: (context) => ImgProvider())


    ],
        child: MaterialApp(
          // Initialize FlutterFire
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color(0xFFC41A3B),
            primaryColorLight: Color(0xFFFBE0E6),
            accentColor: Color(0xFF1B1F32),
          ),
          home:AddService()
        ),
        );

  }

}





