import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/screens/addAppointments/add_appointment_screen.dart';
import 'package:saloon_app/screens/allAppointments/components/body.dart';

class AllAppointmentsScreen extends StatelessWidget {
  static String routeName = "/appointments";

  const AllAppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginInfoProvider loginInfoProvider =
        Provider.of<LoginInfoProvider>(context);
    var loginInfo = loginInfoProvider.loginInfo;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        centerTitle: true,
        actions: [
          loginInfo != null
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: IconButton(
                      onPressed: () => {
                            Navigator.pushNamed(
                                context, AddAppointmentScreen.routeName)
                          },
                      icon: Icon(Icons.add_circle,
                          color: kSecondaryColor, size: 30)))
              : Container()
        ],
      ),
      body: Body(),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.appointments),
    );
  }
}
