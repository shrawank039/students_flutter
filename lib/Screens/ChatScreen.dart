import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:students/Utils/Message.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class MyChatScreen extends StatefulWidget {
  const MyChatScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyChatState createState() =>  _MyChatState();
}

class _MyChatState extends State<MyChatScreen> {

  final List<Message> _messages = <Message>[];
  final _textController = TextEditingController();
  SocketIO socketIO;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(time);
    return  Scaffold(
        appBar:  AppBar(
          title: const Text(
            'Chat App',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
        body:  Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child:  Container(
              child:  Column(
                children: <Widget>[
                  //Chat list
                   Flexible(
                    child:  ListView.builder(
                      padding:  EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length,
                    ),
                  ),
                   Divider(height: 1.0),
                   Container(
                      decoration: BoxDecoration(color: Theme.of(context).cardColor),
                      child:  IconTheme(
                          data:  IconThemeData(color: Theme.of(context).accentColor),
                          child:  Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child:  Row(
                              children: <Widget>[
                                //left send button
                                 Container(
                                  width: 48.0,
                                  height: 48.0,
                                  child:  IconButton(
                                      icon: Image.asset("assets/images/send_in.png"),
                                      onPressed: () => _sendMsg(_textController.text, 'left', formattedDate)
                                  ),
                                ),

                                //Enter Text message here
                                 Flexible(
                                  child:  TextField(
                                    controller: _textController,
                                    decoration:  InputDecoration.collapsed(hintText: "Enter message"),
                                  ),
                                ),

                                //right send button

                                 Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                                  width: 48.0,
                                  height: 48.0,
                                  child:  IconButton(
                                      icon: Image.asset("assets/images/send_out.png"),
                                      onPressed: () => _sendMsg(_textController.text, 'right', formattedDate)
                                  ),
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
      Message message =  Message(
        msg: msg,
        direction: messageDirection,
        dateTime: date,
      );
      setState(() {
        _messages.insert(0, message);
      });
    }
  }

  _connectSocket() {
    //update your domain before using
    /*socketIO = new SocketIO("http://127.0.0.1:3000", "/chat",
        query: "userId=21031", socketStatusCallback: _socketStatus);*/
    socketIO = SocketIOManager().createSocketIO("http://139.59.218.118:8080", "/chat", query: "userId=21031", socketStatusCallback: _socketStatus);

    //call init socket before doing anything
    socketIO.init();

    //subscribe event
    socketIO.subscribe("group_chat_room", _onSocketInfo);

    //connect socket
    socketIO.connect();
  }

  _subscribes() {
    if (socketIO != null) {
      socketIO.subscribe("group_chat_room", _onReceiveChatMessage);
    }
  }

  _unSubscribes() {
    if (socketIO != null) {
      socketIO.unSubscribe("group_chat_room", _onReceiveChatMessage);
    }
  }

  _onSocketInfo(dynamic data) {
    print("Socket info: " + data);
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  _reconnectSocket() {
    if (socketIO == null) {
      _connectSocket();
    } else {
      socketIO.connect();
    }
  }

  _disconnectSocket() {
    if (socketIO != null) {
      socketIO.disconnect();
    }
  }

  _destroySocket() {
    if (socketIO != null) {
      SocketIOManager().destroySocket(socketIO);
    }
  }

  void _sendChatMessage(String msg) async {
    if (socketIO != null) {
      String jsonData = json.encode(msg);
      socketIO.sendMessage("group_chat_room", jsonData, _onReceiveChatMessage);
    }
  }

  void socketInfo(dynamic message) {
    print("Socket Info: " + message);
  }

  void _onReceiveChatMessage(dynamic message) {
    var jsonMessage = json.decode(message.toString());
    print("Message from UFO: " + message);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
