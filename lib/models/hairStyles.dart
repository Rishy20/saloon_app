import 'package:cloud_firestore/cloud_firestore.dart';

class HairStyles {
  static const ID = "id";
  static const STYLE = "style";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const GENDER = "gender";

  late String _id;
  late String _style;
  late List<dynamic> _image;
  late String _description;
  late String _gender;


  set style(String value) {
    _style = value;
  }

  set image(List<dynamic> value) {
    _image = value;
  }

  set description(String value) {
    _description = value;
  }

  set gender(String value) {
    _gender = value;
  }

  String get id => _id;
  String get style => _style;
  List<dynamic> get image => _image;
  String get description => _description;
  String get gender => _gender;

  HairStyles();

  HairStyles.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    _id = snapshot.id;
    _style = data[STYLE];
    _image = data[IMAGE];
    _description = data[DESCRIPTION];
    _gender = data[GENDER];
  }
}
