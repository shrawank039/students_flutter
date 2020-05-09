import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:students/Fragments/GroupChat.dart';
import 'package:students/Fragments/Privatechat.dart';
import 'package:students/Fragments/TeachersList.dart';

void main() {
  runApp(SubjectsList());
}

class SubjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabs App',
      home: TabsApp(),
    );
  }
}

class TabsApp extends StatelessWidget {
  List<Widget> containers = [
    new GroupChat(),
    new Privatechat(),
    new TeachersList()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Group Chat',
              ),
              Tab(
                text: 'Private Chat',
              ),
              Tab(
                text: 'Teachers',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}
