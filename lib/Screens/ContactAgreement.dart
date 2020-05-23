import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ServerAPI.dart';

class ContactAgreement extends StatelessWidget {
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
      body: Column(
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
        ],
      ),
    );
  }
}
