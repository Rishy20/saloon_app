import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/components/info_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/screens/allAppointments/all_appointment_screen.dart';
import 'package:saloon_app/screens/allHairStyles/all_hairstyle_screen.dart';
import 'package:saloon_app/screens/allServices/all_services_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/allUsers/all_users_screen.dart';
import 'package:saloon_app/services/appointment.dart';
import 'package:saloon_app/services/hairStyles.dart';
import 'package:saloon_app/services/service.dart';
import 'package:saloon_app/services/specialist.dart';
import 'package:saloon_app/services/user.dart';

import '../../../components/topbar.dart';

class Body extends StatelessWidget {


  SpecialistService specialistService = SpecialistService();
  HairStylesService hairStylesService = HairStylesService();
  UserService userService = UserService();
  AppointmentService appointmentService = AppointmentService();
  ServiceService serviceService = ServiceService();

  int specialistCount = 0;
  int userCount = 0;
  int serviceCount = 0;
  int hairStylesCount = 0;
  int appointmentCount = 0;

  var count = [];
  Future<bool> getAllCount () async {
    specialistCount =  await specialistService.getSpecialistCount();
    userCount =  await userService.getUserCount();
    serviceCount =  await serviceService.getServiceCount();
    hairStylesCount = await hairStylesService.getHairStylesCount();
    appointmentCount = await appointmentService.getAppointmentCount();



    count = [
    {
      "name":"Users",
      "count":userCount,
      "route":AllUsersScreen.routeName
    },
    {
      "name":"Specialists",
      "count":specialistCount,
      "route":AllSpecialistScreen.routeName
    },
    {
      "name":"Services",
      "count":serviceCount,
      "route":AllServiceScreen.routeName
    },
    {
      "name":"Hair Styles",
      "count":hairStylesCount,
      "route":AllHairStylesScreen.routeName
    },
     {
      "name":"Appointments",
      "count":appointmentCount,
      "route":AllAppointmentsScreen.routeName
    }

  ];
    return true;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllCount(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          } else {
    return Column(children: [
      TopBar(),
      Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: count.length,
            itemBuilder: (context, index) {
              return InfoCard(
                title: count[index]["name"].toString(), 
                count: count[index]["count"].toString(),
                click: () => {
                        Navigator.pushNamed(
                            context, count[index]["route"])
                      },
                );
            }),
      )
    ]);
          }});
  }
}
