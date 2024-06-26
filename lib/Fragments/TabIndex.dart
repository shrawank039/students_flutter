import 'package:flutter/material.dart';
import '../CustomDrawer.dart';
import 'Assignment.dart';
import 'GroupChat.dart';
import 'TeachersList.dart';
import '../ServerAPI.dart';

class TabIndex extends StatefulWidget {
  @override
  _TabIndexState createState() => _TabIndexState();
}

class _TabIndexState extends State<TabIndex> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffolkey,
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: <Widget>[],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Class Room",
              ),
              Tab(
                text: "Assignment",
              ),
              Tab(
                text: "Homework",
              ),
            ],
          ),
          title: Text('Class Communications'),
        ),
        body: TabBarView(
          children: [
            GroupChat(),
            Assignment(),
            TeachersList(""),
          ],
        ),
      ),
    );
  }
}
