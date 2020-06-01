import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students/GroupChat/ChatScreen.dart';
import 'package:students/ServerAPI.dart';

class GroupChat extends StatefulWidget {

  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  List allSubject = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allSubjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: todaySchedule(),
            builder: (BuildContext context, snapshot) {
              var response = snapshot.data;
              return Column(
                children: <Widget>[

                  dayLog(response),

                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text("All Subjects".toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allSubject.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10, top: 5),
                        child: GestureDetector(
                          onTap: () async {
                            final user = await ServerAPI().getUserInfo();
                            Route route = MaterialPageRoute(builder: (context) => MyChatScreen(
                                allSubject[index]['class_id'].toString(),
                                allSubject[index]['class_status'].toString(),
                                allSubject[index]['teacher_id'].toString(),
                                allSubject[index]['subject_name'].toString(),
                                user['id'],
                                allSubject[index]['chat_room_id'].toString(),
                                allSubject[index]['subject_id'].toString()
                            ));
                            await Navigator.push(context, route);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    allSubject[index]["subject_name"].toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  Text(
                                    allSubject[index]['teacher_name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    width: 25,
                                    child: getStatus(allSubject[index]['class_status'].toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                ],
              );
            }
          ),
      )
    );
  }

  Widget dayLog(response) {
    if(response != null){
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: response.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10.0, right: 10, top: 5),
            child: GestureDetector(
              onTap: () async {
                final user = await ServerAPI().getUserInfo();
                Route route = MaterialPageRoute(builder: (context) => MyChatScreen(
                    response[index]['class_id'].toString(),
                    response[index]['class_status'].toString(),
                    response[index]['teacher_id'].toString(),
                    response[index]['subject_name'].toString(),
                    user['id'],
                    response[index]['chat_room_id'].toString(),
                    response[index]['subject_id'].toString()
                ));
                await Navigator.push(context, route);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        response[index]["timeslot"].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        response[index]['subject_name'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        child: getStatus(response[index]['class_status'].toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget getStatus(status) {
    if(int.tryParse(status) == 0 ){
      return Image.asset('assets/images/completed_classes.png');
    } else if ( int.tryParse(status) == 1 ){
      return Image.asset('assets/images/ongoing_classes.png');
    } else {
      return Image.asset('assets/images/pending_class.png');
    }
  }

  allSubjectList() async {
    final result = await ServerAPI().getClassWiseSubjectList();
    setState(() {
      allSubject =  result["data"];
    });
  }

  todaySchedule() async{
    final result = await ServerAPI().todaySchedule();
    print(result);
    return result["data"];
  }
}
