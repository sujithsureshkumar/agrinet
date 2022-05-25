import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class PhoneHome extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _PhoneHomeState createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
              child:  ElevatedButton.icon(
                onPressed: () async{
                String telephoneNumber = '+917025821041';
                String telephoneUrl = "tel:$telephoneNumber";
                launchUrl (Uri.parse(telephoneUrl));
                },
                  icon: Icon( // <-- Icon
                  Icons.phone,
                  size: 11.0,
                  ),
                  label: Text('Contact'),
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  elevation:
                  MaterialStateProperty.all(4),),


              ),




              ),


          ]
          ))
      ),
    );
  }

}
