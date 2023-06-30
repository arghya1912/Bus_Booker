import 'package:shared_preferences/shared_preferences.dart';

//String useremail = "";
class sharedPref {
  static void set_user(String email) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('USER', email);
  }

  static Future<String> get_user() async{
    var prefs = await SharedPreferences.getInstance();
    String user_email = prefs.getString('USER') ?? "";
    return user_email;
  }
}

class bus_variables {
  String bus_name = "";
  String departure_time = "";
  String arrival_time = "";
  int seats_available = 0;
  
  void set_bus_name(String name) {
    bus_name = name;
  }
  
}