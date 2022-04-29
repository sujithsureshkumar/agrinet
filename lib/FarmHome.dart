import 'package:AgriNet/theme/ViewProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor:(Colors.green),
          ),
          body: Center(child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                child: Text(
                  'View Service Provider',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewProvider()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  elevation: MaterialStateProperty.all(4),),

              ),
            ),

          ]
          ))
      ),
    );
  }

}