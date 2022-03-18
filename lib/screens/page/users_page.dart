import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/widget/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => UsersProvider(),
    child: Scaffold(
      body: Consumer<UsersProvider>(
        builder: (context, usersProvider, _) => ListViewWidget(
          usersProvider: usersProvider,
        ),
      ),
    ),
  );
}