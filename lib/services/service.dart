import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> addService(Service sp) {
    Map<String, dynamic> service = {'name': sp.name};

    return services.add(service).then((value) {
      print('Service ${value.id} added successfully');
    }).catchError((error) => print("Failed to add Service: $error"));
  }
}
