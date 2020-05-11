import 'package:flutter/material.dart';
import 'GroupChat.dart';
import 'Privatechat.dart';
import 'TeachersList.dart';

class TabIndex extends StatefulWidget {
  @override
  _TabIndexState createState() => _TabIndexState();
}

class _TabIndexState extends State<TabIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.supervised_user_circle), text: "Group",),
              Tab(icon: Icon(Icons.receipt), text: "Assignment",),
              Tab(icon: Icon(Icons.account_circle), text: "Teachers",),
            ],
          ),
          title: Text('Class Communications'),
        ),
        body: TabBarView(
          children: [
            GroupChat(),
            Privatechat(),
            TeachersList(),
          ],
        ),
      ),
    );
  }
}
