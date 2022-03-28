import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/screens/editService/components/edit_service_form.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  Service service;
  Body({required this.service});
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [EditServiceForm(service: widget.service)])
            ])));
  }
}
