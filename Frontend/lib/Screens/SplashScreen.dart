import 'package:bus_book/Screens/Home_with_logout_button.dart';
import 'package:bus_book/Screens/Home_with_login_signup_buttons.dart';
import 'package:bus_book/pages/login.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {  
    initial().whenComplete(() async {
      Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => Home_without_login())));
        });
    });
    super.initState();
  }

  Future<void> initial() async {
    String temp = await sharedPref.get_user();
    /*print(".......................................................");
    print(temp);*/
    if(temp != "") {
      Provider.of<logged_in_user_provider>(context, listen: false).set_user_email_for_provider(temp);
    }
  }  

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: RiveAnimation.network("https://res.cloudinary.com/dvypswxcv/raw/upload/v1687549010/loading_dots_d3j4z2.riv", stateMachines: ['State Machine 1'], fit: BoxFit.cover,),
      ),
    );
  }
}