import 'package:flutter/material.dart';
import 'package:AgriNet/screens/SPOonBoarding.dart';
import 'package:AgriNet/screens/home/sp_addservice.dart';
import 'package:AgriNet/screens/home/addfarm.dart';

class FarmHome extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _FarmHomeState createState() => _FarmHomeState();
}
class _FarmHomeState extends State<FarmHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(child: Column(children: <Widget>[

            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text('sponboard', style: TextStyle(fontSize: 20.0),),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SPOnBoarding()),
                   );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text('addservice', style: TextStyle(fontSize: 20.0),),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreatProfile()),
                  );

                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text('addfarm', style: TextStyle(fontSize: 20.0),),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addFarm()),
                  );

                },
              ),
            ),
          ]
          ))
      ),
    );
  }
}

// class _FarmHomeState extends State<FarmHome> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child:ElevatedButton(
//           style: ButtonStyle(
//             foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//             backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SPOnBoarding()),
//             );
//           },
//           child: Text('SPOnBoarding'),
//         )
//
//       ),
//       body:Container(
//           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//           child:ElevatedButton(
//             style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SPOnBoarding()),
//               );
//             },
//             child: Text('SPOnBoarding'),
//           )
//
//       ),
//     ); //Scaffold
//   }
// }
