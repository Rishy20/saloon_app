import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  static const ID = "id";
  static const EMAIL = "email";
  static const PASSWORD = "password";
  static const FIRSTNAME = "firstName";
  static const LASTNAME = "lastName";
  static const PHONENUMBER = "phoneNumber";
  static const ADDRESS = "address";
  static const AVATAR = "avatar";
  static const TYPE = "type";

  late String _id;
  late String _email;
  late String _password;
  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _address;
  late String _avatar;
  late String _type;

  set id(String value) {
    _id = value;
  }

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set address(String value) {
    _address = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set avatar(String value) {
    _avatar = value;
  }

  set type(String value) {
    _type = value;
  }

  String get id => _id;
  String get email => _email;
  String get password => _password;
  String get lastName => _lastName;
  String get firstName => _firstName;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get avatar => _avatar;
  String get type => _type;

  User();

  User.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _id = snapshot.id;
    _email = data[EMAIL];
    _password = data[PASSWORD];
    _lastName = data[LASTNAME];
    _firstName = data[FIRSTNAME];
    _address = data[ADDRESS];
    _phoneNumber = data[PHONENUMBER];
    _avatar = data[AVATAR];
    _type = data[TYPE];
  }
}
