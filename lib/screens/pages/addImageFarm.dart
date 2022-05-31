import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../models/users.dart';
import '../../providers/imgProvider.dart';
import '../../providers/services_provider.dart';
import '../../services/firebase_api_methods.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class AddImageFarm extends StatefulWidget {
  AddImageFarm({Key key}) : super(key: key);
  @override
  _AddImageFarmState createState() => _AddImageFarmState();
}

class _AddImageFarmState extends State<AddImageFarm> {
  //final scrollController = ScrollController();
  //ImgPicker ImgPick;
  bool circular = false;
  TextEditingController _street = TextEditingController();
  TextEditingController _locality = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _country = TextEditingController();

  String location ='Null, Press Button';
  String Address = 'search';
  Placemark place;
  Position position;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }

  Widget addImageCard() {
    ImgProvider imgProvider = Provider.of<ImgProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              /* builder: (ctx) => DetailScreen(
                image:service.imageUrl ,
                name:service.name ,
                price: service.price,
              ),*/
            ),
          );
        },
        child: Container(
          height: 200,
          width: 150.0,
          child: Card(
            color: Color(0xffb9b3c2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: IconButton(

                            onPressed: () {
                              imgProvider.uploadImage();
                            },
                            icon: Icon(Icons.add, size: 44.0 ,),
                            //label: Text('Home')
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Add Image",
                          style: TextStyle (
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget catalogueCard(String imagelink) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              /* builder: (ctx) => DetailScreen(
                image:service.imageUrl ,
                name:service.name ,
                price: service.price,
              ),*/
            ),
          );
        },
        child: Container(
          height: 200,
          child: Card(
            color: Color(0xffb9b3c2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 200.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imagelink)
                            )
                        )),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget locationTextField(TextEditingController name,String label) {
    return TextFormField(
      controller: name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      enabled:false,
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
        labelText: label,
        //helperText: "Name can't be empty",
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    ImgProvider imgProvider = Provider.of<ImgProvider>(context, listen: false);
    imgProvider.imageUrlList.clear();
    super.dispose();
  }


  bool fixed=false;
  @override
  Widget build(BuildContext context){
    final user = Provider.of<Users>(context);
    FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);
    return Consumer<ImgProvider>(
        builder:(context, imgProvider, _) {
          return Scaffold(
            appBar:DefaultAppBar(title: "Add Image"),
            bottomNavigationBar: Material(
              elevation: kLess,
              color: kWhiteColor,
              child: Row(
                children: [
                  SizedBox(
                      width:5
                  ),
                  Expanded(
                    child: TextButton(
                      //padding: EdgeInsets.symmetric(vertical: kLessPadding),
                      //color: kPrimaryColor,
                      //textColor: kWhiteColor,
                      child: Text("Skip", style: TextStyle(fontSize: 18.0)),
                      style: TextButton.styleFrom(
                          primary: kWhiteColor,
                          elevation: 2,
                          backgroundColor: kLightColor),
                      onPressed: () => Navigator.of(context)
                        ..pop(),
                       // ..pop()
                    ),
                  ),

                  SizedBox(
                      width:10
                  ),
                  Expanded(
                    child: TextButton(
                      //padding: EdgeInsets.symmetric(vertical: kLessPadding),
                      //color: kPrimaryColor,
                      //textColor: kWhiteColor,
                      child: Text("Submit", style: TextStyle(fontSize: 18.0)),
                      style: TextButton.styleFrom(
                        primary: kWhiteColor,
                        elevation: 2,
                        backgroundColor: kPrimaryColor,
                      ),
                      onPressed: () async {
                        if(imgProvider.imageUrlList.length>0){
                          await UpdateImageFarmAdd(imgProvider.imageUrlList,user.uid,farmProvider.docid,
                              position.latitude,position.longitude)
                              .then((value) => {
                            Navigator.of(context)
                              ..pop(),
                              //..pop()
                          });
                        }
                      }),
                  ),
                  SizedBox(
                      width:5
                  ),
                ],
              ),
            ),
            //backgroundColor: Colors.grey[900],
            body: Column(
              children: [
                Container(
                  child: SingleChildScrollView(
                    scrollDirection:Axis.horizontal,
                    padding: EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: <Widget>[
                          Row(
                              children:[addImageCard()]
                          ),

                          Row(
                            children: imgProvider.imageUrlList.map((p) {
                              return catalogueCard(p);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                      child:SizedBox(
                          width:MediaQuery.of(context).size.width*0.75,
                          child: locationTextField(_street,"Street")),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                      child: Container(
                        //margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38)
                        ),
                        child: IconButton(

                          onPressed: () async {
                            position = await _getGeoLocationPosition();
                            location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                            GetAddressFromLatLong(position);

                            setState(() {
                              _street.text = place.street;
                              _locality.text = place.locality;
                              _district.text = place.subAdministrativeArea;
                              _state.text = place.administrativeArea;
                              _postalCode.text = place.postalCode;
                              _country.text = place.country;
                              fixed=true;
                              // _controllerEmail.text = widget.email;
                            });
                          },
                          icon:fixed? Icon(Icons.gps_fixed,
                              size: 33.0 ,
                              color: Color(0xff141514)
                          ):Icon(Icons.gps_not_fixed,
                                size: 33.0 ,
                                color: Color(0xff353935)
                          //label: Text('Home')
                        ),
                      ),
                    ),
                    ),

                  ],
                ),


                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child:locationTextField(_locality,"Locality"),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child:locationTextField(_district,"District"),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child:locationTextField(_state,"State"),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child:locationTextField(_postalCode,"Postal Code"),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child:locationTextField(_country,"Country"),
                ),

              ],


            ),


          );

        }
    );
  }
}