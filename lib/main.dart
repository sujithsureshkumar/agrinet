import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/screens/page/users_page.dart';
import 'package:AgriNet/screens/pages/login.dart';
import 'package:AgriNet/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:AgriNet/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyHomePage.dart';
import 'nested_tab_bar.dart';
import 'package:AgriNet/screens/pages/homepage.dart';
import 'package:AgriNet/providers/product_provider.dart';
import 'package:AgriNet/providers/category_provider.dart';

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
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        StreamProvider<Users>.value(
            value: AuthService().user),
      ],
      //child: StreamProvider<Users>.value(
       // value: AuthService().user,
        child: MaterialApp(
          // Initialize FlutterFire
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color(0xFFC41A3B),
            primaryColorLight: Color(0xFFFBE0E6),
            accentColor: Color(0xFF1B1F32),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return Login();
              }
            },
          ),
        ),
     // ),
    );
  }

}





