import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../ServerAPI.dart';

class StartVideoCall extends StatefulWidget {

  final String room_id;
  final String user_name;
  final String user_id;
  final String subject_name;
  final String class_name;

  StartVideoCall(this.room_id, this.user_id, this.user_name, this.subject_name, this.class_name);

  @override
  _StartVideoCallState createState() => _StartVideoCallState();
}

class _StartVideoCallState extends State<StartVideoCall> {

  InAppWebViewController _webViewController;

  SocketIOManager manager = SocketIOManager();
  SocketIO socket;

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
    initSocket();
  }


  initSocket() async {

    final teacher = await ServerAPI().getUserInfo();
    var userId = teacher['id'];
    var chatRoomID = widget.room_id;
    // Load Chat History
    socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
        "http://chatserver.21century.in:3000/",
        nameSpace: "/",
        query: {
          "user_type": "teacher",
          "user_id": userId,
          "chat_room_id": chatRoomID
        },
        enableLogging: true,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
        ] //Enable required transport
    ));

    socket.onConnect((data) {
      print("connected...");
    });
    socket.onConnectError((data) {
      print("onConnectError");
      print(data);
    });
    socket.onConnectTimeout((data) {
      print("onConnectTimeout");
      print(data);
    });
    socket.onError((data) {
      print("onError");
      print(data);
    });
    socket.onDisconnect((data) {
      print("onError");
      print(data);
    });
    socket.connect();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user_name + " Ongoing Class"),
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
                    initialUrl: "https://conference.21century.in/video.php?type=student&room_id=$room_id&user_name=$user_name&user_id=$user_id&subject_name=$subject_name&class_name=$class_name",
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
                    onLoadStart: (InAppWebViewController controller, String url) {
                      print("Loading Start");
                    },
                    onLoadStop: (InAppWebViewController controller, String url) async {
                      print("Loading Stop");
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
