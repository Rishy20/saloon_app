import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  static const EMAIL = "email";
  static const PASSWORD = "password";
  static const FIRSTNAME = "firstName";
  static const LASTNAME = "lastName";
  static const PHONENUMBER = "phoneNumber";
  static const ADDRESS = "address";
  static const AVATAR = "avatar";

  late String _email;
  late String _password;
  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _address;
  late String _avatar;

  String get email => _email;
  String get password => _password;
  String get lastName => _lastName;
  String get firstName => _firstName;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get avatar => _avatar;

  User.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _email = data[EMAIL];
    _password = data[PASSWORD];
    _lastName = data[LASTNAME];
    _firstName = data[FIRSTNAME];
    _address = data[ADDRESS];
    _phoneNumber = data[PHONENUMBER];
    _avatar = data[AVATAR];
  }
}
