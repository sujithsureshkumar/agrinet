import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentHistoryCard extends StatefulWidget {
  final Payment payment;

  PaymentHistoryCard ({Key key,this.payment}): super(key: key);

  @override
  _PaymentHistoryCardState createState() => _PaymentHistoryCardState();
}

class _PaymentHistoryCardState extends State<PaymentHistoryCard> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (size.width - 40) * 0.7,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kDarkColor.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.account_balance_wallet,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: (size.width - 90) * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //'name',
                          "to "+widget.payment.toName,
                          style: TextStyle(
                              fontSize: 15,
                              color: kDarkColor,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          DateFormat.yMMMd().format(widget.payment.createdOn),
                          style: TextStyle(
                              fontSize: 12,
                              color: kDarkColor.withOpacity(0.5),
                              fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: (size.width - 40) * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.payment.price + " Rs",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.green),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 65, top: 8),
          child: Divider(
            thickness: 0.8,
          ),
        )
      ],
    );
  }
}