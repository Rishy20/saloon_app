import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saloon_app/models/appointment.dart';

class AppointmentService {
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

  Future<List<Appointment>> getAllAppointments() =>
      appointments.get().then((QuerySnapshot snap) {
        List<Appointment> allAppointments = [];
        snap.docs.forEach((snapshot) {
          if (snapshot.exists) {
            allAppointments.add(Appointment.fromSnapshot(snapshot));
          } else {
            print("Snapshots doesn't exist");
          }
        });

        return allAppointments;
      });
  Future<void> addAppointment(Appointment a) {
    Map<String, dynamic> appointment = {
      'specialist': a.specialist,
      'date': a.date,
      'service': a.service,
      'slot': a.slot
    };
    return appointments.add(appointment).then((value) {
      print('Appointment ${value.id} added successfully');
    }).catchError((error) => print("Failed to add Appointment: $error"));
  }

  Future<void> updateAppointment(Appointment a) {
    Map<String, dynamic> appointment = {
      'specialist': a.specialist,
      'date': a.date,
      'service': a.service,
      'slot': a.slot
    };
    return appointments.doc(a.id).update(appointment).then((value) {
      print('Appointment ${a.id} updated successfully');
    }).catchError((error) => print("Failed to update Appointment: $error"));
  }

  Future<void> removeAppointment(String id) {
    return appointments.doc(id).delete().then((value) {
      print('Appointment ${id} deleted successfully');
    }).catchError((error) => print("Failed to delete Appointment: $error"));
  }
}
