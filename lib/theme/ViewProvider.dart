import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:google_fonts/google_fonts.dart";
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

      body:SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Image(image:NetworkImage("https://media.istockphoto.com/photos/tractor-cultivating-field-at-spring-picture-id543212762?k=20&m=543212762&s=612x612&w=0&h=3x8yNlzSApOGoZyPZl4cx_ioPLAna-AXt8SvkildxRo="),


              ),

              SizedBox(height:20),


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
              const Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
      //SizedBox(height:20),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Name',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Mike',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      //SizedBox(height:20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Location ',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Paris, France',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      //SizedBox(height:20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Phone ',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('7865456789',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),

                    ],
                  ),
                ),
              ),
            ],
        ),

              SizedBox(height:5),

      /*Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,

            child: Container(
              child: Column(
                children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {},
              /*style: ElevatedButton.styleFrom(
                  primary: Colors.blue, //background color of button
                  side: BorderSide(width:4, color:Colors.brown), //border width and color
                  elevation: 5, //elevation of button
                  //shape: RoundedRectangleBorder( //to set border radius to button
                  //borderRadius: BorderRadius.circular(40)
                  // ),
                  padding: EdgeInsets.all(20) //content padding inside button
              ),*/
                    icon: Icon( // <-- Icon
                      Icons.star,
                      size: 11.0,
                    ),
                    label: Text('Ratings'),

                  ),
                  SizedBox(width: 50),
                  /*ElevatedButton(
                    child: Text(
                      'Services',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),

                    onPressed: () {

                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      elevation: MaterialStateProperty.all(4),),

                  ),*/
                  SizedBox(width: 50),

                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon( // <-- Icon
                      Icons.phone,
                      size: 11.0,
                    ),
                    label: Text('Contact'),

                  ),

                ],
              )
        ],
      ),

      ),
      ),
      ]
      ),*/
               const Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
        Align(
        alignment: Alignment.centerLeft,

            child: Container(
                child: Column(
                    children: <Widget>[


                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
              ElevatedButton(
                child: Text( 'Top Services',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),

                ),

                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //background color of button
                    side: BorderSide(width:4, color:Colors.brown), //border width and color
                    elevation: 5, //elevation of button
                    //shape: RoundedRectangleBorder( //to set border radius to button
                        //borderRadius: BorderRadius.circular(40)
                   // ),
                    padding: EdgeInsets.all(40) //content padding inside button
                )

              ),
                      SizedBox(width: 5),
                      ElevatedButton(
                          child: Text( 'Equipments',
                            style: TextStyle(color: Colors.white, fontSize: 20.0),

                          ),

                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue, //background color of button
                              side: BorderSide(width:4, color:Colors.brown), //border width and color
                              elevation: 5, //elevation of button
                              //shape: RoundedRectangleBorder( //to set border radius to button
                              //borderRadius: BorderRadius.circular(40)
                              // ),
                              padding: EdgeInsets.all(40) //content padding inside button
                          )

                      )

        ]
    )
        ]
      )
      )
        )
        ]),
              const Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
            ])
    )
    )
    );
  }


}


