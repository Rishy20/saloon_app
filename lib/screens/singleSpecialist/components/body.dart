import 'package:flutter/material.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/specialist.dart';

class Body extends StatelessWidget {
  Body({required this.specialist}) {}

  Specialist specialist = Specialist();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Image.network(
              specialist.image,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12),
            child: Text("Name",
                style: TextStyle(fontSize: 14, color: Colors.white60)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                "${specialist.firstName} ${specialist.lastName}",
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12),
            child: Text("Designation",
                style: TextStyle(fontSize: 14, color: Colors.white60)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                specialist.designation,
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12),
            child: Text("Contact",
                style: TextStyle(fontSize: 14, color: Colors.white60)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16),
              child: Text(
                specialist.contact,
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
    );
  }
}
