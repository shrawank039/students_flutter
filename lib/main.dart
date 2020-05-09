import 'package:flutter/material.dart';
import 'Auth/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.blue,
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
        fontFamily: 'Gamja Flower',
      ),
      home: Login(),
    );
  }
}
