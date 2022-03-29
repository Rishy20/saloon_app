import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/appointment_card.dart';
import 'package:saloon_app/components/item_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/appointment.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editAppointments/edit_appointment_screen.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/services/appointment.dart';
import 'package:saloon_app/services/specialist.dart';
import 'package:saloon_app/size_config.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Appointment>> allAppointments;

  AppointmentService appointmentService = AppointmentService();
  List<Appointment> appointments = [];
  Future<List<Appointment>> getAllAppointments() async {
    appointments = await appointmentService.getAllAppointments();
    return appointments;
  }

  @override
  initState() {
    super.initState();
    allAppointments = getAllAppointments();
  }

  @override
  Widget build(BuildContext context) {
    SpecialistsProvider specialistsProvider =
        Provider.of<SpecialistsProvider>(context);
    return FutureBuilder(
        future: getAllAppointments(),
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 2 / 1.1),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Specialist sp = Specialist();
                    for (var specialist in specialistsProvider.allSpecialists) {
                      if (specialist.id == snapshot.data[index].specialist) {
                        sp = specialist;
                      }
                    }
                    String specialistName = "${sp.firstName} ${sp.lastName}";
                    return GestureDetector(
                        onTap: () => {
                              Navigator.pushNamed(
                                  context, EditAppointmentScreen.routeName,
                                  arguments: AppointmentDetailsArguments(
                                      appointment: snapshot.data[index])),
                            },
                        child: AppointmentCard(
                          ap: snapshot.data[index],
                          specialistName: specialistName,
                        ));
                  }),
            );
          }
        });
  }

  showAlertDialog(BuildContext context, id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        // specialistService.removeSpecialist(id);
        Navigator.pushNamed(context, AllSpecialistScreen.routeName);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Do you want to delete?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
