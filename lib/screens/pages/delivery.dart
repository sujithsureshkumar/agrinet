
import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../widget/defaultAppBar.dart';
import '../../widget/defaultBackButton.dart';
import '../../widget/defaultButton.dart';
import '../../widget/defaultTextField.dart';
import '../../widget/headerLabel.dart';

class Delivery extends StatefulWidget {
  Delivery({Key key}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  List<String> items=['Item 1', 'Item 2' , 'Item 3'];
  String selectedItem = 'Item 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Delivery Address",
        child: DefaultBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderLabel(
              headerText: "Where are your ordered items shipped?",
            ),
            DefaultTextField(
              hintText: "State",
              icon: Icons.map,
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: kFixPadding,
            ),
            DefaultTextField(
              hintText: "City",
              icon: Icons.location_city,
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: kFixPadding,
            ),
            DefaultTextField(
              hintText: "Locality",
              icon: Icons.landscape,
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: kFixPadding,
            ),
            DefaultTextField(
              hintText: "Pincode",
              icon: Icons.location_city,
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            DefaultButton(
              btnText: "Go to payment",
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                 // builder: (context) => Payment(),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(kShape)),
                  color: kAccentColor,
                ),
        child:DropdownButtonFormField<String>(
        //decoration:InputDecoration(
         // enabledBorder:OutlineInputBorder(
        //  borderRadius:BorderRadius.circular(12),
        //  borderSide:BorderSide(width:3,color:Colors.blue),
        //),
     // ),
        value:selectedItem,
        items:items.map((item)=>DropdownMenuItem<String>(
          value:item,
          child:Text(item,
          style:TextStyle(fontSize: 24)
             )
          )
        )
          .toList(),onChanged:(item)=>setState(()=>selectedItem = item),
      )
    )
          ],
        ),
      ),
    );
  }
}