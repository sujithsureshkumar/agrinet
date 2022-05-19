import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/booking.dart';
import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:AgriNet/widget/headerLabel.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class ContractSigning extends StatefulWidget {
  final Booking booking;
  ContractSigning({this.booking,Key key,}) : super(key: key);

  @override
  _ContractSigningState createState() => _ContractSigningState();
}

class _ContractSigningState extends State<ContractSigning> {

  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : "rzp_test_balglISzQZ6UwH",
      "amount" : 30000,
      "name" : "Sample App",
      "description" : "Payment for the some random Services",
      "prefill" : {
        "contact" : "2323232323",
        "email" : "shdjsdh@gmail.com"
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  void handlerPaymentSuccess(){
    print("Pament success");
    Toast.show("Pament success");
  }

  void handlerErrorFailure(){
    print("Pament error");
    Toast.show("Pament error");
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(
        title: "Contract",
        child: DefaultBackButton(),
    ),

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
                child: Text("Pay", style: TextStyle(fontSize: 18.0)),
                style: TextButton.styleFrom(
                  primary: kWhiteColor,
                  elevation: 2,
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () {
                  openCheckout();
                },
              ),
            ),
            SizedBox(
                width:5
            ),
          ],
        ),
      ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
      children: [
      HeaderLabel(
      headerText: "Please Sign the contract",
      ),

      SizedBox(
      height: kDefaultPadding,
      ),

        Text("Serive Name: ${widget.booking.serviceName}",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),

        SizedBox(
          height: kDefaultPadding,
        ),
        Text("Serive Provider Name: ${widget.booking.spName}",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),

        SizedBox(
          height: kDefaultPadding,
        ),
        Text("Category: ${widget.booking.serviceCategory}",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),

        Text("SubCategory: ${widget.booking.serviceSubCategory}",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Text("Date Range:${widget.booking.Startdate} to ${widget.booking.Enddate}",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),

        Text("Advance Amount: 300",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),

      ]
      ),
    ),
    );
  }
}