import 'dart:convert';
import 'package:bus_book/pages/offers.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;
import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/networks/http_requests_for_backend.dart';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/page_before_payement.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';

class Booking {
  final int bookingId;
  final int busId;
  final String sourceCity;
  final String destinationCity;
  final int numTickets;
  final String date;
  

  Booking({
    required this.bookingId,
    required this.busId,
    required this.sourceCity,
    required this.destinationCity,
    required this.numTickets,
    required this.date,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'],
      busId: json['bus_id'],
      sourceCity: json['source_city'],
      destinationCity: json['destination_city'],
      numTickets: json['no_of_tickets_booked'],
      date: json['date'],
    );
  }
}
String logged_in_user_email = "", userId = "";

//bool already_rated = false;

class my_bookings extends StatefulWidget {
  const my_bookings({super.key});

  @override
  State<my_bookings> createState() => _my_bookingsState();
}



class _my_bookingsState extends State<my_bookings> {
   List<Booking> _bookings = [];

  @override
  void initState() {
    super.initState();
    
    logged_in_user_email =  Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    _fetchBookings();
    if(this.mounted)
    setState(() {
      
    });
  }

  bool no_booking_for_the_user = false;

  Future<void> _fetchBookings() async {
    userId = await fetch_user_id(logged_in_user_email);
    //print(userId);
    if(this.mounted)
    setState(() {});


    var headers = {'Content-Type': 'application/json', 'User-Agent': 'Chrome/80.0.3987.132'};
    var url = Uri.parse(base_url + 'fetch_user_bookings/' + userId.toString());
    print(url);
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
        final responseBody = await response.body;
        //print(responseBody);
        if (responseBody == "-1") {
            // Handle the case where there are no results
            no_booking_for_the_user = true;
            if(this.mounted)
            setState(() {
              
            });
            print('No bookings found for user');
        } else {
            final jsonData = jsonDecode(responseBody);
            if (jsonData is List) {
                final data = jsonData as List<dynamic>;
                if(this.mounted)
                setState(() {
                    _bookings = data.map((json) => Booking.fromJson(json)).toList();
                });
            } else if (jsonData is Map<String, dynamic>) { // check if jsonData is a Map with String keys
                final booking = Booking.fromJson(jsonData);
                if(this.mounted)
                setState(() {
                    _bookings = [booking];
                });
            }
        }
    } else {
        // Handle error
        print('Error fetching bookings: ${response.statusCode}');
    }
}


String x = "";
String _busName = "";

int hashInteger(int value) {
  // Convert the integer to a string
  String stringValue = value.toString();

  // Create an MD5 hash object
  var md5Hasher = md5.convert(utf8.encode(stringValue));

  // Get the bytes of the hash
  List<int> hashBytes = md5Hasher.bytes;

  // Convert the bytes to a hexadecimal string
  String hexString = hashBytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

  // Convert the hexadecimal string to an integer
  int hashedValue = int.parse(hexString, radix: 16);

  // Return the hashed value as an integer
  return hashedValue;
}


Future<String> send_bus_name(int bus_id) async{
  return fetch_bus_name(int.parse(bus_id.toString())).then((value) {
    x = value;
    if(this.mounted)
    setState(() {
      
    });
    print(x);
    return x;
  });
}
Future<void> _loadBusName(int busId) async {
  String busName = await send_bus_name(busId);
  if(this.mounted)
  setState(() {
    _busName = busName;
  });
}

