import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:saloon_app/models/service.dart';

class ServiceService {
  CollectionReference services =
      FirebaseFirestore.instance.collection('services');

  Future<List<Service>> getAllServices() =>
      services.get().then((QuerySnapshot snap) {
        List<Service> allServices = [];
        snap.docs.forEach((snapshot) {
          if (snapshot.exists) {
            allServices.add(Service.fromSnapshot(snapshot));
          } else {
            print("Snapshots doesn't exist");
          }
        });

        return allServices;
      });
  Future<void> addService(Service se) {
    Map<String, dynamic> service = {
      'name': se.name,
      'price': se.price,
      'image': se.image,
      'description': se.description
    };
    return services.add(service).then((value) {
      print('Service ${value.id} added successfully');
    }).catchError((error) => print("Failed to add Service: $error"));
  }

  Future<void> updateService(Service se) {
    Map<String, dynamic> service = {
      'name': se.name,
      'price': se.price,
      'image': se.image,
      'description': se.description
    };
    return services.doc(se.id).update(service).then((value) {
      print('Service ${se.id} updated successfully');
    }).catchError((error) => print("Failed to update Service: $error"));
  }

  Future<void> removeService(String id) {
    return services.doc(id).delete().then((value) {
      print('Service ${id} deleted successfully');
    }).catchError((error) => print("Failed to delete Service: $error"));
  }

  Future uploadServiceImage(File imageFile) async {
    final _firebaseStorage = FirebaseStorage.instance;
    String fileName = basename(imageFile.path);

    try {
      var snapshot = await _firebaseStorage
          .ref()
          .child('uploads/services/${fileName}')
          .putFile(imageFile);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('error occured');
    }
  }

  Future<int> getServiceCount() => services.get().then((QuerySnapshot snap) {
        return snap.docs.length;
      });
}
