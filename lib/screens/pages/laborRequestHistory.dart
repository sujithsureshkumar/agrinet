import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/laborProvider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:AgriNet/widget/laborRequestHistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class laborRequestHistory extends StatefulWidget {
  laborRequestHistory({Key key}) : super(key: key);

  @override
  _laborRequestHistoryState createState() => _laborRequestHistoryState();
}

class _laborRequestHistoryState extends State<laborRequestHistory> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    LaborProvider laborProvider = Provider.of<LaborProvider>(context, listen: false);
    laborProvider.getLaborHiringSnapShot('uid',user.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Labor Request History",
        child: DefaultBackButton(),
      ),
      body:Consumer<LaborProvider>(
          builder: (context, laborProvider, _)  {
            return ListView(
              //padding: EdgeInsets.all(12),
              children: [
                Column(
                  children: <Widget>[
                    Column(
                        children: laborProvider.LaborHiringList.map((p) {
                          return LaborRequestHistoryCard(
                            laborHiring: p,
                          );
                        }).toList()
                    ),
                  ],
                ),
              ],
            );
          }
      ),


    );
  }
}