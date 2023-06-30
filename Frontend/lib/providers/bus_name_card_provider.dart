import 'package:flutter/material.dart';

class bus_name_card_provider extends ChangeNotifier {
  String date = "";

  void set_date_provider(String x) {
    date = x;
    notifyListeners();
  }

  String get_date_provider() {
    return date;
  }
}