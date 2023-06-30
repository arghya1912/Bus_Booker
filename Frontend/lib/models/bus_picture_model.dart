import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
//import 'package:three_dart/three_dart.dart';
import 'package:bus_book/pages/offers.dart';
import 'package:sizer/sizer.dart';

import '3d_bus_model.dart';
import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/my_bookings.dart';
import 'package:bus_book/pages/page_before_payement.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../constants.dart';
import '../providers/logged_in_user_provider.dart';


class bus_model extends StatefulWidget {

  final Map<String, dynamic> jsonResponse;
  final String source;
  final String destination;
  final String date;

  const bus_model({Key? key, required this.jsonResponse, required this.source, required this.destination, required this.date}) : super(key: key);


  @override
  State<bus_model> createState() => _bus_modelState();
}

class _bus_modelState extends State<bus_model> {

  Object bus = new Object();


  Map<String, dynamic> jsonResponse = {};
  List<dynamic> bookedSeats = [];
  List<bool> bus_booked_left = List.filled(20, false);
  List<bool> bus_booked_right = List.filled(30, false);
  List<int> already_booked_index = List.filled(51, 0);
  List<bool> user_selected_seats = List.filled(51, false);
  Set<dynamic> final_seats = {};

  @override
  void initState() {
    
    super.initState();
    jsonResponse = widget.jsonResponse;
    //bus_booked_right[0] = true;
    if(jsonResponse['booked_seats'].toString() != "0") {
      bookedSeats.addAll(jsonResponse['booked_seats']);
      for(var seat in bookedSeats) {
        if(seat[0] != null) {
          int x = int.parse(seat[0].toString());
          if(x is int) {
            already_booked_index[x - 1] = 1;
          }
        }
      }
      //print(already_booked_index);
    }
    //print(jsonResponse['booked_seats']);
    
  }
  
