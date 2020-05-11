import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students/IndividualChat/IndividualChat.dart';

import '../ServerAPI.dart';

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

    return FutureBuilder(
      future: _individualChatRoomList(),
      builder: ( BuildContext context, snapshot ){
        var response = snapshot.data;
        if(response != null){
          return ListView.builder(
            itemCount: response.length,
            itemBuilder: (BuildContext context, int index){
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () async {
                      Route route = MaterialPageRoute(builder: (context) => IndividualChat(
                          response[index]['class_id'].toString(),
                          response[index]['teacher_id'].toString(),
                          response[index]['subject_name'].toString(),
                          response[index]['student_id'].toString(),
                          response[index]['chat_room_id'].toString()
                      ));
                      await Navigator.push(context, route);
                    },
                    leading: Image.asset('assets/images/teacher_icon.png',),
                    title: Text(response[index]['teacher_name'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(response[index]['subject_name'].toString()),
                  ),
                  Container(height: 1,width: MediaQuery.of(context).size.width, decoration: BoxDecoration(color: Colors.black12),)
                ],
              );
            });
        } else {
          return Center(child: Text("Loading....", style: TextStyle(fontSize: 20),));
        }
      },
    );
  }

  _individualChatRoomList() async {
    final result = await ServerAPI().individualChatRoomList();
    return result["data"];
  }

}
