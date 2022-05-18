import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';

class LaborProfile extends StatefulWidget {
  LaborProfile({Key key}) : super(key: key);

  @override
  _LaborProfileState createState() => _LaborProfileState();
}

class _LaborProfileState extends State<LaborProfile> {
  final _globalkey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _phone = TextEditingController();
  TextEditingController _mainSkill = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(title: "My Profile"),
    bottomNavigationBar: Material(
          elevation: kLess,
          color: kWhiteColor,
          child:Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child:TextButton(
              child: Text("Update", style: TextStyle(fontSize: 18.0)),
              style: TextButton.styleFrom(
                  primary: kWhiteColor,
                  elevation: 2,
                  backgroundColor: kPrimaryColor),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  //builder: (context) => DeliveryAddress(),
                ),
              ),
            ),
          ),

            ),
      body: Column(
        children: [
          Stack(
           // overflow: Overflow.visible,
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 250.0,
                child: Image(
                  image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/Required%20files%2FbannerImage.jpg?alt=media&token=4f72866b-917a-4d3f-aecd-c991fc13e666"),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -60.0,
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: kWhiteColor,
                      width: kLess,
                    ),
                    image: DecorationImage(
                      image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-sa_II3GuTyXT0EGyW7sKvep9GTL1lmIZW2RjO98L8DgGeZ4iD4ussfCcQgW22FiFnMo&usqp=CAU"),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -88.0,
                child: Text(
                  'Username',
                  style: kDarkTextStyle,
                ),
              ),
            ],
          ),
      Form(
        key: _globalkey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 108.0,left: 10,right: 10),
              child:phoneField(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0,left: 10,right: 10),
              child:skillTextField(),
            ),
          ],
        ),
      ),

        ],
      ),
    );
  }

  snackBarMsg(BuildContext context, String msg) {
    var sb = SnackBar(
      elevation: kRadius,
      content: Text(msg),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        // textColor: kWhiteColor,
        label: 'OK',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(sb);
  }

  Widget phoneField() {
    return TextFormField(
      controller: _phone,
      keyboardType:TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return "price can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.green,
        ),
        labelText: "Phone Number",
        helperText: "It helps to Contact you ",
      ),
    );
  }

  Widget skillTextField() {
    return TextFormField(
      controller: _mainSkill,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.agriculture,
          color: Colors.green,
        ),
        labelText: "Main Skill",
        helperText: "Field that You can Work",
      ),
    );
  }
}