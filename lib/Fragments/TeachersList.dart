import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TeachersList extends StatelessWidget {
  final teacherSpecialization = [
    '(Science)',
    '(English)',
    '(Mathematics)',
    '(English)',
    '(Health & Education)',
    '(Physical Education)',
    '(Mathematics)'
  ];

  final teacherName = [
    'Shiv Kumar',
    'Ram',
    'Shyam',
    'Ghanshyam',
    'Sita',
    'Gita',
    'Babita'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teacherName.length,
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
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 15.0),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/images/teacher_icon.png',
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          teacherName[position],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            teacherSpecialization[position],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
