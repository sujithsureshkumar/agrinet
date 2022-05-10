import 'package:flutter/material.dart';

Widget customCard(String title, String spots, icon,Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple[400],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/Required%20files%2Fbanner2.jpg?alt=media&token=9a215c7b-6fde-4def-b988-c6e985c203cb"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                icon,
                size: 30.0,
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    spots,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}