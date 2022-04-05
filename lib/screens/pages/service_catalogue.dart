import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/widget/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceCatalogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => UsersProvider(),

    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6d8000),
        title: Padding(
          padding: EdgeInsets.only(top: 4.0),
          child:Center(
              child:Text("Services")
          ),
        ),
      ),
      body: Consumer<UsersProvider>(
        builder: (context, usersProvider, _) => ListViewWidget(
          usersProvider: usersProvider,
        ),
      ),
    ),
  );
}