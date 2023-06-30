import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/offers.dart';
import 'package:bus_book/pages/signup.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../Screens/Home_with_login_signup_buttons.dart';

class bus_schedule extends StatefulWidget {
  const bus_schedule({super.key});

  @override
  State<bus_schedule> createState() => _bus_scheduleState();
}

class _bus_scheduleState extends State<bus_schedule> {
  @override
  Widget build(BuildContext context) {

    if(MediaQuery.of(context).size.width > 900) {
    return Sizer( builder: (context, orientation, deviceType) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,

        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", stateMachines: ['State Machine 1'], fit: BoxFit.cover,),
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
                            onTap: () => (
                                Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider() != "") 
                                ? Navigator.push(context, MaterialPageRoute(builder: (context) => Home_with_login())) : 
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_without_login())),
              
                            child: Text(
                              "Bus Booker",
                              style: GoogleFonts.openSans(
                                  color: Color.fromARGB(255, 200, 230, 255),
                                  fontSize: 6.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                          
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "OFFERS",
                              style: GoogleFonts.openSans(
                                color: Color.fromARGB(255, 200, 230, 255),
                                fontSize: 4.sp
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
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
                            width: 25.w,
                          ),
              
                        ],
                      ),
                    ),

                Positioned(
                  left: MediaQuery.of(context).size.width * 0.065,
                  top: MediaQuery.of(context).size.height * 0.135,
                  right: 0,
                  bottom: 0,
                  child: Text("Here is the bus Schedule: ", style: GoogleFonts.openSans(color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.width * 0.017),),
                ),

                Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,

                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                      
                        columns: [
                          DataColumn(label: Text(
                            "Bus Name", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                      
                          DataColumn(label: Text(
                            "Bus Route", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                      
                          DataColumn(label: Text(
                            "Days of Week", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                                      
                          DataColumn(label: Text(
                            "Capacity", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                      
                        ],
                      
                        rows: [
                      
                          //********************* 1 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus K", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Barasat (15:15) to Basirhat (20:25)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Fri, Sat, Sun", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                      
                          //********************* 2 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus A", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (13:15) to Durgapur (14:15) to Asansol (16:15)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Mon, Tue, Fri", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 3 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus B", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (15:20) to Durgapur (17:50) to Asansol (18:30) to Siliguri(20:30)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Daily", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 4 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus C", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (10:10) to Durgapur (11:15) to Asansol (13:16) to Karunamoyee (15:15)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Mon, Tue, Wed, Fri, Sat, Sun", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 5 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus D", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (23:00) to Durgapur (01:00) to Asansol (02:30) to Karunamoyee(03:45) to Siliguri(05:50)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Mon, Tue, Fri, Sat, Sun", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          
                        ]),
                    ),
                  ),
                ),
                  
                ],
              )
            ],
          ),
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
        height: double.infinity,
        width: MediaQuery.of(context).size.width,

        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", stateMachines: ['State Machine 1'], fit: BoxFit.cover,),
                  ),
              
        
                 Container(
                  width: double.infinity,
                   child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(
                           width: 40,
                         ),
                         InkWell(
                           onTap: () => (
                               Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider() != "") 
                               ? Navigator.push(context, MaterialPageRoute(builder: (context) => Home_with_login())) : 
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => Home_without_login())),
                             
                           child: Text(
                             "Bus Booker",
                             style: GoogleFonts.openSans(
                                 color: Color.fromARGB(255, 200, 230, 255),
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold),
                           ),
                         ),
                         SizedBox(
                           width: MediaQuery.of(context).size.width * 0.25,
                         ),
                         
                         
                         InkWell(
                           onTap: () {},
                           child: Text(
                             "OFFERS",
                             style: GoogleFonts.openSans(
                               color: Color.fromARGB(255, 200, 230, 255),
                               fontSize: 15,
                             ),
                           ),
                         ),
                         SizedBox(
                           width: MediaQuery.of(context).size.width * 0.08,
                         ),
                         
                         Text(
                           "CONTACT US",
                           style: GoogleFonts.openSans(color: Color.fromARGB(255, 200, 230, 255),
                           fontSize: 15, 
                           fontWeight: FontWeight.bold),
                         ),
                             
                         
                             
                             
                         
                       ],
                     ),
                   ),
                 ),
                
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.075,
                  top: MediaQuery.of(context).size.height * 0.13,
                  right: 0,
                  bottom: 0,
                  child: Text("Here is the bus Schedule: ", style: GoogleFonts.openSans(color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.width * 0.03),),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      
                      child: DataTable(
                      
                        columns: [
                          DataColumn(label: Text(
                            "Bus Name", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                      
                          DataColumn(label: Text(
                            "Bus Route", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                      
                          DataColumn(label: Text(
                            "Days of Week", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                                      
                          DataColumn(label: Text(
                            "Capacity", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold),)),
                      
                        ],
                      
                        rows: [
                      
                          //********************* 1 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus K", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Barasat (15:15) to Basirhat (20:25)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Fri, Sat, Sun", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                      
                          //********************* 2 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus A", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (13:15) to Durgapur (14:15) to Asansol (16:15)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Mon, Tue, Fri", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 3 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus B", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (15:20) to Durgapur (17:50) to Asansol (18:30) to Siliguri(20:30)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Daily", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 4 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus C", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (10:10) to Durgapur (11:15) to Asansol (13:16) to Karunamoyee (15:15)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Mon, Tue, Wed, Fri, Sat, Sun", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 5 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              Text(
                                    "Bus D", 
                                    style: GoogleFonts.openSans(
                                    color: Colors.white, 
                                    fontSize: 15),)),
                      
                            DataCell(Text(
                            "Bankura (23:00) to Durgapur (01:00) to Asansol (02:30) to Karunamoyee(03:45) to Siliguri(05:50)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Mon, Tue, Fri, Sat, Sun", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                                      
                              DataCell(Text(
                            "50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          
                        ]),
                    ),
                  ),
                ),
                  
                ],
              )
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