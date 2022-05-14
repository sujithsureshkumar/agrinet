import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/screens/pages/addfarm.dart';
import 'package:AgriNet/widget/OptionButton.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/farmListingCard.dart';
import 'package:AgriNet/widget/serviceListingCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class FarmListing extends StatefulWidget {
  FarmListing({Key key}) : super(key: key);

  @override
  _FarmListingState createState() => _FarmListingState();
}

class _FarmListingState extends State<FarmListing> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final user = Provider.of<Users>(context);
    FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);
    farmProvider.getFarmSnapShot(user.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(title: "My Farm"),

      body: Stack(
        children: [
          Consumer<FarmProvider>(
              builder: (context, farmProvider, _)  {
                return ListView(
                  //padding: EdgeInsets.all(12),
                  children: [
                    Column(
                      children: <Widget>[
                        Column(
                            children: farmProvider.farmList.map((p) {
                              return FarmListingCard(farm: p);
                            }).toList()
                        ),
                      ],
                    ),
                  ],
                );
              }
          ),

          Positioned(
            bottom: 20,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionButton(
                  text: "Add Farm",
                  icon: Icons.add,width: size.width*0.35,
                  onPressed: () {
                    Navigator.of(context).push
                      MaterialPageRoute(
                        builder: (ctx) => AddFarm(),
                      ),
                    );
                  },
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}