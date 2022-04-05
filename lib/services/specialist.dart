import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
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
    Map<String, dynamic> specialist = {'firstName': sp.firstName, 'lastName':sp.lastName,'contact':sp.contact,'designation':sp.designation,'image':sp.image};
    return specialists.add(specialist).then((value) {
      print('Specialist ${value.id} added successfully');
    }).catchError((error) => print("Failed to add Specialist: $error"));
  }

    Future<void> updateSpecialist(Specialist sp) {
    Map<String, dynamic> specialist = {'firstName': sp.firstName, 'lastName':sp.lastName,'contact':sp.contact,'designation':sp.designation,'image':sp.image};
    return specialists.doc(sp.id).update(specialist).then((value) {
      print('Specialist ${sp.id} updated successfully');
    }).catchError((error) => print("Failed to update Specialist: $error"));
  }

   Future<void> removeSpecialist(String id) {
      return specialists.doc(id).delete().then((value) {
      print('Specialist ${id} deleted successfully');
    }).catchError((error) => print("Failed to delete Specialist: $error"));
  }

  Future uploadSpecialistImage(File imageFile) async {
    final _firebaseStorage = FirebaseStorage.instance;
    String fileName = basename(imageFile.path);

    try {
      var snapshot = await _firebaseStorage
          .ref()
          .child('uploads/specialists/${fileName}')
          .putFile(imageFile);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
    } catch (e) {
      print('error occured');
    }
  }
  Future<int> getSpecialistCount() =>
      specialists.get().then((QuerySnapshot snap) {
        return snap.docs.length;
      });
}
