import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(SubjectsList());
}

class SubjectsList extends StatelessWidget {
  final timetable = [
    '9am-10am',
    '10am-11am',
    '11am-12am',
    '12am-1am',
    '2am-3am',
    '3am-4am',
    '4am-5am'
  ];
  final subjects = [
    'Mathematics',
    'Science',
    'History',
    'Physics',
    'Biology',
    'Zoology',
    'Health and Physical'
  ];
  final classStatus = [
    'assets/images/completed_classes.png',
    'assets/images/completed_classes.png',
    'assets/images/completed_classes.png',
    'assets/images/ongoing_classes.png',
    'assets/images/pending_class.png',
    'assets/images/pending_class.png',
    'assets/images/pending_class.png'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Subjects List"),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: timetable.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int position) {
              return Container(
                margin: EdgeInsets.only(left: 10.0, right: 10, top: 5),
                child: GestureDetector(
                  onTap: () {
                    showToast('Position: $position');
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            timetable[position],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            subjects[position],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              classStatus[position],
                            ),
                          ),
                        ],
                      ),
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
