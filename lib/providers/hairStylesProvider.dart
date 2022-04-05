import 'package:flutter/material.dart';
import 'package:saloon_app/models/hairStyles.dart';
import 'package:saloon_app/services/hairStyles.dart';

class HairStylesProvider with ChangeNotifier {
  List<HairStyles> _allHairStyles = [];
  HairStylesService _hairStylesService = HairStylesService();

  HairStylesProvider() {
    _getAllHairStyles();
  }

//  getter
  List<HairStyles> get allHairStyles => _allHairStyles;

//  methods
  void _getAllHairStyles() async {
    _allHairStyles = await _hairStylesService.getAllHairStyles();
    notifyListeners();
  }
}
