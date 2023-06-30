import 'dart:convert';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/offers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rive/rive.dart';
import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:bus_book/globals.dart';
import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/networks/google_sign_in.dart';
import 'package:bus_book/networks/http_requests_for_backend.dart';
import 'package:bus_book/pages/login.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/widgets.dart';
import 'package:crypto/crypto.dart';
import 'package:bus_book/models/google_sign_in_credentials.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

//import 'package:zoom_clone/utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool passwordvisible = false;

String email = "", password = "";

var emailValidator = MultiValidator([
  RequiredValidator(errorText: "Email can't be empty!"),
  EmailValidator(errorText: "Enter valid email!")
]);

var passwordValidator = MultiValidator([
  RequiredValidator(errorText: "Password can't be empty!"),
]);

var emailController = TextEditingController();

var passwordController = TextEditingController();


bool validatePassword(String value) {
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(value);
}




class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
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
                child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", artboard: 'New Artboard', stateMachines: ['State Machine 1'], fit: BoxFit.cover,)),

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
                top: 150,
                left: 150,
                child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: AlertDialog(
                  alignment: Alignment.topLeft,
                  elevation: 100,
                  scrollable: true,
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  backgroundColor:  Color.fromARGB(255, 212, 237, 255),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Text("SIGN UP / REGISTER",
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
                                
                                style: TextStyle(
                                    color: const Color.fromRGBO(15, 27, 97, 1),
                                    fontSize:
                                        (MediaQuery.of(context).size.width > 1200)
                                            ? 20
                                            : 10),
                                controller: emailController,
                                validator: emailValidator,
                                onChanged: (value) => email = value,
                                cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.email_outlined),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                        
                                  filled: true,
                                  hintText: 'Enter your Email...',
                                  hintStyle: TextStyle(
                                    color: const Color.fromRGBO(36, 45, 98, 1),
                                    fontSize:
                                        (MediaQuery.of(context).size.width > 1200)
                                            ? 20
                                            : 10,
                                    //fontFamily: 'Cirka',
                                  ),
                                  alignLabelWithHint: true,
                                ),
                              ),
                        
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              //* PASSWORD ->
                        
                              TextFormField(
                                
                                style: TextStyle(
                                    color: const Color.fromRGBO(15, 27, 97, 1),
                                    fontFamily: 'Cirka',
                                    fontSize:
                                        (MediaQuery.of(context).size.width > 1200)
                                            ? 20
                                            : 10),
                                obscureText: !passwordvisible,
                                cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                controller: passwordController,
                                onChanged: (value) => password = value,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Password is required'),
                                  MinLengthValidator(6,
                                      errorText:
                                          'Password must be at least 6 characters'),
                                  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                      errorText:
                                          'Password must have at least one special character'),
                                  PatternValidator(r'(?=.*?[A-Z])',
                                      errorText:
                                          'Password must have at least one uppercase letter'),
                                  PatternValidator(r'(?=.*?[a-z])',
                                      errorText:
                                          'Password must have at least one lowercase letter'),
                                  PatternValidator(r'(?=.*?[0-9])',
                                      errorText:
                                          'Password must have at least one number'),
                                ]),
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.password_outlined),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  //fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Enter your Password...',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        if(this.mounted)
                                        setState(() {
                                          passwordvisible = !passwordvisible;
                                        });
                                      },
                                      icon: Icon(
                                        passwordvisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      )),
                                  hintStyle: TextStyle(
                                    color: const Color.fromRGBO(15, 27, 97, 1),
                                    fontSize:
                                        (MediaQuery.of(context).size.width > 1200)
                                            ? 20
                                            : 10,
                                    //fontFamily: 'Cirka',
                                  ),
                                  alignLabelWithHint: true,
                                ),
                              ),
                        
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                        
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      //primary: Color.fromRGBO(236, 200, 246, 1),
                                      side: const BorderSide(
                                          color: Color.fromRGBO(12, 0, 252, 1),
                                          width: 3),
                                      textStyle: const TextStyle(
                                          fontSize: 20, fontStyle: FontStyle.normal),
                                      backgroundColor:
                                          Color.fromARGB(255, 248, 223, 255),
                                      foregroundColor:
                                          const Color.fromRGBO(12, 0, 252, 1),
                                    ),
                        
                 //*********************************************************************************************** */ 
                 //                  
                                    onPressed: () async {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      int c = await check_if_account_exists(email, password);
                                      print(c);
                                      if(_formKey.currentState!.validate() && (c == 0 || c == 1)) {
                                        const snackBar = SnackBar(
                                          content: Text('You already have an account. Kindly login'),
                                        );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      _formKey.currentState!.reset();
                                      }
                                      
                                      else if(_formKey.currentState!.validate() && c == 2) {
                                          postRequest(email, password);
                                          sharedPref.set_user(email);
                                          Provider.of<logged_in_user_provider>(context, listen: false).set_user_email_for_provider(email);
                                          Fluttertoast.showToast(
                                            msg: "REGISTERED SUCCESSFULLY!", timeInSecForIosWeb: 6,
                                            textColor: Colors.black);
                                          _formKey.currentState!.reset();
                                          await Navigator.push(context, MaterialPageRoute(builder: (context) => Home_with_login()));
                                      }
                                    },
                                    child: Text(
                                      "REGISTER!",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: const Color.fromRGBO(15, 27, 97, 1)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(children: [
                        SizedBox(height: 6, width: MediaQuery.of(context).size.width, child: DecoratedBox(decoration: BoxDecoration(color: Color.fromARGB(255, 255, 205, 57))),),
                        Center(
                          child: 
                          SizedBox(
                            child: DecoratedBox(
                              decoration: 
                              BoxDecoration(color: Colors.transparent), 
                              child: Text("OR", style: GoogleFonts.openSans(color: Color.fromRGBO(15, 27, 97, 1), fontWeight: FontWeight.bold, fontSize: 18),))))
                      ]),
                        
                          //************************************************************************************************ */
                      
                      
                      
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: ElevatedButton(
                          onPressed: () async {
                            //**GOOGLE SIGN IN ER KHETRE CHECK IF ACCOUNT EXISTS DORKAR NEI */
                            await signInWithGoogle(context).then((value) {});

                            if(google_sign_in_credentials.google_Email == "") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                            }

                            else {
                              var data = utf8.encode(google_sign_in_credentials.google_Email); // data being hashed
                            var hashvalue = sha1.convert(data);
                            
                            postRequest(google_sign_in_credentials.google_Email, hashvalue.toString());

                            if(this.mounted)
                            setState(() {
                              sharedPref.set_user(email);
                              Provider.of<logged_in_user_provider>(context, listen: false).set_user_email_for_provider(google_sign_in_credentials.google_Email);
                            });

                            Fluttertoast.showToast( 
                              msg: "LOGGED IN SUCCESSFULLY!", timeInSecForIosWeb: 5, 
                              textColor: Colors.black);
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => Home_with_login()));
                            }
                            
                        }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548355/google_logo_y3rhdp.png", 
                                  height: MediaQuery.of(context).size.height * 0.02, 
                                  width: MediaQuery.of(context).size.width * 0.02,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.001),
                              Text("Sign up with Google.", style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                                  fontSize: 2.8.sp),
                              ),
                            ],
                          ),
                          
                        ),
                      ),
                        
                        
                    ],
                  ),
                ),
                          ),
              ),

              
              Positioned(
                right: 50,
                top: 230,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687548780/bee_signup_piopfy.riv", stateMachines: ['State Machine 1'],),
                ),
              ),
            ]
          ),
        ],
      ),
    );
    }
  );
    
  }
  else {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549129/signup_login_bg_gmumno.riv", artboard: 'New Artboard', stateMachines: ['State Machine 1'], fit: BoxFit.cover,)),
          
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
                    left: 100,
                    bottom: 25,
                    child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: AlertDialog(
                      alignment: Alignment.topLeft,
                      elevation: 100,
                      scrollable: true,
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                      backgroundColor:  Color.fromARGB(255, 212, 237, 255),
                      content: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Text("SIGN UP / REGISTER",
                                          style: GoogleFonts.openSans(
                                              fontSize: 5.sp,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  const Color.fromRGBO(15, 27, 97, 1)))),
                            
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  //* EMAIL ->
                                  TextFormField(
                                    
                                    style: TextStyle(
                                        color: const Color.fromRGBO(15, 27, 97, 1),
                                        fontSize:
                                            (MediaQuery.of(context).size.width > 1200)
                                                ? 20
                                                : 10),
                                    controller: emailController,
                                    validator: emailValidator,
                                    onChanged: (value) => email = value,
                                    cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.email_outlined),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                            
                                      filled: true,
                                      hintText: 'Enter your Email...',
                                      hintStyle: TextStyle(
                                        color: const Color.fromRGBO(36, 45, 98, 1),
                                        fontSize:
                                            (MediaQuery.of(context).size.width > 1200)
                                                ? 20
                                                : 10,
                                        //fontFamily: 'Cirka',
                                      ),
                                      alignLabelWithHint: true,
                                    ),
                                  ),
                            
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                  //* PASSWORD ->
                            
                                  TextFormField(
                                    
                                    style: TextStyle(
                                        color: const Color.fromRGBO(15, 27, 97, 1),
                                        fontFamily: 'Cirka',
                                        fontSize:
                                            (MediaQuery.of(context).size.width > 1200)
                                                ? 20
                                                : 10),
                                    obscureText: !passwordvisible,
                                    cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                    controller: passwordController,
                                    onChanged: (value) => password = value,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Password is required'),
                                      MinLengthValidator(6,
                                          errorText:
                                              'Password must be at least 6 characters'),
                                      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                          errorText:
                                              'Password must have at least one special character'),
                                      PatternValidator(r'(?=.*?[A-Z])',
                                          errorText:
                                              'Password must have at least one uppercase letter'),
                                      PatternValidator(r'(?=.*?[a-z])',
                                          errorText:
                                              'Password must have at least one lowercase letter'),
                                      PatternValidator(r'(?=.*?[0-9])',
                                          errorText:
                                              'Password must have at least one number'),
                                    ]),
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.password_outlined),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      //fillColor: Colors.black,
                                      filled: true,
                                      hintText: 'Enter your Password...',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            if(this.mounted)
                                            setState(() {
                                              passwordvisible = !passwordvisible;
                                            });
                                          },
                                          icon: Icon(
                                            passwordvisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          )),
                                      hintStyle: TextStyle(
                                        color: const Color.fromRGBO(15, 27, 97, 1),
                                        fontSize:
                                            (MediaQuery.of(context).size.width > 1200)
                                                ? 20
                                                : 10,
                                        //fontFamily: 'Cirka',
                                      ),
                                      alignLabelWithHint: true,
                                    ),
                                  ),
                            
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.width * 0.04,
                                  ),
                            
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(20),
                                          //primary: Color.fromRGBO(236, 200, 246, 1),
                                          side: const BorderSide(
                                              color: Color.fromRGBO(12, 0, 252, 1),
                                              width: 3),
                                          textStyle: const TextStyle(
                                              fontSize: 20, fontStyle: FontStyle.normal),
                                          backgroundColor:
                                              Color.fromARGB(255, 248, 223, 255),
                                          foregroundColor:
                                              const Color.fromRGBO(12, 0, 252, 1),
                                        ),
                            
                     //*********************************************************************************************** */ 
                     //                  
                                        onPressed: () async {
                                          // Validate returns true if the form is valid, or false otherwise.
                                          int c = await check_if_account_exists(email, password);
                                          print(c);
                                          if(_formKey.currentState!.validate() && (c == 0 || c == 1)) {
                                            const snackBar = SnackBar(
                                              content: Text('You already have an account. Kindly login'),
                                            );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          _formKey.currentState!.reset();
                                          }
                                          
                                          else if(_formKey.currentState!.validate() && c == 2) {
                                              postRequest(email, password);
                                              sharedPref.set_user(email);
                                              Provider.of<logged_in_user_provider>(context, listen: false).set_user_email_for_provider(email);
                                              Fluttertoast.showToast(
                                                msg: "REGISTERED SUCCESSFULLY!", timeInSecForIosWeb: 6,
                                                textColor: Colors.black);
                                              _formKey.currentState!.reset();
                                              await Navigator.push(context, MaterialPageRoute(builder: (context) => Home_with_login()));
                                          }
                                        },
                                        child: Text(
                                          "REGISTER!",
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                              fontSize: 5.sp,
                                              color: const Color.fromRGBO(15, 27, 97, 1)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(children: [
                            SizedBox(height: 6, width: MediaQuery.of(context).size.width, child: DecoratedBox(decoration: BoxDecoration(color: Color.fromARGB(255, 255, 205, 57))),),
                            Center(
                              child: 
                              SizedBox(
                                child: DecoratedBox(
                                  decoration: 
                                  BoxDecoration(color: Colors.transparent), 
                                  child: Text("OR", style: GoogleFonts.openSans(color: Color.fromRGBO(15, 27, 97, 1), fontWeight: FontWeight.bold, fontSize: 18),))))
                          ]),
                            
                              //************************************************************************************************ */
                          
                          
                          
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: ElevatedButton(
                              onPressed: () async {
                                //**GOOGLE SIGN IN ER KHETRE CHECK IF ACCOUNT EXISTS DORKAR NEI */
                                await signInWithGoogle(context).then((value) {});
                                if(google_sign_in_credentials.google_Email == "") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                            }

                            else {
                              var data = utf8.encode(google_sign_in_credentials.google_Email); // data being hashed
                            var hashvalue = sha1.convert(data);
                            
                            postRequest(google_sign_in_credentials.google_Email, hashvalue.toString());

                            if(this.mounted)
                            setState(() {
                              sharedPref.set_user(email);
                              Provider.of<logged_in_user_provider>(context, listen: false).set_user_email_for_provider(google_sign_in_credentials.google_Email);
                            });

                            Fluttertoast.showToast( 
                              msg: "LOGGED IN SUCCESSFULLY!", timeInSecForIosWeb: 5, 
                              textColor: Colors.black);
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => Home_with_login()));
                            }
                            }, 
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548355/google_logo_y3rhdp.png", 
                                      height: MediaQuery.of(context).size.height * 0.02, 
                                      width: MediaQuery.of(context).size.width * 0.02,),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.001),
                                  Text("Google", style: GoogleFonts.openSans(fontWeight: FontWeight.bold, 
                                        fontSize: (MediaQuery.of(context).size.width > 500) ? 10 : 8),),
                                ],
                              ),
                              
                            ),
                          ),
                            
                            
                        ],
                      ),
                    ),
                              ),
                  ),
          
                  
                  Positioned(
                    top: 100,
                    left: 200,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687548780/bee_signup_piopfy.riv", stateMachines: ['State Machine 1'],),
                    ),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
}
