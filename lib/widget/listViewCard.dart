import 'package:flutter/material.dart';

class ListViewCard extends StatelessWidget {
  final Function onTap;
  final String name;
  final String image;
  ListViewCard({this.name,this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(image),
          ),
          title: Text(name),
          subtitle: Text("Name"),
          trailing: const Icon(Icons.arrow_forward),
          onTap: onTap,
              /*(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=>ProfilePage(),
            ));
          },*/

        )
    );
  }
}