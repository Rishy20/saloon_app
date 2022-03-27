import 'package:flutter/material.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/services/specialist.dart';

class SpecialistsProvider with ChangeNotifier {
  List<Specialist> _allSpecialists = [];
  SpecialistService _specialistService = SpecialistService();

  SpecialistsProvider() {
    _getAllSpecialists();
  }

//  getter
  List<Specialist> get allSpecialists => _allSpecialists;

//  methods
  void _getAllSpecialists() async {
    _allSpecialists = await _specialistService.getAllSpecialists();
    notifyListeners();
  }
}
