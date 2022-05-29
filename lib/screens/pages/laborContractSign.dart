import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/laborHiring.dart';
import 'package:AgriNet/screens/pages/success.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:AgriNet/widget/headerLabel.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class LaborContractSign extends StatefulWidget {
  LaborHiring laborHiring;
  LaborContractSign({this.laborHiring,Key key,}) : super(key: key);

  @override
  _LaborContractSignState createState() => _LaborContractSignState();
}

class _LaborContractSignState extends State<LaborContractSign> {

  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  bool isSelected=false;

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
      "amount" : 20000,
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

  Future<void> handlerPaymentSuccess(PaymentSuccessResponse response) async {
    print("Pament success");
    //Toast.show("Pament success");
    await capturePaymentDetails(widget.laborHiring.laborid, widget.laborHiring.laborSkill,
      widget.laborHiring.laborName, widget.laborHiring.laborName,
      "200", widget.laborHiring.uid, widget.laborHiring.hiringType,
      widget.laborHiring.hirerName, widget.laborHiring.hirerName, widget.laborHiring.hiringId, "success",
      response.paymentId, response.orderId, response.signature,
    ).then((value) async {
      updatePaymentInBookingFarmer(widget.laborHiring.docid,response.paymentId,response.orderId,
          response.signature);
    }).then((value) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Success(
          onPressed: () => Navigator.of(context)
            ..pop(),
          emptyMsg: "Payment Success !!",
          subTitleText: 'Payment id:'+response.paymentId,
        ),
      ),
    ),);
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
        title: "More Details",
        child: DefaultBackButton(),
      ),

      bottomNavigationBar:widget.laborHiring.status == 'Accepted'? widget.laborHiring.contractLabor?
      widget.laborHiring.isLaborPaymentDone?null:Material(
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
      ):null:null,
      body:widget.laborHiring.status == 'Accepted'?Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              widget.laborHiring.isOtherPartyPaymentDone?Container():ListTile(
                title: Text(
                  'Is Contract Sign needed From Service Provider Side',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: widget.laborHiring.contractOtherParty
                    ? Icon(
                  Icons.toggle_on,
                  color: Colors.green[700],
                  size: 50,
                )
                    : Icon(
                  Icons.toggle_off,
                  color: Colors.grey,
                  size: 50,
                ),
                onTap: () async {

                  setState(() {
                    widget.laborHiring.contractOtherParty = !widget.laborHiring.contractOtherParty;
                  });
                  await updateContractSignInLaborHIringOtherParty(widget.laborHiring.docid,
                      widget.laborHiring.contractOtherParty);
                },
              ),
              HeaderLabel(
                headerText: "Service Details",
              ),

              SizedBox(
                height: kDefaultPadding,
              ),

              Text("Hirer Name: ${widget.laborHiring.hirerName}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),

              SizedBox(
                height: kDefaultPadding,
              ),
              Text("Hiring For: ${widget.laborHiring.hiringType}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),

              SizedBox(
                height: kDefaultPadding,
              ),
              Text("Hirer locality: ${widget.laborHiring.hirerLocality}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),

              Text("Hirer State: ${widget.laborHiring.hirerState}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text("Date Range:${widget.laborHiring.Startdate} to ${widget.laborHiring.Enddate}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),

              widget.laborHiring.contractLabor?widget.laborHiring.isLaborPaymentDone?HeaderLabel(
                headerText: "Payment Rs 300 Done Successfuly",
              ):HeaderLabel(
                headerText: "Please Sign the contract by Paying the Amount",
              ):HeaderLabel(
                headerText: "No Contract Sign request by Service Provider",
              ),

              SizedBox(
                height: kDefaultPadding,
              ),

              widget.laborHiring.contractLabor?widget.laborHiring.isLaborPaymentDone?
              Text("Payment Rs 300 Done Successfuly",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ):Text("Advance Amount: 300",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ):Container(),

            ]
        ),
      ):Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              HeaderLabel(
                headerText: "Service Details",
              ),

              SizedBox(
                height: kDefaultPadding,
              ),

              Text("Hirer Name: ${widget.laborHiring.hirerName}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),

              SizedBox(
                height: kDefaultPadding,
              ),
              Text("Hiring For: ${widget.laborHiring.hiringType}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),

              SizedBox(
                height: kDefaultPadding,
              ),
              Text("Hirer locality: ${widget.laborHiring.hirerLocality}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),

              Text("Hirer State: ${widget.laborHiring.hirerState}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text("Date Range:${widget.laborHiring.Startdate} to ${widget.laborHiring.Enddate}",
                style: TextStyle (
                    color: kLightColor,
                    fontSize: 18
                ),
              ),


              SizedBox(
                height: kDefaultPadding,
              ),



            ]
        ),
      ),
    );
  }
}