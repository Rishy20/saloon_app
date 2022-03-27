import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  static const NAME = "name";

  late String _name;

  set name(String value) {
    _name = value;
  }
  // late String _avatar;

  String get name => _name;
  // String get avatar => _avatar;

  Service();

  Service.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _name = data[NAME];
    // _avatar = data[AVATAR];
  }
}
