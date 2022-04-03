import 'package:cloud_firestore/cloud_firestore.dart';

class HairStyles {
  static const ID = "id";
  static const STYLE = "style";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const PRICE = "price";

  late String _id;
  late String _style;
  late String _image;
  late String _description;
  late String _price;

  set style(String value) {
    _style = value;
  }

  set image(String value) {
    _image = value;
  }

  set description(String value) {
    _description = value;
  }

  set price(String value) {
    _price = value;
  }

  String get id => _id;
  String get style => _style;
  String get image => _image;
  String get description => _description;
  String get price => _price;

  HairStyles();

  HairStyles.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _id = snapshot.id;
    _style = data[STYLE];
    _image = data[IMAGE];
    _description = data[DESCRIPTION];
    _price = data[PRICE];
  }
}
