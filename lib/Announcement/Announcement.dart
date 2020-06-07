import 'package:flutter/material.dart';

import '../CustomDrawer.dart';
import '../ServerAPI.dart';

class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Announcement"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: _getAnnouncement(),
          builder: (BuildContext context, snapshot) {
            var response = snapshot.data;
            if (response != null) {

              if(response.length > 0 ) {
                return ListView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    itemCount: response.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.notifications_active),
                              title: Text(response[index]['title'].toString()),
                              subtitle: Text(
                                  response[index]['created_date'].toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Text(
                                response[index]['description'].toString(),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                    child: Text(
                      "No Records Found",
                      style: TextStyle(fontSize: 20),
                    ));
              }

            } else {
              return Center(
                  child: Text(
                "Loading....",
                style: TextStyle(fontSize: 20),
              ));
            }
          }),
    );
  }

  _getAnnouncement() async {
    final result = await ServerAPI().announcement();
    return result["data"];
  }
}
