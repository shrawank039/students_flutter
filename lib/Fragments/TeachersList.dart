import 'package:flutter/material.dart';
import 'package:students/IndividualChat/IndividualChat.dart';
import '../Global.dart';
import '../ServerAPI.dart';

class TeachersList extends StatefulWidget {
  final String title;

  TeachersList(this.title);

  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  var appBar = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.title != "") {
      appBar = AppBar(
        title: Text(widget.title.toString()),
        backgroundColor: Colors.blue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: _individualChatRoomList(),
        builder: (BuildContext context, snapshot) {
          var response = snapshot.data;
          if (response != null) {

            if(response.length > 0 ){
              return ListView.builder(
                  itemCount: response.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () async {
                            Route route = MaterialPageRoute(
                                builder: (context) => IndividualChat(
                                    response[index]['class_id'].toString(),
                                    response[index]['teacher_id'].toString(),
                                    response[index]['subject_name'].toString(),
                                    response[index]['student_id'].toString(),
                                    response[index]['chat_room_id'].toString()));
                            await Navigator.push(context, route);
                            setState(() {});
                          },
                          leading: Image.asset(
                            'assets/images/teacher_icon.png',
                          ),
                          title: Text(
                            response[index]['teacher_name'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                          Text(response[index]['subject_name'].toString()),
                          trailing: customCountViewer(
                              response[index]['unread_message']),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.black12),
                        )
                      ],
                    );
                  });
            } else {
              return Center(child: Text("NO RECORD FOUND", style: TextStyle(fontSize: 15),));
            }

          } else {
            return Center(child: Global.spinkitCircle);
          }
        },
      ),
    );
  }

  Widget customCountViewer(count) {
    if (count > 0) {
      return Container(
        width: 30,
        height: 30,
        child: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            count.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Container(
        width: 30,
        height: 30,
      );
    }
  }

  _individualChatRoomList() async {
    final result = await ServerAPI().individualChatRoomList();
    print(result);
    return result["data"];
  }
}
