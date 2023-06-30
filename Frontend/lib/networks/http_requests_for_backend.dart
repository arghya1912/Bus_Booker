import 'dart:convert';
import 'package:bus_book/constants.dart';
import 'package:bus_book/providers/bus_name_card_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:bus_book/globals.dart' ;
import 'package:bus_book/models/bus_name_cards_with_login.dart';
import 'package:provider/provider.dart';

int getWeekday(String dateString) {
  DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);
  int weekdayNumber = date.weekday;
  int weekday = (weekdayNumber + 6) % 7 + 1; // convert weekday number to 1-7 range
  return weekday;
}

class BusRoute {
  String arrivalTime;
  String busName;
  String departureTime;
  int seatsAvailable;
  String date;
  int busId;

  BusRoute({
    required this.arrivalTime,
    required this.busName,
    required this.departureTime,
    required this.seatsAvailable,
    required this.date,
    required this.busId
  });

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      arrivalTime: json['arrival_time'],
      busName: json['bus_name'],
      departureTime: json['departure_time'],
      seatsAvailable: json['seats_available'],
      date: json['date'],
      busId: json['bus_id']
    );
  }
}

class BusRoutes {
  List<BusRoute> busRoutes;

  BusRoutes({required this.busRoutes});

  factory BusRoutes.fromJson(Map<String, dynamic> json) {
    return BusRoutes(
      busRoutes: List<BusRoute>.from(
          json['bus_routes'].map((route) => BusRoute.fromJson(route))),
    );
  }
}


void postRequest(String email, String password) async {
  var url = Uri.parse(base_url + 'signup/' + email);
  var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
  var response = await http.post(url, headers: headers, body: json.encode({'email': email, 'password': password}));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    // do something with the response
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<int> check_if_account_exists(String email, String password) async {
  var url = Uri.parse(base_url + 'check/' + email + '?' + 'password=' + password);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    var emails = jsonResponse['email'];
    var pass = jsonResponse['password'];
    print(pass);
    if(emails == true) {
      if(pass == true)
          return 0;
    }
    if(emails == true) {
      if(pass == false)
          return 1;
    }
    if(emails == false)
    return 2;
    //print(emails);
  } 
  else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return 3;
}

void deleteRequest(int id) async {
  var url = Uri.parse(base_url + 'signup/' + id.toString());
  var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
  var response = await http.delete(url, headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    // do something with the response
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

void add_booking_to_bookings_table(int user_id, int bus_id, String source_city, String destination_city, int no_of_tickets_booked, String date) async{
  var url = Uri.parse(base_url + 'bookings');
  var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
  var response = await http.post(url, headers: headers, 
                body: json.encode(
                  {'user_id': user_id, 'bus_id': bus_id, 'source_city': source_city, 
                      'destination_city': destination_city, 'no_of_tickets_booked': no_of_tickets_booked, 'date': date}));
  
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    print("###########################################################");
    print(jsonResponse);  
    // do something with the response
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

void add_booking_to_bookings_with_date_table(int booking_id, int bus_id, int booked_seats, String booking_date) async {
  var url = Uri.parse(base_url + 'booking_with_date');
  var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
  var response = await http.post(url, headers: headers, 
                body: json.encode(
                  {'booking_id': booking_id, 'bus_id': bus_id, 'booked_seats': booked_seats, 
                      'booking_date': booking_date}));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    // do something with the response
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}


Future<String> fetch_user_id(String email) async {
  var url = Uri.parse(base_url + email);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if(jsonResponse.containsKey('user_id'))
    return (jsonResponse['user_id'][0].toString());
    else return "-1";
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return "";
  }
}

Future<String> fetch_booking_id() async {
  var url = Uri.parse(base_url + 'fetch_booking_id');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if(jsonResponse.containsKey('booking_id'))
    return (jsonResponse['booking_id'][0].toString());
    else return "-1";
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return "";
  }
}

Future<String> fetch_user_password(String email) async {
  var url = Uri.parse(base_url + 'fetch_password/' + email);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    if (jsonResponse.containsKey('password')) {
      var passwordArray = jsonResponse['password'];
      if (passwordArray is String) {
        var password = passwordArray.toString();
        //print(password);
        return password;
      } else if (passwordArray is List && passwordArray.isNotEmpty) {
        var password = passwordArray[0].toString();
        //print(password);
        return password;
      }
    }
    print('Error: password not found in response');
    return "-1";
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return "-1";
  }
}

Future<String> fetch_bus_name(int bus_id) async {
  var url = Uri.parse(base_url + 'fetch_bus_name/' + bus_id.toString());
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if(jsonResponse.containsKey('bus_name'))
    return (jsonResponse['bus_name'][0].toString());
    else return "-1";
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return "";
  }
}

Future<double> fetch_rating(int bus_id) async {
  var url = Uri.parse(base_url + 'fetch_rating/' + bus_id.toString());
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if(jsonResponse.containsKey('rating'))
    return (jsonResponse['rating'][0]);
    else return -1.0;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return -1.0;
  }
}

Future<void> updateRating(int busId, double rating) async {
  final url = Uri.parse(base_url + '/update_rating/' + busId.toString() + '/' + rating.toString());
  final response = await http.put(url);

  if (response.statusCode == 200) {
    print('Rating updated successfully');
  } else {
    print('Failed to update rating');
  }
}


void add_already_rated(int booking_id, int is_booking_id_already_rated) async {
  var url = Uri.parse(base_url + 'add_already_rated');
  var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
  var response = await http.post(url, headers: headers, 
                body: json.encode(
                  {'booking_id': booking_id, 'is_booking_id_already_rated': is_booking_id_already_rated}));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    print("Hello");
    // do something with the response
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<bool> check_if_rated(int bookingId) async {
  /*print(busId);
  print(rating);*/
  final url = Uri.parse(base_url + '/is_already_rated/' + bookingId.toString());
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if(jsonResponse.containsKey('is_already_rated') && jsonResponse['is_already_rated'][0] == '1')
    return true;
    else return false;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}

void delete_booking(int booking_id) async {
  var url = Uri.parse(base_url + 'delete_booking/' + booking_id.toString());
  var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
  var response = await http.delete(url, headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    // do something with the response
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

void delete_bus_seating_booking_date(int booking_id) async {
  var url = Uri.parse(base_url + 'delete_booking_with_date/' + booking_id.toString());
  var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
  var response = await http.delete(url, headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    // do something with the response
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}



Future<String> discount_percent(String coupon_code) async {
  var url = Uri.parse(base_url + 'check_if_coupon_code_exists/' + coupon_code);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    
    if (jsonResponse is List && jsonResponse.length > 0) {
      // Extract discount_percentage from the jsonResponse
      String discountPercentage = jsonResponse[0]['discount_percentage'].toString();
      return discountPercentage;
    }
  }
  
  return "-1";
}




Future<String> min_amount(String coupon_code) async {
  var url = Uri.parse(base_url + 'check_if_coupon_code_exists/' + coupon_code);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);

    if (jsonResponse is List && jsonResponse.length > 0) {
      // Extract discount_percentage from the jsonResponse
      String discountPercentage = jsonResponse[0]['min_amount_to_be_spent'].toString();
      return discountPercentage;
    }
  }
  return "-1";
}