import 'dart:convert';
import 'dart:html' as html;
import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/models/bus_picture_model.dart';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/my_bookings.dart';
import 'package:bus_book/pages/offers.dart';
import 'package:bus_book/providers/bus_id_provider.dart';
import 'package:bus_book/providers/bus_name_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';
import '../networks/http_requests_for_backend.dart';
import '../providers/logged_in_user_provider.dart';

class BusNameCards extends StatefulWidget {
  final BusRoutes busRoutes;
  final String source;
  final String destination;
  final String date;

  const BusNameCards({Key? key, required this.busRoutes, required this.source, required this.destination, required this.date}) : super(key: key);

  @override
  _BusNameCardsState createState() => _BusNameCardsState();
}

bool is_bus_booking_list_loader = true;

class _BusNameCardsState extends State<BusNameCards> {
  @override
      void initState() {
        super.initState();
        is_bus_booking_list_loader = true;
        if(this.mounted)
        setState(() {
          
        });
        Future.delayed(const Duration(milliseconds: 2000), () {
          is_bus_booking_list_loader = false;
          if(this.mounted)
          setState(() {
            
          });
        });
      }

  Future<void> bus_booked_seats_get(int argument_bus_id, String argument_date, String source, String destination, String date) async {
  //print(argument_bus_id);
  var url = Uri.parse(base_url + argument_bus_id.toString() + '/' + argument_date);

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponseArray = json.decode(response.body); 
    //print(jsonResponseArray);
    Navigator.push(context, MaterialPageRoute(builder: (Context) => bus_model(jsonResponse: jsonResponseArray, source: source, destination: destination, date: date)));
    //print(jsonResponseArray);
  }

}
String username = "";


  @override
  Widget build(BuildContext context) {

    List<DataRow> rows = [];
    List<DataRow> rows1 = [];

    for(int i = 0; i < widget.busRoutes.busRoutes.length; i++) {
      DataRow row = DataRow(cells: [

        DataCell(Text('${widget.busRoutes.busRoutes[i].busName}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 17))),

        DataCell(Text('${widget.busRoutes.busRoutes[i].seatsAvailable}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 17))),

        DataCell(Text('${widget.busRoutes.busRoutes[i].departureTime}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 17))),

        DataCell(Text('${widget.busRoutes.busRoutes[i].arrivalTime}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 17))),

        DataCell(
          FutureBuilder<double>(
                  future: fetch_rating(widget.busRoutes.busRoutes[i].busId),
                  builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return Text('${snapshot.data}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 17));
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
        ),

        DataCell(
          ElevatedButton(
                onPressed: () {
                  final loggedInUser = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
                  
                  if (loggedInUser != "") {
                    // User is logged in
                    bus_booked_seats_get(widget.busRoutes.busRoutes[i].busId, widget.busRoutes.busRoutes[i].date, widget.source, widget.destination, widget.date);
                    Provider.of<bus_id_provider>(context, listen: false).set_bus_id_for_provider(widget.busRoutes.busRoutes[i].busId);
                  } else {
                    // User is not logged in
                    Fluttertoast.showToast(
                      msg: "KINDLY LOGIN TO BOOK TICKETS!", timeInSecForIosWeb: 6,
                      webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                      textColor: Colors.white);
                  }
                },
                child: Text("Book Tickets!", style: GoogleFonts.openSans(color: Colors.white, fontSize: 10),)
              ),
        ),
      ]);
      rows.add(row);
    }
    

    for(int i = 0; i < widget.busRoutes.busRoutes.length; i++) {
      DataRow row3 = DataRow(cells: [

        DataCell(Text('${widget.busRoutes.busRoutes[i].busName}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 10))),

        DataCell(Text('${widget.busRoutes.busRoutes[i].seatsAvailable}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 10))),

        DataCell(Text('${widget.busRoutes.busRoutes[i].departureTime}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 10))),

        DataCell(Text('${widget.busRoutes.busRoutes[i].arrivalTime}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 10))),

        DataCell(
          FutureBuilder<double>(
                  future: fetch_rating(widget.busRoutes.busRoutes[i].busId),
                  builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return Text('${snapshot.data}', style: GoogleFonts.openSans(color: Colors.white, fontSize: 10));
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
        ),

        DataCell(
          ElevatedButton(
                onPressed: () {
                  final loggedInUser = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
                  
                  if (loggedInUser != "") {
                    // User is logged in
                    bus_booked_seats_get(widget.busRoutes.busRoutes[i].busId, widget.busRoutes.busRoutes[i].date, widget.source, widget.destination, widget.date);
                    Provider.of<bus_id_provider>(context, listen: false).set_bus_id_for_provider(widget.busRoutes.busRoutes[i].busId);
                  } else {
                    // User is not logged in
                    Fluttertoast.showToast(
                      msg: "KINDLY LOGIN TO BOOK TICKETS!", timeInSecForIosWeb: 6,
                      webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                      textColor: Colors.white);
                  }
                },
                child: Text("Book Tickets!", style: GoogleFonts.openSans(color: Colors.white, fontSize: 10),)
              ),
        ),
      ]);
      rows1.add(row3);
    }

    String logged_in_user_email = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    if(logged_in_user_email != "")
    username = logged_in_user_email.substring(0, logged_in_user_email.indexOf('@'));
    //print(email); 

    if(MediaQuery.of(context).size.width > 900) {
    return Sizer( builder: (context, orientation, deviceType) {
    return Scaffold(
      body: 
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                top: 150,
                left: 150,
                child: DataTable(
                    dividerThickness: 8,
                    columns: [
                      DataColumn(label: Text("Bus Name", style: GoogleFonts.openSans(color: Colors.white, fontSize: 4.5.sp),)),
                      DataColumn(label: Text("Seats Available", style: GoogleFonts.openSans(color: Colors.white, fontSize: 4.5.sp),)),
                      DataColumn(label: Text("Departure Time", style: GoogleFonts.openSans(color: Colors.white, fontSize: 4.5.sp),)),
                      DataColumn(label: Text("Arrival Time", style: GoogleFonts.openSans(color: Colors.white, fontSize: 4.5.sp),)),
                      DataColumn(label: Text("Reviews", style: GoogleFonts.openSans(color: Colors.white, fontSize: 4.5.sp),)),
                      DataColumn(label: Text("Book Tickets", style: GoogleFonts.openSans(color: Colors.white, fontSize: 4.5.sp),)),
                    ], 
                    rows: rows
                    
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
      return Scaffold(
      body: 
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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


              Column(
                children: [
                  Container(width: MediaQuery.of(context).size.width,
                            height: 100,),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          dividerThickness: 8,
                          columns: [
                            DataColumn(label: Text("Bus Name", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                            DataColumn(label: Text("Seats Available", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                            DataColumn(label: Text("Departure Time", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                            DataColumn(label: Text("Arrival Time", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                            DataColumn(label: Text("Reviews", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                            DataColumn(label: Text("Book Tickets", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                          ], 
                          rows: rows1
                          
                        ),
                    ),
                  ),
                ],
              ),
      
     
      
      
              ],
            ),
          ],
        ),
      ),
      
    );
    }
  }
}
