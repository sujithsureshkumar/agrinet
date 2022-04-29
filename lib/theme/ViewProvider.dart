import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewProvider extends StatefulWidget {
  @override
  _ViewProviderState createState() => _ViewProviderState();
}
class _ViewProviderState extends State<ViewProvider> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon: Icon(FontAwesomeIcons.arrowLeft),
    onPressed: () {
    Navigator.pop(context);
    }),
          title:Text('                AGRINET',
              textAlign: TextAlign.center),
           backgroundColor:(Colors.green),
    ),
        /*body:Image(image:NetworkImage("https://media.istockphoto.com/photos/tractor-cultivating-field-at-spring-picture-id543212762?k=20&m=543212762&s=612x612&w=0&h=3x8yNlzSApOGoZyPZl4cx_ioPLAna-AXt8SvkildxRo="),
          width:500.0,
          height:800.0,
        )*/
      body:SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Center(child:Image(image:NetworkImage("https://media.istockphoto.com/photos/tractor-cultivating-field-at-spring-picture-id543212762?k=20&m=543212762&s=612x612&w=0&h=3x8yNlzSApOGoZyPZl4cx_ioPLAna-AXt8SvkildxRo="),
        ),
              ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
      Align(
      alignment: Alignment.center,
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text('GREEN TRAC FARM EQUIPMENTS',
                  style:TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,

                  ),
                  ),

          ),


            ],

          ),
        ),


      ),
      ],
      ),

      ]
      ),
      ),
      ),
    );
  }
}


