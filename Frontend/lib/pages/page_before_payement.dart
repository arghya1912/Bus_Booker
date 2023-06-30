import 'dart:convert';
import 'dart:html' as html;
import 'package:bus_book/pages/offers.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/networks/http_requests_for_backend.dart';
import 'package:bus_book/pages/contact_us.dart';
import 'package:bus_book/pages/my_bookings.dart';
import 'package:bus_book/providers/bus_id_provider.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bus_book/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
class page_before_payment extends StatefulWidget {

  final Set<dynamic> finalSeats;
  final String source;
  final String destination;
  final String date;

  const page_before_payment({Key? key, required this.finalSeats, required this.source, required this.destination, required this.date}) : super(key: key);

  @override
  State<page_before_payment> createState() => _page_before_paymentState();
}

int no_of_tickets_booked = 0, bus_id = 0, cash = 0;
String coupon = "";
bool is_redeemed = false;
double amount_to_be_subtracted = 0.0;
String email = "", user_id = "";
String username = "", bus_name = "";
final List<dynamic> temp = [];
class _page_before_paymentState extends State<page_before_payment> {
  Razorpay? _razorpay;
  
  Future send_ticket_to_email({required String email}) async{
  final serviceId = "service_h08xxb9";
  final templateId = "template_g0nxe7q";
  final userId = "xYxGwRDwi0dzisduh";
  bus_name = await fetch_bus_name(bus_id);
  if(this.mounted)
  setState(() {
    
  });

  for(var x in widget.finalSeats) temp.add(x);

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(url,
  headers: {
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'service_id': serviceId,
    'template_id': templateId,
    'user_id': userId,
    'accessToken': "zbct5nHRXrMdhMot1Fjko",
    'template_params': {
      'user_name': email,
      'user_subject': "E-Ticket details",
      'bus_name': bus_name,
      'date': widget.date,
      'source': widget.source,
      'destination': widget.destination,
      'seats': temp,
      'money': cash - amount_to_be_subtracted
    }
  },)
  );
  print(response.body);
}

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
      msg: "SUCCESS: THE TICKET HAS BEEN SENT TO YOUR EMAIL!", timeInSecForIosWeb: 5,
      textColor: Colors.black
    );

    //************************** booking hobar por database a pathate hobe ************************************ */
    email = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    user_id = await fetch_user_id(email) ;
    bus_id = Provider.of<bus_id_provider>(context, listen: false).get_bus_id_from_provider();
    if(this.mounted)
    setState(() {
      
    });
    
    add_booking_to_bookings_table(int.parse(user_id), bus_id, widget.source, widget.destination, no_of_tickets_booked, widget.date);
    Future.delayed(Duration(milliseconds: 1500), () async {
        var booking_id = await fetch_booking_id();
          
        for(var x in widget.finalSeats) {
          add_booking_to_bookings_with_date_table(int.parse(booking_id.toString()), bus_id, x, widget.date);
        }
      });


    //************************** User keo ticket ta mail korte hobe ****************************************** */
    send_ticket_to_email(email: email);
    //print(await fetch_bus_name(bus_id));

    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_with_login()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "${response.code} - ${response.message}",
        timeInSecForIosWeb: 4,
        webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
        textColor: Colors.white);
  }


  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4,
        webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
        textColor: Colors.white);
  }


  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment(int cash) async {
    var options = {
      'key': 'rzp_test_nTUZZ1DgvC0S0p',
      'amount': (cash - amount_to_be_subtracted) * 100,
      'name': 'Arghyadip',
      'description': 'Bus_Book_Ticket',
      'prefill': {'contact': '9999999999', 'email': 'jhon@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay?.open(options);
    }
    catch (e){
      debugPrint(e.toString());
    }
  }

  Future<void> fetchBusNameAndSetState() async {
    bus_id = Provider.of<bus_id_provider>(context, listen: false).get_bus_id_from_provider();
    bus_name = await fetch_bus_name(bus_id);
    if(this.mounted)
    setState(() {
      
    });
}

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<logged_in_user_provider>(context, listen: false).get_user_email_from_provider();
    if(email != "")
    username = email.substring(0, email.indexOf('@'));
    cash = widget.finalSeats.length * 50;
    if(this.mounted)
    setState(() {
      
    });
    //int cash = widget.finalSeats.length * 50;
    
    no_of_tickets_booked = widget.finalSeats.length;
    fetchBusNameAndSetState();

    if(MediaQuery.of(context).size.width > 900) {
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
                top: 200,
                left: 150,
                child: Container(
                  width: 90.w,
                  height: 90.h,

                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                  
                  
                        Text(
                          "JOURNEY SUMMARY: ", 
                          style: GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  
                          SizedBox(height: 20,),
                  
                        DataTable(
                                      
                                      columns: [
                                        DataColumn(label: Text("Bus Name", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),)),
                                        DataColumn(label: Text("From", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),)),
                                        DataColumn(label: Text("To", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),)),
                                        DataColumn(label: Text("Date", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),)),
                                        DataColumn(label: Text("Seats", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),)),
                                        DataColumn(label: Text("Amount", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),)),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                        
                        DataCell(Text("${bus_name}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18))),
                        DataCell(Text("${widget.source}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18))),
                        DataCell(Text("${widget.destination}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18))),
                        DataCell(Text("${widget.date}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18))),
                        DataCell(Text("${widget.finalSeats}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18))),
                        DataCell(Text("Rs ${cash - amount_to_be_subtracted}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 18))),
                        
                                        ])
                                      ],
                                    ),
                  
                  
                                SizedBox(height: 20,),
                  
                  
                                Row(
                    children: [
                  
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Got a Coupon Code? Redeem here!", 
                                              style: GoogleFonts.openSans(
                                                fontSize: 20, 
                                                fontWeight: FontWeight.bold),
                                          ),
                  
                                  content: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Coupon Code',
                                    ),
                                    onChanged: (value) {
                                      coupon = value;
                                      setState(() {
                                        
                                      });
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async{
                                        String discount = await discount_percent(coupon);
                                        String min_amount_req = await min_amount(coupon);
                                        print("**************************************************************");
                                        // print(await discount_percent(coupon));
                                        
                                        if(discount != "-1" && min_amount_req != "-1") {
                  
                                          if(is_redeemed == false) {
                                          if(int.parse(min_amount_req) <= cash) {
                                            amount_to_be_subtracted = (double.parse(discount) * cash) / 100.0;
                                            is_redeemed = true;
                                            setState(() {
                                              
                                            });
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                              msg: "Congratulations! Your coupon has been redeemed!",
                                              textColor: Colors.black,
                                              timeInSecForIosWeb: 4
                                            );
                                          }
                                          else {
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                              msg: "You need to spend at least Rs $min_amount_req to redeem this Coupon!",
                                              timeInSecForIosWeb: 4,
                                              webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                            );
                                          }
                                        }
                                        else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg: "You have already redeemed!",
                                              timeInSecForIosWeb: 4,
                                              webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                            );
                                        }                                     
                                      }
                                        else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                            msg: "Coupon Code entered isn't valid!",
                                            timeInSecForIosWeb: 4,
                                            webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                          );
                                        }
                                      }, 
                                      child: Text("Redeem!")
                                      )
                                  ],
                                ),
                              );
                        }, 
                        child: Text("Redeem Coupons")),
                  
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                  
                  
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_with_login())),
                          Fluttertoast.showToast(msg: "Cancelled!", timeInSecForIosWeb: 4, webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",)
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 61, 85, 1)
                        ),
                        child: Text("Cancel", style: GoogleFonts.openSans(color: Colors.white),),
                    ),
                  
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                  
                      ElevatedButton(
                        onPressed: () =>  {(kIsWeb) ? makePayment(cash) : print("object")}, 
                        child: Text("Make Payment")),
                    ],
                                ),
                  
                      ],
                    ),
                  ),
                ),
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
                //left: 150,
                child: Container(
                  width: 90.w,
                  height: 90.h,

                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                  
                  
                        Text(
                          "JOURNEY SUMMARY: ", 
                          style: GoogleFonts.openSans(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                  
                          SizedBox(height: 20,),
                  
                        DataTable(
                                      
                                      columns: [
                                        DataColumn(label: Text("Bus Name", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                                        DataColumn(label: Text("From", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                                        DataColumn(label: Text("To", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                                        DataColumn(label: Text("Date", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                                        DataColumn(label: Text("Seats", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                                        DataColumn(label: Text("Amount", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),)),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                        
                        DataCell(Text("${bus_name}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12))),
                        DataCell(Text("${widget.source}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12))),
                        DataCell(Text("${widget.destination}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12))),
                        DataCell(Text("${widget.date}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12))),
                        DataCell(Text("${widget.finalSeats}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12))),
                        DataCell(Text("Rs ${cash - amount_to_be_subtracted}", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12))),
                        
                                        ])
                                      ],
                                    ),
                  
                  
                                SizedBox(height: 20,),
                  
                  
                                Row(
                    children: [
                  
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Got a Coupon Code? Redeem here!", 
                                              style: GoogleFonts.openSans(
                                                fontSize: 15, 
                                                fontWeight: FontWeight.bold),
                                          ),
                  
                                  content: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Coupon Code',
                                    ),
                                    onChanged: (value) {
                                      coupon = value;
                                      setState(() {
                                        
                                      });
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async{
                                        String discount = await discount_percent(coupon);
                                        String min_amount_req = await min_amount(coupon);
                                        print("**************************************************************");
                                        // print(await discount_percent(coupon));
                                        
                                        if(discount != "-1" && min_amount_req != "-1") {
                  
                                          if(is_redeemed == false) {
                                          if(int.parse(min_amount_req) <= cash) {
                                            amount_to_be_subtracted = (double.parse(discount) * cash) / 100.0;
                                            is_redeemed = true;
                                            setState(() {
                                              
                                            });
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                              msg: "Congratulations! Your coupon has been redeemed!",
                                              textColor: Colors.black,
                                              timeInSecForIosWeb: 4
                                            );
                                          }
                                          else {
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                              msg: "You need to spend at least Rs $min_amount_req to redeem this Coupon!",
                                              timeInSecForIosWeb: 4,
                                              webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                            );
                                          }
                                        }
                                        else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg: "You have already redeemed!",
                                              timeInSecForIosWeb: 4,
                                              webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                            );
                                        }                                     
                                      }
                                        else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                            msg: "Coupon Code entered isn't valid!",
                                            timeInSecForIosWeb: 4,
                                            webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",
                                          );
                                        }
                                      }, 
                                      child: Text("Redeem!")
                                      )
                                  ],
                                ),
                              );
                        }, 
                        child: Text("Redeem Coupons", style: GoogleFonts.openSans(fontSize: 12),)),
                  
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  
                  
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_with_login())),
                          Fluttertoast.showToast(msg: "Cancelled!", timeInSecForIosWeb: 4, webBgColor: "linear-gradient(rgb(255, 61, 85), rgb(255, 61, 85))",)
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 61, 85, 1)
                        ),
                        child: Text("Cancel", style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),),
                    ),
                  
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  
                      ElevatedButton(
                        onPressed: () =>  {(kIsWeb) ? makePayment(cash) : print("object")}, 
                        child: Text("Make Payment", style: GoogleFonts.openSans(fontSize: 12),)),
                    ],
                                ),
                  
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          
        ],
      ),
    );
    }
  );
  }
  }
}

