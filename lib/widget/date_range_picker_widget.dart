import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/widget/HeaderWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'buttonWidget.dart';
import 'defaultButton.dart';

class DateRangePickerWidget extends StatefulWidget {
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange dateRange;
  //Timestamp startTimeStamp,endTimeStamp;


  String getFrom() {
    ServicesProvider servicesProvider = Provider.of<ServicesProvider >(context, listen: false);
    if (dateRange == null) {
      return 'From';
    } else {
      servicesProvider.startTimeStamp = Timestamp.fromDate(dateRange.start);
      return DateFormat('MM/dd/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    ServicesProvider servicesProvider = Provider.of<ServicesProvider >(context, listen: false);
    if (dateRange == null) {
      return 'Until';
    } else {
      servicesProvider.endTimeStamp = Timestamp.fromDate(dateRange.end);
      return DateFormat('MM/dd/yyyy').format(dateRange.end);
    }
  }

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: DefaultButton(
          btnText: getFrom(),
          onPressed: () => pickDateRange(context),
          ratio: 0.5,
          color: kAccentColor,
          textColor:kLightColor,
        ),
      ),
      const SizedBox(width: 8),
      Icon(Icons.arrow_forward, color: Colors.red),
      const SizedBox(width: 8),
      Expanded(
        child: DefaultButton(
          btnText: getUntil(),
          onPressed: () => pickDateRange(context),
          ratio: 0.5,
          color: kAccentColor,
          textColor:kLightColor,
        ),
      ),
    ],
  );

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }
}