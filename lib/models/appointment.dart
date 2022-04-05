import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  static const ID = "id";
  static const DATE = "date";
  static const SPECIALIST = "specialist";
  static const SERVICE = "service";
  static const SLOT = "slot";
  static const USERID = "userId";

  late String _id;
  late String _date;
  late String _specialist;
  late List<dynamic> _service;
  late String _slot;
  late String _userId;

  set date(String value) {
    _date = value;
  }

  set specialist(String value) {
    _specialist = value;
  }

  set service(List<dynamic> value) {
    _service = value;
  }

  set slot(String value) {
    _slot = value;
  }

  set userId(String value) {
    _userId = value;
  }

  String get id => _id;
  String get date => _date;
  String get specialist => _specialist;
  List<dynamic> get service => _service;
  String get slot => _slot;
  String get userId => _userId;

  Appointment();

  Appointment.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _id = snapshot.id;
    _date = data[DATE];
    _specialist = data[SPECIALIST];
    _service = data[SERVICE];
    _slot = data[SLOT];
    _userId = data[USERID];
  }
}