String username = "";
double user_rating = 0.0;
int index = 0;
  @override
  Widget build(BuildContext context) {
    
    logged_in_user_email = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    //print(logged_in_user_email);
    if(logged_in_user_email != "")
    username = logged_in_user_email.substring(0, logged_in_user_email.indexOf('@'));


    //final booking = _bookings[index];
    final dateFormat = DateFormat('dd-MM-yyyy');
    //final parsedBookingDate = dateFormat.parse(booking.date);*/
    List<DataRow> rows = [];

    for (int i = 0; i < _bookings.length; i++) {
        DataRow row = DataRow(cells: [
          DataCell(Text('${_bookings[i].bookingId}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 15))),


          DataCell(FutureBuilder<String>(
                      future: fetch_bus_name(_bookings[i].busId),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}' , style: GoogleFonts.openSans(color: Colors.white, fontSize: 15));
                          } else {
                            return Text('${snapshot.data}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 15));
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),),


          DataCell(Text("${_bookings[i].sourceCity}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15))),

          DataCell(Text("${_bookings[i].destinationCity}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15))),

          DataCell(Text("${_bookings[i].numTickets}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15))),

          DataCell(Text("${_bookings[i].date}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15))),


          DataCell(InkWell(
                    onTap: () async {
                      if (await check_if_rated((_bookings[i].bookingId)) == false) {
                        DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
                        DateTime date = DateFormat("dd-MM-yyyy").parse(_bookings[i].date);
                        bool isDateBeforeToday = date.isBefore(yesterday);

                        if(isDateBeforeToday == true) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Rate your journey"),
                            content: RatingBar.builder(
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemSize: 25,
                              onRatingUpdate: (rating) {
                                user_rating = rating;
                                
                              },
                            ),

                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  add_already_rated((_bookings[i].bookingId), 1);
                                  await updateRating(_bookings[i].busId, user_rating);
                                  if(this.mounted)
                                  setState(() {
                                    
                                  });
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                    msg: "RATED SUCCESSFULLY!", timeInSecForIosWeb: 6,
                                    textColor: Colors.black);
                                },
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.openSans(),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Advance Rating"),
                            content: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                children: [
                                  Text("You're rating the journey beforehand. The rating will be added once your trip will be completed"),
                                  SizedBox(height: 8,),
                                  Text("Rate below if you wish to proceed or wait till your trip is finished."),
                                  RatingBar.builder(
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemSize: 25,
                                    onRatingUpdate: (rating) {
                                      user_rating = rating;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  add_already_rated((_bookings[i].bookingId), 1);
                                  print(_bookings[i].bookingId);
                                  await updateRating(_bookings[i].busId, user_rating);
                                  if(this.mounted)
                                  setState(() {
                                    
                                  });
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                    msg: "ADVANCED RATED SUCCESSFULLY!", timeInSecForIosWeb: 6,
                                    textColor: Colors.black);
                                },
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.openSans(),
                                ),
                              )
                            ],
                          ),
                        );
                      }

                      } else {
                        Fluttertoast.showToast(
                          msg: "YOU HAVE ALREADY RATED!",
                          timeInSecForIosWeb: 5,
                          textColor: Colors.white,
                          webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))"
                        );
                      }
                    },
                    child: FutureBuilder<bool>(
                        future: check_if_rated((_bookings[i].bookingId)),
                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            bool alreadyRated = snapshot.data!;
                            return Text(
                              alreadyRated ? "Already Rated" : "Rate your Journey",
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),

                  ),),
                  DataCell(dateFormat.parse(_bookings[i].date).isAfter(DateTime.now()) || dateFormat.parse(_bookings[i].date).isAtSameMomentAs(DateTime.now())
                      ? ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(255, 61, 85, 1)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Do you wish to cancel the booking?"),
                                content: Text("Once cancelled, it can't be retrieved!"),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromRGBO(255, 61, 85, 1)
                                    ),
                                    onPressed: () async{
                                      //print("dhuklo ekhane");
                                      delete_booking((_bookings[i].bookingId));
                                      delete_bus_seating_booking_date((_bookings[i].bookingId));
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Home_with_login()));
                                      await Fluttertoast.showToast(
                                        msg: "YOUR BOOKING HAS BEEN CANCELLED!", timeInSecForIosWeb: 5,
                                        textColor: Colors.black);
                                        if(this.mounted)
                                      setState(() {
                                        
                                      });
                                      Navigator.pop(context);
                                    }, 
                                    child: Text("Cancel!"))
                                ],
                              ),
                            );
                        },
                          child: Text('Cancel Booking'),
                        )
                      : MouseRegion(
                        cursor: SystemMouseCursors.forbidden,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: Text("Not Possible", style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),),
                        )
                      )
                      
                      ),
                    ]);
                    rows.add(row);
                  }

    //print(booking); 

    if(MediaQuery.of(context).size.width > 900) 
    {
      return Sizer( builder: (context, orientation, deviceType) {
    return Scaffold(
      

      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", fit: BoxFit.cover,  stateMachines: ['State Machine 1'],)
                  ),
      
      
                  Positioned(
              top: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => Home_with_login()))),
                    child: Text(
                      "Bus Booker",
                      style: GoogleFonts.openSans(
                          color: Color.fromARGB(255, 200, 230, 255),
                          fontSize: 6.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  
                  Text("Welcome $username", style: GoogleFonts.openSans(color: Color.fromARGB(255, 200, 230, 255), 
                        fontSize: (MediaQuery.of(context).size.width) > 1200 ? 18 : 13),),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),

                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => my_bookings())),
                    child: Text("MY BOOKINGS", style: GoogleFonts.openSans(color: Color.fromARGB(255, 200, 230, 255), 
                                fontSize: (MediaQuery.of(context).size.width) > 1200 ? 18 : 13)),),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  
                  
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => offers())),
                    child: Text(
                      "OFFERS",
                      style: GoogleFonts.openSans(
                        color: Color.fromARGB(255, 200, 230, 255),
                        fontSize: (MediaQuery.of(context).size.width) > 1200 ? 18 : 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => contact_us())),
                    child: Text(
                      "CONTACT US",
                      style: GoogleFonts.openSans(
                        color: Color.fromARGB(255, 200, 230, 255),
                        fontSize: (MediaQuery.of(context).size.width) > 1200 ? 18 : 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 252, 232, 48),
                          elevation: 50,
                          minimumSize: Size(100, 50)),
                      onPressed: () => {
                        Provider.of<logged_in_user_provider>(context, listen: false).set_user_email_for_provider(""),
                        html.window.location.reload(),
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home_without_login()))},
                      child: Text(
                        "LOG OUT",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 3.sp,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),


              (no_booking_for_the_user == true) ?
              Column(
                children: [
                  SizedBox(height: 60,),
                  
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RiveAnimation.network(
                      "https://res.cloudinary.com/dvypswxcv/raw/upload/v1687548652/404_fkwie6.riv", stateMachines: ['State Machine 1'], 
                      )),

                      SizedBox(width: 10,),
                      Text("No Bookings found. :^(", style: GoogleFonts.openSans(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)
                ],
              )
              : Column(
                children: [
                  Container(width: MediaQuery.of(context).size.width,
                          height: 100,),


                  Container(
                    width: double.infinity,
                    
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dividerThickness: 5,
                        columns: [
                          DataColumn(label: Text("Booking ID", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                          DataColumn(label: Text("Bus Name", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                          DataColumn(label: Text("Source", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                          DataColumn(label: Text("Destination", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                          DataColumn(label: Text("Number of Tickets", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                          DataColumn(label: Text("Date", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                          DataColumn(label: Text("Rating Status", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                          DataColumn(label: Text("Cancel Status", style: GoogleFonts.openSans(color: Colors.white, fontSize: 22),)),
                        ], 
                        rows: rows
                        
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          
        ],
      ),
      
    );
    }
      );
 
  }
  else {
    return Scaffold(
      

      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", fit: BoxFit.cover,  stateMachines: ['State Machine 1'],)
                  ),
      
      
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => Home_with_login()))),
                            child: Text(
                              "Bus Booker",
                              style: GoogleFonts.openSans(
                                  color: Color.fromARGB(255, 200, 230, 255),
                                  fontSize: 7.sp,
                                      
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          
                          Text("Welcome $username", style: GoogleFonts.openSans(color: Color.fromARGB(255, 200, 230, 255), 
                                fontSize: 4.sp
                                    ),),
                    
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                    
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => my_bookings())),
                            child: Text("MY BOOKINGS", style: GoogleFonts.openSans(color: Color.fromARGB(255, 200, 230, 255), 
                            fontSize: 4.sp,
                                    ),),),
                    
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          
                          
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => offers())),
                            child: Text(
                              "OFFERS",
                              style: GoogleFonts.openSans(
                                color: Color.fromARGB(255, 200, 230, 255),
                                fontSize: 4.sp
                                    
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => contact_us())),
                            child: Text(
                              "CONTACT US",
                              style: GoogleFonts.openSans(
                                color: Color.fromARGB(255, 200, 230, 255),
                                fontSize: 4.sp
                                    
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 252, 232, 48),
                                  elevation: 50,
                                  //minimumSize: Size(100, 50)
                                  ),
                              onPressed: () => {
                                Provider.of<logged_in_user_provider>(context, listen: false).set_user_email_for_provider(""),
                                html.window.location.reload(),
                                Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => Home_without_login()))},
                              child: Text(
                                "LOG OUT",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: 4.sp,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),


              (no_booking_for_the_user == true) ?
              Column(
                children: [

                  SizedBox(height: 60,),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RiveAnimation.network(
                      "https://res.cloudinary.com/dvypswxcv/raw/upload/v1687548652/404_fkwie6.riv", stateMachines: ['State Machine 1'], 
                      )),

                      SizedBox(height: 20,),
                      Text("No Bookings found. :^(", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)
                ],
              )
              : Column(

                children: [
                  Container(width: MediaQuery.of(context).size.width,
                            height: 100,),

                  Container(
                    width: double.infinity,
                    
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dividerThickness: 5,
                        columns: [
                          DataColumn(label: Text("Booking ID", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                          DataColumn(label: Text("Bus Name", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                          DataColumn(label: Text("Source", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                          DataColumn(label: Text("Destination", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                          DataColumn(label: Text("Number of Tickets", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                          DataColumn(label: Text("Date", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                          DataColumn(label: Text("Rating Status", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                          DataColumn(label: Text("Cancel Status", style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),)),
                        ], 
                        rows: rows
                        
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          
        ],
      ),
      
    );
  }
  }
}