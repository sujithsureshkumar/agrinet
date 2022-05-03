import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../providers/services_provider.dart';

class ServiceCatalogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: DefaultAppBar(title: "Services"),
      body: ListViewWidget()
    );
  }
}