import 'dart:convert';

import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'dart:math' as math;
import 'package:bus_book/networks/http_requests_for_backend.dart';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/offers.dart';
import 'package:bus_book/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'login.dart';

class forgot_password extends StatefulWidget {
  const forgot_password({super.key});

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

String email = "";



var emailValidator = MultiValidator([
  RequiredValidator(errorText: "Email can't be empty!"),
  EmailValidator(errorText: "Enter valid email!")
]);

var emailController = TextEditingController();


Future send_reset_email({required String email}) async{
  final serviceId = "service_kbqo7zd";
  final templateId = "template_w3p1evg";
  final userId = "VNqFZjgiXSVDtpp4y";
  final password = await fetch_user_password(email);

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(url,
  headers: {
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'service_id': serviceId,
    'template_id': templateId,
    'user_id': userId,
    'accessToken': "eW0V58Yhp9sjRM3stWirX",
    'template_params': {
      'user_name': email,
      'user_subject': "Password Reset for your Bus Book Account",
      'user_message': password
    }
  },)
  );
  print(response.body);
}

class _forgot_passwordState extends State<forgot_password> {
  final _formKey = GlobalKey<FormState>();
  //Future<String> xyz = fetch_user_id(email);

  @override
  Widget build(BuildContext context) {

    if(MediaQuery.of(context).size.width > 900) 
    {
      return Sizer( builder: (context, orientation, deviceType) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [

          Stack(
            children: [
              Container(
                 height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", artboard: 'New Artboard', stateMachines: ['State Machine 1'], fit: BoxFit.cover,)
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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Home_without_login())),
                    child: Text(
                      "Bus Booker",
                      style: GoogleFonts.openSans(
                          color: Color.fromARGB(255, 200, 230, 255),
                          fontSize: 5.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => offers())),
                    child: Text(
                      "OFFERS",
                      style: GoogleFonts.openSans(
                        color: Color.fromARGB(255, 200, 230, 255),
                        fontSize: 3.sp
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
                        fontSize: 3.sp
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 252, 232, 48),
                          elevation: 50,
                          minimumSize: MediaQuery.of(context).size.width > 1200 ? Size(100, 50) : (MediaQuery.of(context).size.width > 600 ) ? Size(60, 50) : Size(30, 50)),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn())),
                      child: Text(
                        "LOG IN",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 3.sp,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),

            Positioned(
              top: 200,
                left: MediaQuery.of(context).size.width * 0.07,
              child: Container(
               width: MediaQuery.of(context).size.width * 0.38,
               height: MediaQuery.of(context).size.height * 0.5,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: AlertDialog(
                 //actionsOverflowAlignment: null,
                  alignment: Alignment.topLeft,
                  scrollable: true,
                  elevation: 100,
                  clipBehavior: Clip.none,
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  
                  backgroundColor: Color.fromARGB(255, 212, 237, 255),
                  content: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text("RESET YOUR PASSWORD",
                                             style: GoogleFonts.openSans(
                                                 fontSize: MediaQuery.of(context).size.width * 0.02,
                                                 fontWeight: FontWeight.bold,
                                                 color:
                                                     const Color.fromRGBO(15, 27, 97, 1)))),
                         
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                         
                           
                            //* EMAIL ->
                            TextFormField(
                              enabled: true,
                              style: TextStyle(
                                  color: const Color.fromRGBO(15, 27, 97, 1),
                          //                   //fontFamily: 'Cirka',
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 1000)
                                          ? 20
                                          : 10),
                          //               //obscureText: false,
                              controller: emailController,
                              validator: emailValidator,
                              onChanged: (value) => email = value,
                              cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                              decoration: InputDecoration(
                                icon: const Icon(Icons.email_outlined),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                          //                 //fillColor: Color.fromRGBO(15, 27, 97, 1),
                         
                                filled: true,
                                hintText: 'Enter your Email...',
                                hintStyle: TextStyle(
                                  color: const Color.fromRGBO(36, 45, 98, 1),
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 1000)
                                          ? 20
                                          : 10,
                          //                   //fontFamily: 'Cirka',
                                ),
                                alignLabelWithHint: true,
                              ),
                            ),
                         
                           
                         
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                         
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(20),
                          //                     //primary: Color.fromRGBO(236, 200, 246, 1),
                                    side: const BorderSide(
                                        color: Color.fromRGBO(12, 0, 252, 1),
                                        width: 3),
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                    backgroundColor:
                                        const Color.fromRGBO(245, 210, 255, 1),
                                    foregroundColor:
                                        const Color.fromRGBO(12, 0, 252, 1),
                                  ),
                                  onPressed: () async { 
                                    
                                    String temp = (await fetch_user_id(email));

                                    if(_formKey.currentState!.validate() && temp == "-1") {
                                      
                                      Fluttertoast.showToast(
                                      msg: "NO ACCOUNT EXISTS FOR THE ENTERED MAIL ID!", timeInSecForIosWeb: 4,
                                      webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                      textColor: Colors.white
                                    );
                         
                              }               
                              else if(_formKey.currentState!.validate()){
                                send_reset_email(email: email);

                                Fluttertoast.showToast(msg: "Password has been sent to your mail id!",
                                                       timeInSecForIosWeb: 5,
                                                       textColor: Colors.black);
                                await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_without_login()));
                              }
                              },
                                  child: Text(
                                    "RESET!",
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromRGBO(
                                            15, 27, 97, 1)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
              ),

            ),

            Positioned(
                right: MediaQuery.of(context).size.width * 0.08,
                top: 210,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687548887/forgot_password_tob20i.riv", stateMachines: ['State Machine 1'],),
                  ),
                ),
              ),

            ],
          ),


          
      ]),
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
            mainAxisAlignment: MainAxisAlignment.start,
        
            children: [
        
              Stack(
                children: [
                  Container(
                     height: MediaQuery.of(context).size.height * 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", artboard: 'New Artboard', stateMachines: ['State Machine 1'], fit: BoxFit.cover,)
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
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Home_without_login())),
                            child: Text(
                              "Bus Booker",
                              style: GoogleFonts.openSans(
                                  color: Color.fromARGB(255, 200, 230, 255),
                                  fontSize: MediaQuery.of(context).size.width > 1200 ? 30 : 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                          ),
                          
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => offers())),
                            child: Text(
                              "OFFERS",
                              style: GoogleFonts.openSans(
                                color: Color.fromARGB(255, 200, 230, 255),
                                fontSize: MediaQuery.of(context).size.width > 1200 ? 18 : 15,
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
                                fontSize: MediaQuery.of(context).size.width > 1200 ? 18 : 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.12,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 252, 232, 48),
                                  elevation: 50,
                                  minimumSize: MediaQuery.of(context).size.width > 1200 ? Size(100, 50) : (MediaQuery.of(context).size.width > 600 ) ? Size(60, 50) : Size(30, 50)),
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => LogIn())),
                              child: Text(
                                "LOG IN",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width > 1200 ? 15 : (MediaQuery.of(context).size.width > 600 ) ? 13 : 10,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),


                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.05,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      

                      Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687548887/forgot_password_tob20i.riv", stateMachines: ['State Machine 1'],),
                  ),
                ),



                      Container(
                 width: MediaQuery.of(context).size.width * 0.8,
                 height: MediaQuery.of(context).size.height * 0.5,
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                 child: AlertDialog(
                   //actionsOverflowAlignment: null,
                    alignment: Alignment.topLeft,
                    scrollable: true,
                    clipBehavior: Clip.none,
                    shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
                 
                    backgroundColor: Color.fromARGB(255, 212, 237, 255),
                    content: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Text("RESET YOUR PASSWORD",
                                               style: GoogleFonts.openSans(
                                                   fontSize: 25,
                                                   fontWeight: FontWeight.bold,
                                                   color:
                                                       const Color.fromRGBO(15, 27, 97, 1)))),
                           
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                           
                             
                              //* EMAIL ->
                              TextFormField(
                                enabled: true,
                                style: TextStyle(
                                    color: const Color.fromRGBO(15, 27, 97, 1),
                            //                   //fontFamily: 'Cirka',
                                    fontSize:
                                        (MediaQuery.of(context).size.width > 1000)
                                            ? 20
                                            : 10),
                            //               //obscureText: false,
                                controller: emailController,
                                validator: emailValidator,
                                onChanged: (value) => email = value,
                                cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.email_outlined),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                            //                 //fillColor: Color.fromRGBO(15, 27, 97, 1),
                           
                                  filled: true,
                                  hintText: 'Enter your Email...',
                                  hintStyle: TextStyle(
                                    color: const Color.fromRGBO(36, 45, 98, 1),
                                    fontSize:
                                        (MediaQuery.of(context).size.width > 1000)
                                            ? 20
                                            : 10,
                            //                   //fontFamily: 'Cirka',
                                  ),
                                  alignLabelWithHint: true,
                                ),
                              ),
                           
                             
                           
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                           
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                            //                     //primary: Color.fromRGBO(236, 200, 246, 1),
                                      side: const BorderSide(
                                          color: Color.fromRGBO(12, 0, 252, 1),
                                          width: 3),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal),
                                      backgroundColor:
                                          const Color.fromRGBO(245, 210, 255, 1),
                                      foregroundColor:
                                          const Color.fromRGBO(12, 0, 252, 1),
                                    ),
                                    onPressed: () async { 
                                      
                                      String temp = (await fetch_user_id(email));
        
                                      if(_formKey.currentState!.validate() && temp == "-1") {
                                        
                                        Fluttertoast.showToast(
                                        msg: "NO ACCOUNT EXISTS FOR THE ENTERED MAIL ID!", timeInSecForIosWeb: 4,
                                        webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                        textColor: Colors.white
                                      );
                           
                                }               
                                else if(_formKey.currentState!.validate()){
                                  send_reset_email(email: email);
        
                                  Fluttertoast.showToast(msg: "Password has been sent to your mail id!",
                                                         timeInSecForIosWeb: 5,
                                                         textColor: Colors.black);
                                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_without_login()));
                                }
                                },
                                    child: Text(
                                      "RESET!",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(
                                              15, 27, 97, 1)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),

                    ],
                  ),
                ),
                
        
                
        
                ],
              ),
        
        
              
          ]),
        ),
      ),
    );
    }
  );
  }
  }
}