import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/models/appointment.dart';
import 'package:saloon_app/screens/editAppointments/components/body.dart';

import 'package:saloon_app/size_config.dart';

class EditAppointmentScreen extends StatelessWidget {
  static String routeName = "/appointments/edit";

  const EditAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as AppointmentDetailsArguments;
    return Scaffold(
      body: Body(
        appointment: arguments.appointment,
      ),
      appBar: AppBar(
        title: Text("Edit Appointment"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.appointments),
    );
  }
}

class AppointmentDetailsArguments {
  final Appointment appointment;
  AppointmentDetailsArguments({required this.appointment});
}
