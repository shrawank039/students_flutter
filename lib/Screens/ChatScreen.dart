import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:students/Utils/Message.dart';

class MyChatScreen extends StatefulWidget {
  const MyChatScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChatScreen> {
  final List<Message> _messages = <Message>[];
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(time);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chat App',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Container(
              child: Column(
                children: <Widget>[
                  //Chat list
                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length,
                    ),
                  ),
                  Divider(height: 1.0),
                  Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: IconTheme(
                          data: IconThemeData(
                              color: Theme.of(context).accentColor),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Row(
                              children: <Widget>[
                                //left send button

                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  child: IconButton(
                                      icon: Image.asset(
                                          "assets/images/send_in.png"),
                                      onPressed: () => _sendMsg(
                                          _textController.text,
                                          'left',
                                          formattedDate)),
                                ),

                                //Enter Text message here
                                Flexible(
                                  child: TextField(
                                    controller: _textController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter message"),
                                  ),
                                ),

                                //right send button

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                                  width: 48.0,
                                  height: 48.0,
                                  child: IconButton(
                                      icon: Image.asset(
                                          "assets/images/send_out.png"),
                                      onPressed: () => _sendMsg(
                                          _textController.text,
                                          'right',
                                          formattedDate)),
                                ),
                              ],
                            ),
                          ))),
                ],
              ),
            )));
  }

  void _sendMsg(String msg, String messageDirection, String date) {
    if (msg.length == 0) {
    } else {
      _textController.clear();
      Message message = Message(
        msg: msg,
        direction: messageDirection,
        dateTime: date,
      );
      setState(() {
        _messages.insert(0, message);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }
}
