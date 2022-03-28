import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  static const ID = "id";
  static const NAME = "name";
  static const PRICE = "price";
  static const IMAGE = "image";

  late String _id;
  late String _name;
  late String _price;
  late String _image;

  set name(String value) {
    _name = value;
  }

  set price(String value) {
    _price = value;
  }

  set image(String value) {
    _image = value;
  }

  String get id => _id;
  String get name => _name;
  String get price => _price;
  String get image => _image;

  Service();

  Service.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _id = snapshot.id;
    _name = data[NAME];
    _price = data[price];
    _image = data[IMAGE];
  }
}
