import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saloon_app/models/specialist.dart';

class SpecialistService {
  CollectionReference specialists =
      FirebaseFirestore.instance.collection('specialists');

  Future<List<Specialist>> getAllSpecialists() =>
      specialists.get().then((QuerySnapshot snap) {
        List<Specialist> allSpecialists = [];
        snap.docs.forEach((snapshot) {
          if (snapshot.exists) {
            allSpecialists.add(Specialist.fromSnapshot(snapshot));
          } else {
            print("Snapshots doesn't exist");
          }
        });
        return allSpecialists;
      });
  Future<void> addSpecialist(Specialist sp) {
    Map<String, dynamic> specialist = {'firstName': sp.firstName};

    return specialists.add(specialist).then((value) {
      print('User ${value.id} added successfully');
    }).catchError((error) => print("Failed to add Specialist: $error"));
  }
}
