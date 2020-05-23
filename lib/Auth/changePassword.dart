import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: changePassword(),
    ));

class changePassword extends StatefulWidget {
  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Change Password'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                child: Text(
                  'If you forget your old password then please contact your school for further assistance.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          elevation: 3,
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(left: 20),
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(fontSize: 18),
                              maxLength: 10,
                              decoration: InputDecoration(
                                hintText: 'Old password',
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(top: 15, left: 40, right: 40),
                          elevation: 3,
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(left: 20),
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(fontSize: 18),
                              maxLength: 10,
                              decoration: InputDecoration(
                                hintText: 'New password',
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(top: 15, left: 40, right: 40),
                          elevation: 3,
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(left: 20),
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(fontSize: 18),
                              maxLength: 10,
                              decoration: InputDecoration(
                                hintText: 'Confirm new password',
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 30, right: 30),
                    width: double.maxFinite,
                    height: 45.0,
                    child: RaisedButton(
                      elevation: 10,
                      child: Text('Confirm Change'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        /* Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => waitForOTP()),
                        );*/
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Do you want to move to Sign In Page?',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0, bottom: 20),
                        child: InkWell(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.teal[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
