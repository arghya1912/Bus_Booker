import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/pages/contact_us.dart';
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

class offers extends StatefulWidget {
  const offers({super.key});

  @override
  State<offers> createState() => _offersState();
}

class _offersState extends State<offers> {
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
                  child: Text("Click on the code to copy it : ", style: GoogleFonts.openSans(color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.width * 0.017),),
                ),

                Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: 0,
                  bottom: 0,
                  child: DataTable(
                  
                    columns: [
                      DataColumn(label: Text(
                        "Coupon Code", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 18, 
                          fontWeight: FontWeight.bold),)),
                  
                      DataColumn(label: Text(
                        "Discount Percentage (%)", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 18, 
                          fontWeight: FontWeight.bold),)),
                  
                      DataColumn(label: Text(
                        "Minimum amount to be spent", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 18, 
                          fontWeight: FontWeight.bold),)),
                  
                    ],
                  
                    rows: [
                  
                      //********************* 1 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "eF8dW5pA7cS9tY0rU6"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "eF8dW5pA7cS9tY0rU6", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "0.5%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 50", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                  
                      //********************* 2 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "X0rN2vY8sL3wF1tK6"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "X0rN2vY8sL3wF1tK6", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "0.8%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 80", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 3 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "zE3pC1sK9xJ6qT7rD2"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "zE3pC1sK9xJ6qT7rD2", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "1%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 90", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 4 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "B8nT1jR6fL3mV7sA0"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "B8nT1jR6fL3mV7sA0", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "2%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 100", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 5 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "S0cL9jM6vK8rP5wB3"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "S0cL9jM6vK8rP5wB3", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "3%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 150", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 6 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "Q5dA4cS2tZ6gN9mL7"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "Q5dA4cS2tZ6gN9mL7", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "5%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 200", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 7 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "K7vS4tB8mL2wC0nJ6"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "K7vS4tB8mL2wC0nJ6", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "9%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 280", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 8 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "X4dF8tV7hS1pK3gM6"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "X4dF8tV7hS1pK3gM6", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "10%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 300", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 9 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "L0nK2jB4fT7mP8rN6"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "L0nK2jB4fT7mP8rN6", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "20%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 500", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 10 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "Y6tG2sV7hF8bC1nM0"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "Y6tG2sV7hF8bC1nM0", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "30%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 600", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 11 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "J9dP8rT3fA7vL6mS5"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "J9dP8rT3fA7vL6mS5", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "40%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 800", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      //********************* 12 *****************************/
                      DataRow(
                        cells: [
                        DataCell(
                          InkWell(
                            onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "aB6fYt1Kp0wLm7zN8sE9"));
                                Fluttertoast.showToast(
                                  msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                  textColor: Colors.black);
                                // copied successfully
                              },
                            child: Text(
                                  "aB6fYt1Kp0wLm7zN8sE9", 
                                  style: GoogleFonts.openSans(
                                  color: Colors.white, 
                                  fontSize: 15),),
                          )),
                  
                        DataCell(Text(
                        "60%", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                  
                        DataCell(Text(
                        "Rs 1000", 
                        style: GoogleFonts.openSans(
                          color: Colors.white, 
                          fontSize: 15),)),
                      ]),
                  
                      
                    ]),
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
                  child: Text("Click on the code to copy it : ", style: GoogleFonts.openSans(color: Colors.white,
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
                            "Coupon Code", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15, 
                              fontWeight: FontWeight.bold),)),
                      
                          DataColumn(label: Text(
                            "Discount Percentage (%)", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15, 
                              fontWeight: FontWeight.bold),)),
                      
                          DataColumn(label: Text(
                            "Minimum amount to be spent", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15, 
                              fontWeight: FontWeight.bold),)),
                      
                        ],
                      
                        rows: [
                      
                          //********************* 1 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "eF8dW5pA7cS9tY0rU6"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "eF8dW5pA7cS9tY0rU6", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "0.5%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 50", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                      
                          //********************* 2 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "X0rN2vY8sL3wF1tK6"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "X0rN2vY8sL3wF1tK6", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "0.8%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 80", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 3 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "zE3pC1sK9xJ6qT7rD2"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "zE3pC1sK9xJ6qT7rD2", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "1%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 90", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 4 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "B8nT1jR6fL3mV7sA0"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "B8nT1jR6fL3mV7sA0", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "2%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 100", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 5 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "S0cL9jM6vK8rP5wB3"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "S0cL9jM6vK8rP5wB3", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "3%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 150", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 6 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "Q5dA4cS2tZ6gN9mL7"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "Q5dA4cS2tZ6gN9mL7", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "5%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 200", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 7 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "K7vS4tB8mL2wC0nJ6"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "K7vS4tB8mL2wC0nJ6", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "9%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 280", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 8 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "X4dF8tV7hS1pK3gM6"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "X4dF8tV7hS1pK3gM6", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "10%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 300", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 9 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "L0nK2jB4fT7mP8rN6"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "L0nK2jB4fT7mP8rN6", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "20%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 500", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 10 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "Y6tG2sV7hF8bC1nM0"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "Y6tG2sV7hF8bC1nM0", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "30%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 600", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 11 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "J9dP8rT3fA7vL6mS5"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "J9dP8rT3fA7vL6mS5", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "40%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 800", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                          ]),
                      
                          //********************* 12 *****************************/
                          DataRow(
                            cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: "aB6fYt1Kp0wLm7zN8sE9"));
                                    Fluttertoast.showToast(
                                      msg: "Copied to Clipboard!", timeInSecForIosWeb: 3,
                                      textColor: Colors.black);
                                    // copied successfully
                                  },
                                child: Text(
                                      "aB6fYt1Kp0wLm7zN8sE9", 
                                      style: GoogleFonts.openSans(
                                      color: Colors.white, 
                                      fontSize: 15),),
                              )),
                      
                            DataCell(Text(
                            "60%", 
                            style: GoogleFonts.openSans(
                              color: Colors.white, 
                              fontSize: 15),)),
                      
                            DataCell(Text(
                            "Rs 1000", 
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