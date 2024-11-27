import 'package:flutter/material.dart';
import 'package:flutter_application_100/Add.dart';
import 'package:flutter_application_100/SignUp.dart';
import 'package:flutter_application_100/edit.dart';
import 'package:flutter_application_100/home2.dart';
import 'package:flutter_application_100/login.dart';
import 'package:flutter_application_100/welcome.dart';


void main() {
  runApp(StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'welcome',
      routes: {
        'signup': (context) => SignUp(),
        'login': (context) => Login(),
        'Edit': (context) => EditPage(),
        'welcome': (context) => WelcomePage(),
        'ADD': (context) => AddPage(),
        'home22': (context) => HomePage(
              username: '',
              email: '',
            ),
      },
      home: SignUp(),
    );
  }
}
