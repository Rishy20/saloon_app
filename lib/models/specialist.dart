import 'package:cloud_firestore/cloud_firestore.dart';

class Specialist {
  static const ID = "id";
  static const FIRSTNAME = "firstName";
  static const LASTNAME = "lastName";
  static const CONTACT = "contact";
  static const DESIGNATION = "designation";
  static const IMAGE = "image";

  late String _id;
  late String _firstName;
  late String _lastName;
  late String _contact;
  late String _designation;
  late String _image;

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set contact(String value) {
    _contact = value;
  }

  set designation(String value) {
    _designation = value;
  }

  set image(String value) {
    _image = value;
  }

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get contact => _contact;
  String get designation => _designation;
  String get image => _image;

  Specialist();

  Specialist.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _id = snapshot.id;
    _firstName = data[FIRSTNAME];
    _lastName = data[LASTNAME];
    _contact = data[CONTACT];
    _designation = data[DESIGNATION];
    _image = data[IMAGE];
  }
}
