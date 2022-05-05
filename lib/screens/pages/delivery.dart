
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/date_range_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  List<String> statesList;
  String _myState;
  String _myStateList;

  List<String> typeList=['Individual','Groups'];
  Map<String, List<String>> selectedTypeList ={'Individual':['Item 1', 'Item 2' , 'Item 3'],
    'Groups':['Group 1', 'Group 2' , 'Group 3']};

  _getList(){
    setState(() {
      statesList = selectedTypeList[_myState];
      _myStateList=null;
    });
  }

  _newGetList() async {
    final user = Provider.of<Users>(context,listen: false);
    FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);

    setState(() {
      if(_myState=='Individual'){
        farmProvider.fetchUserFarm(user.uid);
      }
      if(_myState=='Groups'){
        farmProvider.fetchUserGroup(user.uid);
      }
      _myStateList=null;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<Users>(context);
    //FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);
    //farmProvider.fetchUserGroup(user.uid);
    ServicesProvider servicesProvider = Provider.of<ServicesProvider >(context, listen: false);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "More Details",
        child: DefaultBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderLabel(
              headerText: "Please Provide some more details",
            ),

            SizedBox(
              height: kDefaultPadding,
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(kShape)),
                color: kAccentColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: _myState,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Select Type of Farming'),
                          onChanged: (String newValue) {
                            setState(() {
                              _myState = newValue;
                              _newGetList();
                              print(_myState);
                            });
                          },
                          items: typeList?.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item),
                              value: item,
                            );
                          })?.toList() ??
                              [],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //======================================================== City

            Consumer<FarmProvider>(
              builder: (context, farmProvider, _) {
                //print(farmProvider.groupList);
                return Container(
                  //padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  //color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(kShape)),
                    color: kAccentColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: _myStateList,
                              iconSize: 30,
                              icon: (null),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('Select Farm'),
                              onChanged: (String newValue) {
                                setState(() {
                                  _myStateList = newValue;
                                  print(_myStateList);
                                });
                              },
                              items: farmProvider.groupList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item),
                                  value: item,
                                );
                              })?.toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
           /* DefaultTextField(
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
          .toList(),
          onChanged:(item)=>setState(()=>selectedItem = item),
      )
    ),
            */
            SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              'Date Range',
              style: TextStyle(color: kLightColor, fontSize: 20.0),
            ),
            DateRangePickerWidget(),

            DefaultButton(
              btnText: "Go to payment",
              onPressed: () => addBooking(servicesProvider.startTimeStamp,servicesProvider.endTimeStamp),
              color: kPrimaryColor,
              textColor: kWhiteColor,
              ratio: 1,
            ),



          ],
        ),
      ),
    );
  }
}