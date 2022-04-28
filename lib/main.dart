import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:AgriNet/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyHomePage.dart';
import 'nested_tab_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
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
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        // Initialize FlutterFire
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFFC41A3B),
          primaryColorLight: Color(0xFFFBE0E6),
          accentColor: Color(0xFF1B1F32),
        ),
        home: HomePage(),
      ),
    );
  }

}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  var FruitList = ['Coconut','Grapes','Apple','Banana','Cherry'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Page'),
      ),
      body:Center(
        child: ElevatedButton(
          child: const Text('Rate our service'),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      )
      );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key key}) : super(key: key);

  get _ratingValue => null;

  set _ratingValue(double _ratingValue) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Rating Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Rate our Service',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 25),
              // implement the rating bar
              RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color:Colors.orange),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.orange,
                  ),
                  empty: const Icon(
                    Icons.star_outline,
                    color: Colors.orange,
                  )
                ),
                onRatingUpdate: (value){
                  setState((){
                    _ratingValue = value;
                  });
                }
              ),
              const SizedBox(height: 25),
              // Display the rate in number
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  _ratingValue !=null ? _ratingValue.toString() :'Rate it!',
                  style: const TextStyle(color:Colors.white, fontSize: 30),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
