import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/laborProvider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:AgriNet/widget/laborRequestHistoryCard.dart';
import 'package:AgriNet/widget/laborRequestSummaryCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class laborRequestSummary extends StatefulWidget {
  laborRequestSummary({Key key}) : super(key: key);

  @override
  _laborRequestSummaryState createState() => _laborRequestSummaryState();
}

class _laborRequestSummaryState extends State<laborRequestSummary> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    LaborProvider laborProvider = Provider.of<LaborProvider>(context, listen: false);
    laborProvider.getLaborHiringSnapShot('laborid',user.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Labor Request Summary",
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
                          return LaborRequestSummaryCard(
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