import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabourCatalog extends StatefulWidget {
  LabourCatalog({Key key}) : super(key: key);

  @override
  _LabourCatalogState createState() => _LabourCatalogState();
}

class _LabourCatalogState extends State<LabourCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(title: "Labours"),

      body:Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child:Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 55.0,
                    height: 55.0,
                    //color: Colors.green,
                    child:CircleAvatar(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.green,
                      backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-sa_II3GuTyXT0EGyW7sKvep9GTL1lmIZW2RjO98L8DgGeZ4iD4ussfCcQgW22FiFnMo&usqp=CAU",
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      Text(
                        "Designation",
                        style: TextStyle(
                            color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: TextButton(
                  child: Text("Request", style: TextStyle(fontSize: 18.0)),
                  style:  ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          )
                        )
                    ),
                  //onPressed: () =>
                ),
              ),
            ],
          )
        )
      )
    );
  }
}