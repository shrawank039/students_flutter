import 'package:flutter/material.dart';
import 'package:students/Auth/Login.dart';
import 'package:students/Dashboard/Dashboard.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:students/ServerAPI.dart';

void main() {
  runApp(MyApp());
  OneSignal.shared.init("0ff4329e-5eda-4e47-8de0-0e4f05fb6f50");
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.blueGrey,
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
        fontFamily: 'Gamja Flower',
      ),
      home: Login(),
    );
  }

  _isLogin() async {
    if (await ServerAPI().isLogin()) {
      print("login");
      Route route = MaterialPageRoute(builder: (context) => Dashboard());
      Navigator.pushReplacement(context, route);
    } else {
      print("not login");
    }
  }

}
