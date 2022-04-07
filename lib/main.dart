import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/imgProvider.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/screens/pages/sp_addservice.dart';
import 'package:AgriNet/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:AgriNet/providers/wrapper.dart';
import 'package:AgriNet/screens/pages/service_catalogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'imgPickerTest/img_picker.dart';

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
        StreamProvider<Users>.value(value: AuthService().user),
        ChangeNotifierProvider(create: (context) => ServicesProvider()),
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
          home:ServiceCatalogue()
      ),
    );
  }

}





