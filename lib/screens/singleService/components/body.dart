import 'package:flutter/material.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/models/specialist.dart';

class Body extends StatelessWidget {
  Body({required this.service}) {}

  Service service = Service();

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
              service.image,
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
                service.name,
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12),
            child: Text("Price",
                style: TextStyle(fontSize: 14, color: Colors.white60)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                "Rs.${service.price}",
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12),
            child: Text("Description",
                style: TextStyle(fontSize: 14, color: Colors.white60)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16),
              child: Text(
                service.description,
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
    );
  }
}
