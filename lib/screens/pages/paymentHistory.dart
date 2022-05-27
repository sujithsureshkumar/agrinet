import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/paymentProvider.dart';
import 'package:AgriNet/widget/paymentHistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:provider/provider.dart';

class PaymentHistory extends StatefulWidget {
  PaymentHistory({Key key}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    paymentProvider.getPaymentSnapShot(user.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Payment History",
        child: DefaultBackButton(),
      ),
      body:Consumer<PaymentProvider>(
          builder: (context, paymentProvider, _)  {
            return ListView(
              padding: EdgeInsets.all(12),
              children: [
                Column(
                  children: <Widget>[
                    Column(
                        children: paymentProvider.PaymentList.map((p) {
                          return PaymentHistoryCard (payment: p,);
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