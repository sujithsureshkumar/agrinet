import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../providers/services_provider.dart';
import '../../widget/catalogueCard.dart';

class WishlistCatalog extends StatefulWidget {
  @override
  _WishlistCatalogState createState() => _WishlistCatalogState();
}

class _WishlistCatalogState extends State<WishlistCatalog> {
  @override
  Widget build(BuildContext context) {
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(
        context, listen: false);
    final user = Provider.of<Users>(context);
    servicesProvider.fetchFirebaseWishlist(user.uid);
    servicesProvider.getserviceSnapShotForWishlist();
    return Scaffold(
        appBar:DefaultAppBar(title: "Favourite"),
        body: Consumer<ServicesProvider>(
            builder:(context, servicesProvider, _) {
              return Scaffold(
                backgroundColor: Colors.grey[900],
                body: ListView(
                  padding: EdgeInsets.all(12),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: <Widget>[
                          Column(
                              children: servicesProvider.serviceList.map((p) {
                                return CatalogueCard(service: p,user: user);
                              }).toList()
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
    );
  }
}