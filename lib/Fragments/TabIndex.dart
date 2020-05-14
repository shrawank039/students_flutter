import 'package:flutter/material.dart';
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
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              tooltip: 'Mark Attendence',
              onPressed: () async {
                final result = await ServerAPI().submitAttendence();
                _scaffolkey.currentState.showSnackBar(ServerAPI.successToast(result['msg']));
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: "Class Room",),
              Tab(text: "Assignment",),
              Tab(text: "Homework",),
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
