import 'package:flutter/material.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/services/service.dart';

class ServicesProvider with ChangeNotifier {
  List<Service> _allServices = [];
  ServiceService _serviceService = ServiceService();

  ServicesProvider() {
    _getAllServices();
  }

//  getter
  List<Service> get allServices => _allServices;

//  methods
  void _getAllServices() async {
    _allServices = await _serviceService.getAllServices();
    notifyListeners();
  }
}