  String username = "";
  @override
  Widget build(BuildContext context) {
    String logged_in_user_email = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    if(logged_in_user_email != "")
    username = logged_in_user_email.substring(0, logged_in_user_email.indexOf('@'));

    if(MediaQuery.of(context).size.width > 900) 
    {
      return Sizer( builder: (context, orientation, deviceType) {
    return Scaffold(
     

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  Text(
                    "Bus Booker",
                    style: GoogleFonts.openSans(
                        color: Color.fromARGB(255, 200, 230, 255),
                        fontSize: 6.sp,
                        fontWeight: FontWeight.bold),
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

                Positioned(
                  top: 100,
                  left: 100,
                  child: Row(
                    children: [
                      Text("Select your seats: ", style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 5.sp),),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                  
                      Column(
                        children: [

                          Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.16,
                  decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 244, 255),
                          border: Border.all(
                              color: Color.fromARGB(255, 0, 42, 255), width: 5)),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Image.network(
                          "https://res.cloudinary.com/dvypswxcv/image/upload/v1680894728/steering_wheel_ogo1gf.png", fit: BoxFit.fill,)),
                          ],
                    ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.65,
                                //width: MediaQuery.of(context).size.width * 0.1,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 17,
                          ),
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  if(already_booked_index[index] != 1)
                                  bus_booked_left[index] = !bus_booked_left[index];
                                  user_selected_seats[index] = !user_selected_seats[index];
                                  if(this.mounted)
                                  setState(() {});
                                },
                                child: (already_booked_index[index] == 1) ? Tooltip(
                                      message: "Seat ${index + 1}, Booked!",
                                      child: Image.network(
                                          "https://res.cloudinary.com/dvypswxcv/image/upload/v1681057232/already_booked_seat-removebg-preview_kqifhx.png"),
                                    ) : ((bus_booked_left[index] ? Tooltip(
                                      message: "Seat ${index+1}, Selected!",
                                      child: Image.network(
                                          "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880935/bus_seat_selected_pwklec.png"),
                                    ): (Tooltip(
                                      message: "Seat ${index+1}, Not Booked!",
                                      child: Image.network(
                                          "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880939/bus_seat_not_selected_ssaipo.png",
                                          fit: BoxFit.fill,
                                        ),
                                    ))
                                    ))
                                //tooltip: 'Click Here',
                                );
                          },
                                  ),
                                ),
                              ),
                            ),
                          
                            // SizedBox(width: 15,),
                            Spacer(
                              flex: 1,
                            ),
                          
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.65,
                                //width: MediaQuery.of(context).size.width * 0.1,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 18,
                          ),
                          itemCount: 30,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  if(already_booked_index[index + 20] != 1)
                                  bus_booked_right[index] = !bus_booked_right[index];
                                  user_selected_seats[index + 20] = !user_selected_seats[index + 20];
                  
                                  if(this.mounted)
                                  setState(() {});
                                },
                                child: (already_booked_index[index + 20] == 1) ? Tooltip(
                                      message: "Seat ${index + 21}, Booked!",
                                      child: Image.network(
                                          "https://res.cloudinary.com/dvypswxcv/image/upload/v1681057232/already_booked_seat-removebg-preview_kqifhx.png"),
                                    ) : (bus_booked_right[index])
                                    ? Tooltip(
                                      message: "Seat ${index+21}, Selected!",
                                      child: Image.network(
                                          "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880935/bus_seat_selected_pwklec.png"),
                                    )
                                    : Tooltip(
                                      message: "Seat ${index+21}, Not Booked!",
                                      child: Image.network(
                                          "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880939/bus_seat_not_selected_ssaipo.png",
                                          fit: BoxFit.fill,
                                        ),
                                    ));
                          },
                                  ),
                                ),
                              ),
                            ),
                          ],
                    ),      
                  ]),
                          ),


                          SizedBox(height: 10,
                          ),


                          ElevatedButton(
                  onPressed: () => {
                    for(int i = 0; i < 50; i++) {
                      if(user_selected_seats[i] == true) {
                        final_seats.add(i + 1)
                      }
                    },
                                
                    (final_seats.length == 0) ? 
                        Fluttertoast.showToast(
                          msg: "YOU NEED TO SELECT ATLEAST ONE SEAT!", timeInSecForIosWeb: 5,
                          textColor: Colors.white,
                          webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                          
                        ) : 
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page_before_payment(finalSeats: final_seats, source: widget.source, destination: widget.destination, date: widget.date)))} , 
                  child: Text("Confirm?")
                                ),

                        ],
                      ),
                    
                      SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
                    
                      
                  
                  
                    Column(
                      children: [
                        Text(
                  "View the bus in 3D!", style: GoogleFonts.openSans(
                        color: Colors.white, fontSize: 5.sp, fontWeight: FontWeight.bold)),

                        SizedBox(height: 30,),

                        SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: WebViewXPage()
                      ),
                      ],
                    ),
                  
                    ],
                  ),
                ),
                
              ],
            ),
            
          ],
        ),
      ),
    );
    }
      );
  }
  else {
    return Sizer( builder: (context, orientation, deviceType) {
    return Scaffold(
     

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,

        child: SingleChildScrollView(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        
              Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 1.5,
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
                  Text(
                    "Bus Booker",
                    style: GoogleFonts.openSans(
                        color: Color.fromARGB(255, 200, 230, 255),
                        fontSize: 7.sp,
                            
                        fontWeight: FontWeight.bold),
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

              Positioned(
                top: 90,
                left: 150,
                child: Column(
                  children: [

                    Text("Select your seats", style: GoogleFonts.openSans(color: Colors.white, 
                          fontWeight: FontWeight.bold, fontSize: 15),),

                    SizedBox(height: 30,),

                    Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 244, 255),
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 42, 255), width: 5)),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Image.network(
                                  "https://res.cloudinary.com/dvypswxcv/image/upload/v1680894728/steering_wheel_ogo1gf.png", fit: BoxFit.fill,)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              //width: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 17,
                                  ),
                                  itemCount: 20,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                        onTap: () {
                                          if(already_booked_index[index] != 1)
                                          bus_booked_left[index] = !bus_booked_left[index];
                                          user_selected_seats[index] = !user_selected_seats[index];
                                          if(this.mounted)
                                          setState(() {});
                                        },
                                        child: (already_booked_index[index] == 1) ? Tooltip(
                                              message: "Seat ${index + 1}, Booked!",
                                              child: Image.network(
                                                  "https://res.cloudinary.com/dvypswxcv/image/upload/v1681057232/already_booked_seat-removebg-preview_kqifhx.png"),
                                            ) : ((bus_booked_left[index] ? Tooltip(
                                              message: "Seat ${index+1}, Selected!",
                                              child: Image.network(
                                                  "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880935/bus_seat_selected_pwklec.png"),
                                            ): (Tooltip(
                                              message: "Seat ${index+1}, Not Booked!",
                                              child: Image.network(
                                                  "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880939/bus_seat_not_selected_ssaipo.png",
                                                  fit: BoxFit.fill,
                                                ),
                                            ))
                                            ))
                                        //tooltip: 'Click Here',
                                        );
                                  },
                                ),
                              ),
                            ),
                          ),
                        
                          // SizedBox(width: 15,),
                          Spacer(
                            flex: 1,
                          ),
                        
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              //width: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 18,
                                  ),
                                  itemCount: 30,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                        onTap: () {
                                          if(already_booked_index[index + 20] != 1)
                                          bus_booked_right[index] = !bus_booked_right[index];
                                          user_selected_seats[index + 20] = !user_selected_seats[index + 20];
      
                                          if(this.mounted)
                                          setState(() {});
                                        },
                                        child: (already_booked_index[index + 20] == 1) ? Tooltip(
                                              message: "Seat ${index + 21}, Booked!",
                                              child: Image.network(
                                                  "https://res.cloudinary.com/dvypswxcv/image/upload/v1681057232/already_booked_seat-removebg-preview_kqifhx.png"),
                                            ) : (bus_booked_right[index])
                                            ? Tooltip(
                                              message: "Seat ${index+21}, Selected!",
                                              child: Image.network(
                                                  "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880935/bus_seat_selected_pwklec.png"),
                                            )
                                            : Tooltip(
                                              message: "Seat ${index+21}, Not Booked!",
                                              child: Image.network(
                                                  "https://res.cloudinary.com/dvypswxcv/image/upload/v1680880939/bus_seat_not_selected_ssaipo.png",
                                                  fit: BoxFit.fill,
                                                ),
                                            ));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),     
                      
                              ],
                            ),

                            SizedBox(height: 20,),

                            ElevatedButton(
                    onPressed: () => {
                      for(int i = 0; i < 50; i++) {
                        if(user_selected_seats[i] == true) {
                          final_seats.add(i + 1)
                        }
                      },
                  
                      (final_seats.length == 0) ? 
                          Fluttertoast.showToast(
                            msg: "YOU NEED TO SELECT ATLEAST ONE SEAT!", timeInSecForIosWeb: 5,
                            textColor: Colors.white,
                            webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                            
                          ) : 
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page_before_payment(finalSeats: final_seats, source: widget.source, destination: widget.destination, date: widget.date)))} , 
                    child: Text("Confirm?")
                  ),



                            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),


                            Text(
                    "View the bus in 3D!", style: GoogleFonts.openSans(
                      color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),

                      SizedBox(height: 15,),


                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: WebViewXPage()
                  ),




                    
                  ],
                ),
              ),
                  
                  
      
      
                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
    }
  );
  }
  }
}
