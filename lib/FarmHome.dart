import 'package:flutter/material.dart';
import 'package:AgriNet/screens/SPOonBoarding.dart';

class FarmHome extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _FarmHomeState createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child:ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SPOnBoarding()),
            );
          },
          child: Text('SPOnBoarding'),
        )
        
      ),
    ); //Scaffold
  }
}
