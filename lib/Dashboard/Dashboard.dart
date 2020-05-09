import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../GroupChat/ChatScreen.dart';

class Dashboard extends StatelessWidget {
  final androidVersionNames = [
    'Schedule',
    'Progress',
    'Announcement',
    'Chat',
    'Support',
    'Profile'
  ];
  final carIcons = [
    'assets/images/schedule.png',
    'assets/images/progress.png',
    'assets/images/announcement.png',
    'assets/images/chat.png',
    'assets/images/suppoert0.png',
    'assets/images/profile.png'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Container(
          child: GridView.builder(
            itemCount: carIcons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(15.0),
                child: Card(
                  child: GestureDetector(
                    onTap: () {
                      showToast('Position: $index');
                      // Go to chat page
                      if(index == 3 ){
                        Route route = MaterialPageRoute(builder: (context) => MyChatScreen("1", "English", "my_group_id", "2"));
                        Navigator.push(context, route);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                androidVersionNames[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50, top: 15),
                              height: 90,
                              width: 90,
                              child: Image.asset(
                                carIcons[index],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}