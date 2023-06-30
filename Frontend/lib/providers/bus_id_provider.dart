import 'package:flutter/material.dart';

class bus_id_provider extends ChangeNotifier {
  int bus_id = 0;

  void set_bus_id_for_provider(int x) {
    bus_id = x;
    notifyListeners();
  }

  int get_bus_id_from_provider() {
    return bus_id;
  }
}