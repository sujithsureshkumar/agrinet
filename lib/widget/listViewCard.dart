import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/screens/pages/editService.dart';
import 'package:flutter/material.dart';

class ListViewCard extends StatelessWidget {
  final Service service;
  ListViewCard({this.service});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(service.imageUrl[0]),
          ),
          title: Text(service.name),
          subtitle: Text("Name"),
          trailing: const Icon(Icons.arrow_forward),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
              builder: (context)=>EditService(service: service),
            ));
          },

        )
    );
  }
}