import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_chatbox/pages/authscreen_apge.dart';
import 'package:scheduler_chatbox/pages/settings_screen.dart';


import 'homescreen_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        highlightColor: Colors.grey,
        textTheme:  const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0,fontFamily: 'Hind',color: Colors.white70,fontWeight: FontWeight.w700),
        )
      ),
      debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}
