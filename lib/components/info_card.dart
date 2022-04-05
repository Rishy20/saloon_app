import 'package:flutter/material.dart';

import '../constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.title, required this.count, required this.click})
      : super(key: key);
  final String title;
  final String count;
    final GestureTapCallback click;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Card(
        elevation: 3,
        color: kSecondaryColor,
        margin: EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                count,
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      ),
    );
  }
}
