import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/addAppointments/components/body.dart';

class AddAppointmentScreen extends StatelessWidget {
  static String routeName = "/appointments/add";

  const AddAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: Text("Book Appointment"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.appointments),
    );
  }
}
