import 'package:flutter/material.dart';

class logged_in_user_provider extends ChangeNotifier {
  String useremail = "";

  void set_user_email_for_provider(String x) {
    useremail = x;
    notifyListeners();
  }

  String get_user_email_from_provider() {
    return useremail;
  }
}