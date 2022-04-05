import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saloon_app/models/appointment.dart';
import 'package:saloon_app/screens/addAppointments/components/add_appointment_form.dart';
import 'package:saloon_app/screens/editAppointments/components/edit_appointment_form.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  Appointment appointment;
  Body({required this.appointment});
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                EditAppointmentForm(appointment: widget.appointment)
              ])
            ])));
  }
}
