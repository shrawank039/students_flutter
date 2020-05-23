import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ServerAPI.dart';

class ContactAgreement extends StatefulWidget {

  @override
  _ContactAgreementState createState() => _ContactAgreementState();
}

class _ContactAgreementState extends State<ContactAgreement> {
  List<String> text = [
    'I have not shared my password with anyone.',
    'I am responsible for the content typed in query.',
    'I understand that necessary disciplinary action will be taken against me in case of '
        'use of derogarory words or false statement.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Agreement'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              child: Container(
                padding: EdgeInsets.only(top: 30, bottom: 30.0),
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50.0),
                color: Colors.white,
                child: Column(
                  children: text
                      .map(
                        (t) => CheckboxListTile(
                          title: Text(t),
                          value: true,
                          onChanged: (bool value) {},
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              width: double.infinity,
              height: 40.0,
              child: RaisedButton(
                elevation: 5,
                color: Colors.deepOrange[500],
                child: Text(
                  "I agree",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                onPressed: () async {
                  await ServerAPI().addSupport();
                  Navigator.pop(context);
                },
              ),
            ),

            SizedBox(height: 25,),

            FutureBuilder(
              future: _individualChatRoomList(),
              builder: (BuildContext context, snapshot) {
                var response = snapshot.data;
                if (response != null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: response.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: Image.asset(
                                'assets/images/teacher_icon.png',
                              ),
                              title: Text(
                                response[index]['teacher_name'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Designation: Teacher"),
                              trailing: Text(response[index]['teacher_phone'].toString(), style: TextStyle(fontSize: 20),),
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
                  return Center(
                      child: Text(
                        "Loading....",
                        style: TextStyle(fontSize: 20),
                      )
                  );
                }
              },
            )

          ],
        ),
      ),
    );
  }

  _individualChatRoomList() async {
    final result = await ServerAPI().individualChatRoomList();
    return result["data"];
  }
}
