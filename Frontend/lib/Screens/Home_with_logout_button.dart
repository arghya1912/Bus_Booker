import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:bus_book/Screens/SplashScreen.dart';
import 'package:bus_book/pages/bus_schedule.dart';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/login.dart';
import 'package:bus_book/pages/my_bookings.dart';
import 'package:bus_book/pages/offers.dart';
import 'package:bus_book/pages/signup.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';
import '../globals.dart' as globals;
import '../models/bus_name_cards_with_login.dart';
import '../networks/http_requests_for_backend.dart';

final List<String> _suggestions = [
  'Asansol',
  'Bankura',
  'Barasat',
  'Basirhat',
  'Durgapur',
  'Karunamoyee',
  'Siliguri'
];

String FROM = "";
String TO = "";


class Home_with_login extends StatefulWidget {
  const Home_with_login({super.key});

  @override
  State<Home_with_login> createState() => _Home_with_loginState();
}

class _Home_with_loginState extends State<Home_with_login> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateEditingController = TextEditingController();
  TextEditingController _sourceEditingController = TextEditingController();
  TextEditingController _destiEditingController = TextEditingController();
  TextEditingController _tempEditingController = TextEditingController();
  String? selectedValue = "";
 
  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  Future<void> bus_details_get(String source, String destination, String date) async {
  var url = Uri.parse(base_url + 'search_bus/' + source + '/' + destination + '/' + getWeekday(date).toString() + '/' + date);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    //print(jsonResponse);


    final busRoutes = BusRoutes.fromJson(jsonDecode(response.body));
    Navigator.push(context, MaterialPageRoute(builder: (context) => BusNameCards(busRoutes: busRoutes, source: source, destination: destination, date: date)));
    } else {
      throw Exception('Failed to load bus routes');
    }
}
final TextEditingController _textEditingController = TextEditingController();
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _filteredSuggestions = _suggestions;
    _textEditingController.addListener(() {
      if(this.mounted)
      setState(() {
        _filteredSuggestions = _suggestions.where((suggestion) {
          return suggestion.toLowerCase().contains(_textEditingController.text.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String logged_in_user_email = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    String username = logged_in_user_email.substring(0, logged_in_user_email.indexOf('@'));

    if(MediaQuery.of(context).size.width > 900) {
    return Sizer( builder: (context, orientation, deviceType) {
      
    return Scaffold(
      

      body: Column(
        children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://res.cloudinary.com/dvypswxcv/image/upload/v1687547918/Background_bus_debtoh.jpg"),
                      fit: BoxFit.cover)),
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
              top: 220,
              left: 110,
              child: Row(
                children: [
                  Text(
                    "STOP LOOKING.",
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 270,
              left: 110,
              child: Row(
                children: [
                  Text(
                    "START BOOKING!",
                    style: GoogleFonts.openSans(
                        color: Color.fromRGBO(255, 61, 85, 1),
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 340,
              left: 115,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'An online Bus Ticket Booking Platform,',
                    textStyle: GoogleFonts.openSans(
                      fontSize: 4.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Trusted by countless users!',
                    textStyle: GoogleFonts.openSans(
                      fontSize: 4.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                pause: const Duration(milliseconds: 140),
                repeatForever: true,
                stopPauseOnTap: true,
                onTap: () {
                  //print("Tap Event");
                },
              ),
            ),


            Positioned(
              top: 390,
              left: 110,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                    ),
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.15,
                   // color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.14,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: TextField(
                                      textAlign: TextAlign.start,
                                      controller: _sourceEditingController,
                                      cursorColor: Color.fromARGB(255, 255, 255, 255),
                                      style: TextStyle( color: Color.fromARGB(255, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'FROM',
                                        labelStyle: TextStyle(
                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                    fontSize: 2.5.sp),
                                        //suffixIcon: 
                                      ),
                                    ),
                              ),
                                      
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text('SELECT SOURCE', 
                                                        style: GoogleFonts.openSans(
                                                          color: Colors.blue, 
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 3.sp
                                                          ),),
                                            
                                            value: null,
                                            onChanged: (newValue) {
                                              if(this.mounted)
                                              setState(() {
                                                selectedValue = newValue;
                                                _sourceEditingController.text = newValue??"";
                                                _textEditingController.text = _sourceEditingController.text;
                                                _filteredSuggestions = _suggestions;
                                              });
                                            },
                                            items: _filteredSuggestions.map((suggestion) {
                                              return DropdownMenuItem(
                                                child: Text(suggestion),
                                                value: suggestion,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),



                  InkWell(
                    child: Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548422/swap_arrow_q3psuu.png", height: 40, width: 40,),
                    onTap: () {
                      _tempEditingController = _sourceEditingController;
                      _sourceEditingController = _destiEditingController;
                      _destiEditingController = _tempEditingController;
                      if(this.mounted)
                      setState(() {
                        
                      });
                    },
                  ),






            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
              ),
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.17,
             // color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                  
                        //Padding(padding: EdgeInsets.fromLTRB(55, 5, 80, 0), child: Icon(Icons.location_city_outlined, color: Color.fromARGB(255, 213, 207, 207), size: 42)),
                        
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: TextField(
                                textAlign: TextAlign.start,
                                controller: _destiEditingController,
                                cursorColor: Color.fromARGB(255, 255, 255, 255),
                                style: TextStyle( color: Color.fromARGB(255, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'TO',
                                  labelStyle: TextStyle(
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontSize: 3.sp),
                                  //suffixIcon: 
                                ),
                              ),
                        ),
                                
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Text('SELECT DESTINATION', style: GoogleFonts.openSans(
                                                        color: Colors.blue, 
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 3.sp
                                                        ),),
                                      
                                      value: null,
                                      onChanged: (newValue) {
                                        if(this.mounted)
                                        setState(() {
                                          selectedValue = newValue;
                                          _destiEditingController.text = newValue??"";
                                          _textEditingController.text = _destiEditingController.text;
                                          _filteredSuggestions = _suggestions;
                                        });
                                      },
                                      items: _filteredSuggestions.map((suggestion) {
                                        return DropdownMenuItem(
                                          child: Text(suggestion),
                                          value: suggestion,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),

          
                ],
              ),
            ),



                ],
              ),
            ),

            

            

            
            

            Positioned(
              top: 530,
              left: 110,
              child: Row(
                children: [

                  Container(
                    color: Colors.transparent,
                     width: MediaQuery.of(context).size.width * 0.15,
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                        Text("Check bus schedule", style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 4.sp),),


                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        ElevatedButton( 
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => bus_schedule())), 
                          child: Text("CLICK HERE", style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 4.sp),))
                      ],
                    ),
                  ),


                  SizedBox(width: MediaQuery.of(context).size.width * 0.022,),


                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                          child: Text("DATE", style: GoogleFonts.openSans(color: Colors.white, fontSize: 3.sp, fontWeight: FontWeight.bold),),
                        ),
                       
                        GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: selectedDate,
                                    lastDate: selectedDate.add(Duration(days: 5)),
                                  );
                                  if (picked != null && picked != selectedDate)
                                  if(this.mounted)
                                    setState(() {
                                      selectedDate = picked;
                                      _dateEditingController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                    });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextFormField(
                                    controller: _dateEditingController,
                                    onTap: () async {
                                      final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: selectedDate,
                                        lastDate: selectedDate.add(Duration(days: 30)),
                                      );
                                      if (picked != null && picked != selectedDate)
                                      if(this.mounted)
                                        setState(() {
                                          selectedDate = picked;
                                          _dateEditingController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                        });
                                    },
                                    cursorColor: Color.fromARGB(255, 255, 255, 255),
                                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'SELECT DATE',
                                      labelStyle: TextStyle(fontSize: 3.2.sp, color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),









            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.04,
              child: DecoratedBox(
                
                child: Center(
                  child: InkWell(
                    onTap: () =>
                    (_sourceEditingController.text == "" || _destiEditingController.text == "" || _dateEditingController.text == "") ? 
                    Fluttertoast.showToast(
                             msg: "PLEASE ENTER ALL THE THREE FIELDS!", timeInSecForIosWeb: 5,
                             webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                             textColor: Colors.white
                     ) :
                    (_sourceEditingController.text == _destiEditingController.text) ? 
                    Fluttertoast.showToast(
                             msg: "SOURCE AND DESTINATION CAN'T BE THE SAME!", timeInSecForIosWeb: 5,
                             webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                             textColor: Colors.white
                     )  :
                     bus_details_get(_sourceEditingController.text, _destiEditingController.text, _dateEditingController.text),
                    child: Icon(Icons.east_outlined, size: 40, color: Colors.white,),
                  ),
                ),
                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(255, 61, 85, 1).withOpacity(0.8)
              ),
                ),
            ),







                ],
              ),
            ),


          ]),

         
        ],
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
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              Stack(children: [
                Container(
              height: MediaQuery.of(context).size.height * 1.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://res.cloudinary.com/dvypswxcv/image/upload/v1687547918/Background_bus_debtoh.jpg"),
                      fit: BoxFit.cover)),
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
                  top: 200,
                  left: 20,
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                              Text(
                                "STOP LOOKING.",
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),


                        Text(
                          "START BOOKING!",
                          style: GoogleFonts.openSans(
                              color: Color.fromRGBO(255, 61, 85, 1),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),


                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'An online Bus Ticket Booking Platform,',
                      textStyle: GoogleFonts.openSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Trusted by countless users!',
                      textStyle: GoogleFonts.openSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  pause: const Duration(milliseconds: 140),
                  repeatForever: true,
                  stopPauseOnTap: true,
                  onTap: () {
                    //print("Tap Event");
                  },
                ),


                SizedBox(height: 10,),


                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  ),
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.5,
                 // color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                                                  
                            Padding(
                              padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
                              child: TextField(
                                    textAlign: TextAlign.start,
                                    controller: _sourceEditingController,
                                    cursorColor: Color.fromARGB(255, 255, 255, 255),
                                    style: TextStyle( color: Color.fromARGB(255, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'FROM',
                                      labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255), 
                                                            fontSize: 8.sp),
                                    ),
                                  ),
                            ),
                                    
                                Padding(
                                  padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text('SELECT SOURCE', style: GoogleFonts.openSans(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 8.sp),),
                                          
                                          value: null,
                                          onChanged: (newValue) {
                                            if(this.mounted)
                                            setState(() {
                                              selectedValue = newValue;
                                              _sourceEditingController.text = newValue??"";
                                              _textEditingController.text = _sourceEditingController.text;
                                              _filteredSuggestions = _suggestions;
                                            });
                                          },
                                          items: _filteredSuggestions.map((suggestion) {
                                            return DropdownMenuItem(
                                              child: Text(suggestion),
                                              value: suggestion,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),



                InkWell(
                  child: Image.network("https://res.cloudinary.com/dvypswxcv/image/upload/v1687548470/swap_arrow_vertical_rr0xpf.png", height: 40, width: 40,),
                  onTap: () {
                    _tempEditingController = _sourceEditingController;
                    _sourceEditingController = _destiEditingController;
                    _destiEditingController = _tempEditingController;
                    if(this.mounted)
                    setState(() {
                      
                    });
                  },
                ),



                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  ),
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.5,
                 // color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                      
                            
                            Padding(
                              padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
                              child: TextField(
                                    textAlign: TextAlign.start,
                                    controller: _destiEditingController,
                                    cursorColor: Color.fromARGB(255, 255, 255, 255),
                                    style: TextStyle( color: Color.fromARGB(255, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'TO',
                                      labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                                                            fontSize: 8.sp),
                                      //suffixIcon: 
                                    ),
                                  ),
                            ),
                                    
                                Padding(
                                  padding: EdgeInsets.fromLTRB(55, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text('SELECT DESTINATION', 
                                                    style: GoogleFonts.openSans(
                                                      color: Colors.blue, fontWeight: FontWeight.bold,
                                                              fontSize: 8.sp),),
                                          
                                          value: null,
                                          onChanged: (newValue) {
                                            if(this.mounted)
                                            setState(() {
                                              selectedValue = newValue;
                                              _destiEditingController.text = newValue??"";
                                              _textEditingController.text = _destiEditingController.text;
                                              _filteredSuggestions = _suggestions;
                                            });
                                          },
                                          items: _filteredSuggestions.map((suggestion) {
                                            return DropdownMenuItem(
                                              child: Text(suggestion),
                                              value: suggestion,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ),
                      ),
        
              
                    ],
                  ),
                ),


                SizedBox(height: 15,),


                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  ),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("DATE", style: GoogleFonts.openSans(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),),
                     
                      Padding(
                        padding: const EdgeInsets.fromLTRB(70, 15, 0, 0),
                        child: GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: selectedDate,
                                    lastDate: selectedDate.add(Duration(days: 5)),
                                  );
                                  if (picked != null && picked != selectedDate)
                                  if(this.mounted)
                                    setState(() {
                                      selectedDate = picked;
                                      _dateEditingController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                    });
                                },
                                child: TextFormField(
                                  controller: _dateEditingController,
                                  onTap: () async {
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: selectedDate,
                                      lastDate: selectedDate.add(Duration(days: 30)),
                                    );
                                    if (picked != null && picked != selectedDate)
                                    if(this.mounted)
                                      setState(() {
                                        selectedDate = picked;
                                        _dateEditingController.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                      });
                                  },
                                  cursorColor: Color.fromARGB(255, 255, 255, 255),
                                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'SELECT DATE',
                                    labelStyle: TextStyle(color: Colors.blue,
                                                          fontSize: 8.sp),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),




                Row(
                  children: [
                    Container(
                      color: Colors.transparent,
                       width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                          Text("Check bus schedule", style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.sp),),
        
        
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          ElevatedButton( onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => bus_schedule())), child: Text("CLICK HERE", style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 8.sp),))
                        ],
                      ),
                    ),

                    SizedBox(width: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.17,
                      child: DecoratedBox(
                        
                        child: Center(
                          child: InkWell(
                            onTap: () =>
                            (_sourceEditingController.text == "" || _destiEditingController.text == "" || _dateEditingController.text == "") ? 
                            Fluttertoast.showToast(
                                     msg: "PLEASE ENTER ALL THE THREE FIELDS!", timeInSecForIosWeb: 5,
                                     webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                     textColor: Colors.white
                             ) :
                            (_sourceEditingController.text == _destiEditingController.text) ? 
                            Fluttertoast.showToast(
                                     msg: "SOURCE AND DESTINATION CAN'T BE THE SAME!", timeInSecForIosWeb: 5,
                                     webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                     textColor: Colors.white
                             )  :
                             bus_details_get(_sourceEditingController.text, _destiEditingController.text, _dateEditingController.text),
                            child: Icon(Icons.east_outlined, size: 40, color: Colors.white,),
                          ),
                        ),
                        decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(255, 61, 85, 1).withOpacity(0.8)
                      ),
                        ),
                    ),


                  ],
                ),


                    ],
                  ),
                ),

                
                
                
        
        
                
        


                
        
                
        
                
                
        
                
        
                
        
        
                
        
        
                
        
        
              ]),
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