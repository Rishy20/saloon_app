import 'package:flutter/material.dart';
import 'package:saloon_app/constants.dart';

class HomeItemCard extends StatelessWidget {
  const HomeItemCard({
    Key? key,
    required this.image,
    required this.title
  }) : super(key: key);

  final String image;
  final  String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Image.network(
            image,
            width: 120,
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kSecondaryColor),
            ),
          )
        ],
      ),
    );
  }
}
