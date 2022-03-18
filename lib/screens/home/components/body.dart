import 'package:flutter/material.dart';
import 'package:saloon_app/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            "Specialists",
            style: headingStyle,
          ),
        ),
      ),
    );
  }
}
