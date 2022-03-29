import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saloon_app/screens/addAppointments/components/add_appointment_form.dart';


import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
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
                  children: [AddAppointmentForm()])
            ])));
  }
}
