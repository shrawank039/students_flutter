import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

import '../ServerAPI.dart';

class StartAudioCall extends StatefulWidget {

  final String room_id;
  final String user_name;
  final String user_id;
  final String subject_name;
  final String class_name;

  StartAudioCall(this.room_id, this.user_id, this.user_name, this.subject_name, this.class_name);

  @override
  _StartAudioCallState createState() => _StartAudioCallState();
}

class _StartAudioCallState extends State<StartAudioCall> {

  SocketIOManager manager;
  SocketIO socket;
  InAppWebViewController _webViewController;

  String room_id;
  String user_name;
  String user_id;
  String subject_name;
  String class_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    room_id = widget.room_id;
    user_name = widget.user_name;
    user_id = widget.user_id;
    subject_name = widget.subject_name;
    class_name = widget.class_name;

    manager = SocketIOManager();
    initSocket();

  }

  initSocket() async {
    final student = await ServerAPI().getUserInfo();
    var userId = student['id'];
    var chatRoomID = widget.room_id;
    // Load Chat History

    socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
        "http://chatserver.21century.in:3000/",
        nameSpace: "/",
        query: {
          "user_type": "student",
          "user_id": userId,
          "chat_room_id": chatRoomID
        },
        enableLogging: false,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
        ] //Enable required transport
    ));
    socket.onConnect((data) {
      print("connected...");
    });
    socket.onConnectError(print);
    socket.onConnectTimeout(print);
    socket.onError(print);
    socket.onDisconnect(print);
    socket.on("group_chat_room/LiveClassEvent", (message) {
      print("LiveClassEvent");
      if(message["room_id"] == widget.room_id && message["status"] == "offline"){
        Navigator.pop(context);
      }
    });
    socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject_name + " Ongoing Class"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.call),
        backgroundColor: Colors.red,
      ),
      body: Container(
          child: Column(children: <Widget>[
            Expanded(
              child: Container(
                child: InAppWebView(
                    initialUrl: "https://conference.21century.in/audio.php?type=student&room_id=$room_id&user_name=$user_name&user_id=$user_id&subject_name=$subject_name&class_name=$class_name",
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        mediaPlaybackRequiresUserGesture: false,
                        debuggingEnabled: false,
                        clearCache: true
                      ),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;
                    },
                    androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                      return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                    }
                ),
              ),
            ),
          ])),
    );
  }

}
