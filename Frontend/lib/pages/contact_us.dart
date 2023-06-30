import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/pages/my_bookings.dart';
import 'package:bus_book/pages/offers.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bus_book/pages/signup.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

void main() => runApp(const contact_us());

class contact_us extends StatefulWidget {
  const contact_us({super.key});

  @override
  State<contact_us> createState() => _contact_usState();
}

class _contact_usState extends State<contact_us> {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

//*   ------------------------------------------------------------------------------------------------------------------------

String name = "", email = "", message = "";
var nameValidator = MultiValidator([
  RequiredValidator(errorText: "Name can't be empty!"),
  //PatternValidator(RegExp('[0-9]'), errorText: "Name can't contain Numbers!")
]);

var emailValidator = MultiValidator([
  RequiredValidator(errorText: "Email can't be empty!"),
  EmailValidator(errorText: "Enter valid email!")
]);

var messageValidator = MultiValidator([
  RequiredValidator(errorText: "Message can't be empty!"),
]);

var nameController = TextEditingController();

var emailController = TextEditingController();

var messageController = TextEditingController();


Future<void> addMessage() async {
  try {
    await FirebaseFirestore.instance.collection('User Messages').add({
      'Name': name,
      'Email': email,
      'Message': message,
    });
    print('Message added successfully!');
  } catch (e) {
    print('Error adding message: $e');
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _isOpen1 = false;
  bool _isOpen2 = false;
  bool _isOpen3 = false;
  bool _isOpen4 = false;
  bool _isOpen5 = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    bool is_wa_logo_hovered = false;
    String logged_in_user_email = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    
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
                    height: MediaQuery.of(context).size.height * 1.5,
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
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: 70,
                  child: Row(
                    children: [
                      
                      Container(
                        height: MediaQuery.of(context).size.height * 0.87,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                        child: AlertDialog(
                          alignment: Alignment.topLeft,
                          scrollable: true,
                          shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(32.0))),
                          backgroundColor:  Color.fromARGB(255, 212, 237, 255),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.12,
                                        width: MediaQuery.of(context).size.width * 0.12,
                                        child: const RiveAnimation.network('https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549053/message_icon_xkxfqt.riv', stateMachines: ['State Machine 1'],))),
                                Center(
                                    child: Text("Write to Us!",
                                        style: GoogleFonts.openSans(
                                            fontSize: 25, color: const Color.fromRGBO(15, 27, 97, 1), fontWeight: FontWeight.bold))),
                      
                      
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04, width: MediaQuery.of(context).size.width * 0.02,),
                                //* name ->
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                                  ],
                                  //enabled: false,
                                  //initialValue: "${currentEmployee.jobID}     [Job ID]",
                                  style: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      //fontFamily: 'Cirka',
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10),
                                  //obscureText: false,
                                  controller: nameController,
                                  validator: nameValidator,
                                  onChanged: (value) => name = value,
                                  cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.badge_outlined),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    //fillColor: Color.fromRGBO(15, 27, 97, 1),
                                    
                                    filled: true,
                                    hintText: 'Enter your Name...',
                                    hintStyle: TextStyle(
                                      color: const Color.fromRGBO(36, 45, 98, 1),
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10,
                                      //fontFamily: 'Cirka',
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                ),
                        
                        
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04, width: MediaQuery.of(context).size.width * 0.04,),
                                //* email ->
                        
                                TextFormField(
                                  style: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      fontFamily: 'Cirka',
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10),
                                  obscureText: false,
                                  cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                  controller: emailController,
                                  onChanged: (value) => email = value,
                                  validator: emailValidator,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.email_outlined),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    //fillColor: Colors.black,
                                    filled: true,
                                    hintText: 'Enter your Email...',
                                    hintStyle: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10,
                                      //fontFamily: 'Cirka',
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                ),
                        
                        
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04, width: MediaQuery.of(context).size.width * 0.04,),
                                //* meassage ->
                                TextFormField(
                                  style: TextStyle(
                                      //color: Colors.white,
                                      //fontFamily: 'Cirka',
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10),
                                  obscureText: false,
                                  cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                  controller: messageController,
                                  onChanged: (value) => message = value,
                                  validator: messageValidator,
                                  decoration: InputDecoration(
                                    
                                    icon: const Icon(Icons.chat_outlined),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    //fillColor: Colors.black,
                                    filled: true,
                                    hintText: 'Enter your Message...',
                                    hintStyle: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10,
                                      //fontFamily: 'Cirka',
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                  maxLines: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(20),
                                        //primary: Color.fromRGBO(236, 200, 246, 1),
                                        side: const BorderSide(
                                            color: Color.fromRGBO(12, 0, 252, 1), width: 3),
                                        textStyle: const TextStyle(
                                            fontSize: 20, fontStyle: FontStyle.normal),
                                        backgroundColor: const Color.fromRGBO(245, 210, 255, 1),
                                        foregroundColor: const Color.fromRGBO(12, 0, 252, 1),
                                      ),
                                      onPressed: () async {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            addMessage();
                                            _formKey.currentState!.reset();
                                            EasyLoading.showSuccess('Message Sent!', dismissOnTap: true, duration: Duration(milliseconds: 700));
                                          }
                                          catch(e) {
                                            EasyLoading.showError(e.toString());
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Submit!",
                                        style: GoogleFonts.sanchez(
                                            fontSize: 20, color: const Color.fromRGBO(15, 27, 97, 1)),
                                      ),
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
          
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    width: MediaQuery.of(context).size.height * 0.05,
                                    child: InkWell(
                                      child: Image.network('https://res.cloudinary.com/dvypswxcv/image/upload/v1687790919/whatsapp_logo_frjicb.png'),
                                      onTap: () async {
                                          const u = 'https://api.whatsapp.com/send?phone=917586082138';
                                          final ui = Uri.parse(u);
                                          if (await canLaunchUrl(ui)) {
                                            await launchUrl(ui);
                                          } else {
                                            throw 'Url could not be launched';
                                          }
                                        },
                                      ),
                        
                               ),
          
                               SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                               InkWell(
                                onTap: () async {
                                          const u = 'https://mail.google.com/mail/u/0/?fs=1&to=arghyadipsengupta@gmail.com&tf=cm';
                                          final ui = Uri.parse(u);
                                          if (await canLaunchUrl(ui)) {
                                            await launchUrl(ui);
                                          } else {
                                            throw 'Url could not be launched';
                                          }
                                        },
                                 child: Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548283/gmail_lrshvz.png",  
                                          height: MediaQuery.of(context).size.height * 0.040,
                                          width: MediaQuery.of(context).size.width * 0.040,
                                          ),
                               )
                                  ],
                                ),
          
                                
                              ],
                            ),
                          ),
                          ),
                          
                        ),
                      ),
          
          
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
          
          
          
          
                      Column(
                        children: [
                          SizedBox(height: 100,),

                          Container(
                  height: 800,
                  child: SingleChildScrollView(
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.start, 
                                children: [
                                  Text("Frequently Asked Questions (FAQs)", 
                                          style: GoogleFonts.openSans(color: Colors.white, 
                                          fontSize: MediaQuery.of(context).size.width * 0.02, 
                                          fontWeight: FontWeight.bold),),
                                        
                                  Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548219/faq_logo_ulujmi.gif", 
                                            height: MediaQuery.of(context).size.height * 0.15, 
                                            width: MediaQuery.of(context).size.width * 0.15,)     
                                    ],
                                ),
                  
                            SizedBox(height: 10,),
                  
                            Container(height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                      ),
                                              child: Row(children: [
                                                  InkWell(
                                                  onTap: () {
                                                    if(this.mounted)
                                                    setState(() {
                                                      _isOpen1 = !_isOpen1;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        _isOpen1 ? Icons.remove : Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 8),
                                                      (_isOpen1) ? Text(
                                                        "What is Bus Booker?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: MediaQuery.of(context).size.width * 0.01,
                                                        ),
                                                      ) : Text("What is Bus Booker?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width * 0.015,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                  
                                                if (_isOpen1)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 24),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .2,
                                                        child: Text("It is an online bus booking website, where you can choose your seat, buses based on boarding points, date and destination points, cancel your ticket and rate your journey", style: GoogleFonts.openSans(color: Colors.white))),
                                                    ),
                  
                                              ]),),),
                  
                                          
                                        SizedBox(height: 10,),
                  
                            Container(height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                      ),
                                              child: Row(children: [
                                                  InkWell(
                                                  onTap: () {
                                                    if(this.mounted)
                                                    setState(() {
                                                      _isOpen2 = !_isOpen2;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        _isOpen2 ? Icons.remove : Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 8),
                                                      (_isOpen2) ? Text(
                                                        "Do I need to register to use Bus Booker?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: MediaQuery.of(context).size.width * 0.01,
                                                        ),
                                                      ) : Text("Do I need to register to use Bus Booker?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width * 0.015,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                  
                                                if (_isOpen2)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 24),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .2,
                                                        child: Text("To book a ticket, you need to register. But for checking if bus exists for that route, you don't need to register", style: GoogleFonts.openSans(color: Colors.white))),
                                                    ),
                  
                                              ]),),),
                  
                  
                                              SizedBox(height: 10,),
                  
                            Container(height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                      ),
                                              child: Row(children: [
                                                  InkWell(
                                                  onTap: () {
                                                    if(this.mounted)
                                                    setState(() {
                                                      _isOpen3 = !_isOpen3;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        _isOpen3 ? Icons.remove : Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 8),
                                                      (_isOpen3) ? Text(
                                                        "How do I pay for a ticket?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width * 0.01,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ) : Text("How do I pay for a ticket?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width * 0.015,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                  
                                                if (_isOpen3)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 24),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .2,
                                                        child: Text("We accept e-payment (UPI, Debit / Credit Cards, Net Banking) via Razorpay payment gateway.", style: GoogleFonts.openSans(color: Colors.white))),
                                                    ),
                  
                                              ]),),),
                  
                  
                                              SizedBox(height: 10,),
                  
                            Container(height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                      ),
                                              child: Row(children: [
                                                  InkWell(
                                                  onTap: () {
                                                    if(this.mounted)
                                                    setState(() {
                                                      _isOpen4 = !_isOpen4;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        _isOpen4 ? Icons.remove : Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 8),
                                                      (_isOpen4) ? Text(
                                                        "How can you contact us?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width * 0.01,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ) : Text("How can you contact us?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width * 0.015,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                  
                                                if (_isOpen4)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 24),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .2,
                                                        child: Text("For any query, you may contact us by filling the form in the left. Alternatively, you can mail or call us.", style: GoogleFonts.openSans(color: Colors.white))),
                                                    ),
                  
                                              ]),),),
                  
                  
                                              SizedBox(height: 10,),
                  
                            Container(height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                      ),
                                              child: Row(children: [
                                                  InkWell(
                                                  onTap: () {
                                                    if(this.mounted)
                                                    setState(() {
                                                      _isOpen5 = !_isOpen5;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        _isOpen5 ? Icons.remove : Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 8),
                                                      (_isOpen5) ? Text(
                                                        "Is any other bookings available?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: MediaQuery.of(context).size.width * 0.01,
                                                        ),
                                                      ) : Text("Is any other bookings available?",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width * 0.015,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                  
                                                if (_isOpen5)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 24),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .1,
                                                        child: Text("Sorry, currently we only serve bus bookings.", 
                                                                  style: GoogleFonts.openSans(color: Colors.white, 
                                                                  ))),
                                                    ),
                  
                                              ]),),),
                            ],
                    ),
                  ),
                ),
                        ],
                      )
          
          
          
          
                    ],
                  ),
                ),
          
                
              
          
          
          
          ]
            ),
          ],
        ),
      ),
    )
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
          children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 2.5,
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
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => offers())),
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
                  //left: 180,
                  top: MediaQuery.of(context).size.width * 0.15,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.87,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                        child: AlertDialog(
                          alignment: Alignment.topLeft,
                          scrollable: true,
                          shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(32.0))),
                          backgroundColor:  Color.fromARGB(255, 212, 237, 255),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.12,
                                        width: MediaQuery.of(context).size.width * 0.12,
                                        child: const RiveAnimation.network('https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549053/message_icon_xkxfqt.riv', stateMachines: ['State Machine 1'],))),
                                Center(
                                    child: Text("Write to Us!",
                                        style: GoogleFonts.openSans(
                                            fontSize: 25, color: const Color.fromRGBO(15, 27, 97, 1), fontWeight: FontWeight.bold))),
                      
                      
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04, width: MediaQuery.of(context).size.width * 0.02,),
                                //* name ->
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                                  ],
                                  //enabled: false,
                                  //initialValue: "${currentEmployee.jobID}     [Job ID]",
                                  style: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      //fontFamily: 'Cirka',
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10),
                                  //obscureText: false,
                                  controller: nameController,
                                  validator: nameValidator,
                                  onChanged: (value) => name = value,
                                  cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.badge_outlined),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    //fillColor: Color.fromRGBO(15, 27, 97, 1),
                                    
                                    filled: true,
                                    hintText: 'Enter your Name...',
                                    hintStyle: TextStyle(
                                      color: const Color.fromRGBO(36, 45, 98, 1),
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10,
                                      //fontFamily: 'Cirka',
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                ),
                        
                        
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04, width: MediaQuery.of(context).size.width * 0.04,),
                                //* email ->
                        
                                TextFormField(
                                  style: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      fontFamily: 'Cirka',
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10),
                                  obscureText: false,
                                  cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                  controller: emailController,
                                  onChanged: (value) => email = value,
                                  validator: emailValidator,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.email_outlined),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    //fillColor: Colors.black,
                                    filled: true,
                                    hintText: 'Enter your Email...',
                                    hintStyle: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10,
                                      //fontFamily: 'Cirka',
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                ),
                        
                        
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04, width: MediaQuery.of(context).size.width * 0.04,),
                                //* meassage ->
                                TextFormField(
                                  style: TextStyle(
                                      //color: Colors.white,
                                      //fontFamily: 'Cirka',
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10),
                                  obscureText: false,
                                  cursorColor: const Color.fromRGBO(15, 27, 97, 1),
                                  controller: messageController,
                                  onChanged: (value) => message = value,
                                  validator: messageValidator,
                                  decoration: InputDecoration(
                                    
                                    icon: const Icon(Icons.chat_outlined),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    //fillColor: Colors.black,
                                    filled: true,
                                    hintText: 'Enter your Message...',
                                    hintStyle: TextStyle(
                                      color: const Color.fromRGBO(15, 27, 97, 1),
                                      fontSize:
                                          (MediaQuery.of(context).size.width > 1000) ? 20 : 10,
                                      //fontFamily: 'Cirka',
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                  maxLines: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(20),
                                        //primary: Color.fromRGBO(236, 200, 246, 1),
                                        side: const BorderSide(
                                            color: Color.fromRGBO(12, 0, 252, 1), width: 3),
                                        textStyle: const TextStyle(
                                            fontSize: 20, fontStyle: FontStyle.normal),
                                        backgroundColor: const Color.fromRGBO(245, 210, 255, 1),
                                        foregroundColor: const Color.fromRGBO(12, 0, 252, 1),
                                      ),
                                      onPressed: () async {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            addMessage();
                                            _formKey.currentState!.reset();
                                            EasyLoading.showSuccess('Message Sent!', dismissOnTap: true, duration: Duration(milliseconds: 700));
                                          }
                                          catch(e) {
                                            EasyLoading.showError(e.toString());
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Submit!",
                                        style: GoogleFonts.sanchez(
                                            fontSize: 20, color: const Color.fromRGBO(15, 27, 97, 1)),
                                      ),
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
      
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.height * 0.04,
                                    child: InkWell(
                                      child: Image.network('https://res.cloudinary.com/dvypswxcv/image/upload/v1687790919/whatsapp_logo_frjicb.png'),
                                      onTap: () async {
                                          const u = 'https://api.whatsapp.com/send?phone=917586082138';
                                          final ui = Uri.parse(u);
                                          if (await canLaunchUrl(ui)) {
                                            await launchUrl(ui);
                                          } else {
                                            throw 'Url could not be launched';
                                          }
                                        },
                                      ),
                        
                               ),
      
                               SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                               InkWell(
                                onTap: () async {
                                          const u = 'https://mail.google.com/mail/u/0/?fs=1&to=arghyadipsengupta@gmail.com&tf=cm';
                                          final ui = Uri.parse(u);
                                          if (await canLaunchUrl(ui)) {
                                            await launchUrl(ui);
                                          } else {
                                            throw 'Url could not be launched';
                                          }
                                        },
                                 child: Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548283/gmail_lrshvz.png",  
                                          height: MediaQuery.of(context).size.height * 0.040,
                                          width: MediaQuery.of(context).size.width * 0.040,
                                          ),
                               )
                                  ],
                                ),
                                
                                
                              ],
                            ),
                          ),
                          ),
                          
                        ),
                      ),
      
      
      
      
                      Container(
                  height: 800,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.start, 
                            children: [
                              Text("Frequently Asked Questions (FAQs)", 
                                      style: GoogleFonts.openSans(color: Colors.white, 
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      fontWeight: FontWeight.bold),),
                                    
                              Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548219/faq_logo_ulujmi.gif", 
                                            height: MediaQuery.of(context).size.height * 0.15, 
                                            width: MediaQuery.of(context).size.width * 0.15,)    
                                ],
                            ),
                  
                        SizedBox(height: 10,),
                  
                        Container(height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DecoratedBox(decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                  ),
                                          child: Row(children: [
                                              InkWell(
                                              onTap: () {
                                                if(this.mounted)
                                                setState(() {
                                                  _isOpen1 = !_isOpen1;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    _isOpen1 ? Icons.remove : Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 8),
                                                  (_isOpen1) ? Text(
                                                    "What is Bus Booker?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width * 0.02,
                                                    ),
                                                  ) : Text("What is Bus Booker?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.025,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ],
                                              ),
                                            ),
                  
                                            if (_isOpen1)
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 24),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * .2,
                                                    child: Text("It is an online bus booking website, where you can choose your seat, buses based on boarding points, date and destination points, cancel your ticket and rate your journey", 
                                                                style: GoogleFonts.openSans(
                                                                color: Colors.white,
                                                                fontSize: 10,),)),
                                                ),
                  
                                          ]),),),
                  
                                      
                                    SizedBox(height: 10,),
                  
                        Container(height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DecoratedBox(decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                  ),
                                          child: Row(children: [
                                              InkWell(
                                              onTap: () {
                                                if(this.mounted)
                                                setState(() {
                                                  _isOpen2 = !_isOpen2;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    _isOpen2 ? Icons.remove : Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 8),
                                                  (_isOpen2) ? Text(
                                                    "Do I need to register to use Bus Booker?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width * 0.02,
                                                    ),
                                                  ) : Text("Do I need to register to use Bus Booker?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.025,                                                      
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ],
                                              ),
                                            ),
                  
                                            if (_isOpen2)
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 24),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * .2,
                                                    child: Text("To book a ticket, you need to register. But for checking if bus exists for that route, you don't need to register", style: GoogleFonts.openSans(fontSize: 10, color: Colors.white))),
                                                ),
                  
                                          ]),),),
                  
                  
                                          SizedBox(height: 10,),
                  
                        Container(height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DecoratedBox(decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                  ),
                                          child: Row(children: [
                                              InkWell(
                                              onTap: () {
                                                if(this.mounted)
                                                setState(() {
                                                  _isOpen3 = !_isOpen3;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    _isOpen3 ? Icons.remove : Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 8),
                                                  (_isOpen3) ? Text(
                                                    "How do I pay for a ticket?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width * 0.02,
                                                    ),
                                                  ) : Text("How do I pay for a ticket?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.025,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ],
                                              ),
                                            ),
                  
                                            if (_isOpen3)
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 24),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * .2,
                                                    child: Text("We accept e-payment (UPI, Debit / Credit Cards, Net Banking) via Razorpay payment gateway.", style: GoogleFonts.openSans(fontSize: 10, color: Colors.white))),
                                                ),
                  
                                          ]),),),
                  
                  
                                          SizedBox(height: 10,),
                  
                        Container(height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DecoratedBox(decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                  ),
                                          child: Row(children: [
                                              InkWell(
                                              onTap: () {
                                                if(this.mounted)
                                                setState(() {
                                                  _isOpen4 = !_isOpen4;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    _isOpen4 ? Icons.remove : Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 8),
                                                  (_isOpen4) ? Text(
                                                    "How can you contact us?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width * 0.02,
                                                    ),
                                                  ) : Text("How can you contact us?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.025,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ],
                                              ),
                                            ),
                  
                                            if (_isOpen4)
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 24),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * .2,
                                                    child: Text("For any query, you may contact us by filling the form in the left. Alternatively, you can mail or call us.", style: GoogleFonts.openSans(fontSize: 10, color: Colors.white))),
                                                ),
                  
                                          ]),),),
                  
                  
                                          SizedBox(height: 10,),
                  
                        Container(height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DecoratedBox(decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                  ),
                                          child: Row(children: [
                                              InkWell(
                                              onTap: () {
                                                if(this.mounted)
                                                setState(() {
                                                  _isOpen5 = !_isOpen5;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    _isOpen5 ? Icons.remove : Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 8),
                                                  (_isOpen5) ? Text(
                                                    "Is any other bookings available?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width * 0.02,
                                                    ),
                                                  ) : Text("Is any other bookings available?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.025,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ],
                                              ),
                                            ),
                  
                                            if (_isOpen5)
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 24),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * .2,
                                                    child: Text("Sorry, currently we only serve bus bookings.", style: GoogleFonts.openSans(fontSize: 10, color: Colors.white))),
                                                ),
                  
                                          ]),),),
                        ],
                    ),
                  ),
                )
                    ],
                  ),
                ),
      
                
              
      
      
      
          ]
            ),
          ],
        ),
      ),
    )
    );
    }
  );
  }
  }
}
