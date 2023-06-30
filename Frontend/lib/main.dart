import 'dart:io';
import 'package:bus_book/Screens/SplashScreen.dart';
import 'package:bus_book/networks/firebase_options.dart';
import 'package:bus_book/providers/bus_id_provider.dart';
import 'package:bus_book/providers/logged_in_user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future <void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => logged_in_user_provider()),
      ChangeNotifierProvider(
        create: (context) => bus_id_provider())
    ],
    child: const MyApp()
    ));
}

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    SharedPreferences.setMockInitialValues({});
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus Booker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: SplashScreen(),
    );
  }
}

