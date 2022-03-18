import 'package:cloud_firestore/cloud_firestore.dart';

class Specialist {
  static const FIRSTNAME = "firstName";
  // static const LASTNAME = "lastName";
  // static const PHONENUMBER = "phoneNumber";
  // static const ADDRESS = "address";

  late String _firstName;

  set firstName(String value) {
    _firstName = value;
  } // late String _lastName;
  // late String _phoneNumber;
  // late String _address;
  // late String _avatar;

  String get firstName => _firstName;
  // String get lastName => _lastName;
  // String get address => _address;
  // String get phoneNumber => _phoneNumber;
  // String get avatar => _avatar;

  Specialist();

  Specialist.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _firstName = data[FIRSTNAME];
    // _lastName = data[LASTNAME];
    // _address = data[ADDRESS];
    // _phoneNumber = data[PHONENUMBER];
    // _avatar = data[AVATAR];
  }
}
