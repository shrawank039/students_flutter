import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerAPI {

  var status;
  String apiRoot = "http://128.199.237.154/school_erp";

  _buildHeader() {
    return { 'Accept': 'application/json', 'cache-control': 'no-cache'};
  }

  _buildHeaderWithAuth() async {
    final currentAPIToken = await getApiToken();
    return {
      'Accept': 'application/json',
      'authorization': 'Bearer ' + currentAPIToken,
      'cache-control': 'no-cache'
    };
  }

  Future<String> getApiToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final apiToken = await prefs.get('api_token');
    return apiToken;
  }

  static successToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green,
      duration: Duration(seconds:3),
    );
  }

  static errorToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      duration: Duration(seconds:3),
    );
  }

  setAuthUser(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = json.encode(data);
    await prefs.setBool('isLogin', true);
    await prefs.setString('username', data['student_username'].toString());
    await prefs.setString('password', data['student_tmp_password'].toString());
    await prefs.setString('userData', userData.toString());
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("userData");
    return json.decode(data);
  }

  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = await prefs.getBool('isLogin');
    if(isLogin == null){
      return false;
    }
    return isLogin;
  }

  Future<Map<String, dynamic>> updateDeviceID(data) async {
    final response = await http.post(apiRoot+"/updateStudentDeviceId", headers: _buildHeader(), body: data);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  // SERVER SIDE API FUNCTIONS //

  Future<Map<String, dynamic>> authRequest(data) async {
    final response = await http.post(apiRoot+"/ApiLogin", headers: _buildHeader(), body: data);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Map<String, dynamic>> todaySchedule() async {
    final userInfo = await this.getUserInfo();
    final classID = userInfo['class_id'];
    final schoolID = userInfo['school_id'];
    final response = await http.get(apiRoot+"/getparticularClassData?class_id=$classID&school_id=$schoolID", headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Map<String, dynamic>> weeklyScheduleClass() async {
    final userInfo = await this.getUserInfo();
    final classID = userInfo['class_id'];
    final response = await http.get(apiRoot+"/weeklyScheduleClass?class_id=$classID", headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Map<String, dynamic>> announcement() async {
    final userInfo = await this.getUserInfo();
    final schoolID = userInfo['school_id'];
    final response = await http.get(apiRoot+"/announcement?type=teacher&school_id=$schoolID", headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }


  Future<Map<String, dynamic>> individualChatRoomList() async {
    final userInfo = await this.getUserInfo();
    final classID = userInfo['class_id'];
    final schoolID = userInfo['school_id'];
    final studentID = userInfo['id'];
    final response = await http.get(apiRoot+"/individualChatRoomList?school_id=$schoolID&class_id=$classID&student_id=$studentID", headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  // Chat

  Future<Map<String, dynamic>> getGroupChatHistory(groupId) async {
    final response = await http.get(apiRoot+"/groupChatHistory?group_chat_id="+groupId, headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Map<String, dynamic>> getIndividualChatHistory(groupId) async {
    final response = await http.get(apiRoot+"/individualChatHistory?group_chat_id="+groupId, headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  attachmentUpload(image) async {
    var url = apiRoot+"/upload";
    var request = http.MultipartRequest('POST', Uri.parse(url),);
    request.files.add(await http.MultipartFile.fromPath('attachment', image,),);
    final Map <String ,String> header= {
      'Accept': 'application/json',
    };
    request.headers.addAll(header);
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    return json.decode(response.body.toString());
  }

  Future<Map<String, dynamic>> getClassWiseSubjectList() async {
    final userInfo = await this.getUserInfo();
    final classID = userInfo['class_id'];
    final response = await http.get(apiRoot+"/classWiseSubjectList?class_id=$classID", headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Map<String, dynamic>> getIndividualAssignment(studentID, subjectId) async {
    final response = await http.get(apiRoot+"/getIndividualAssignment?student_id="+studentID+"&subject_id="+subjectId, headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Map<String, dynamic>> submitAttendence() async {
    final userInfo = await this.getUserInfo();
    final studentID = userInfo['id'];
    final schoolID = userInfo['school_id'];
    final response = await http.get(apiRoot+"/submitAttendence?student_id=$studentID&school_id=$schoolID", headers: _buildHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  submitAssignment(data, attachmentPath) async {
    var url = apiRoot+"/submitWorkAssignmentByStudent";
    var request = http.MultipartRequest('POST', Uri.parse(url),);
    request.files.add(await http.MultipartFile.fromPath('attachment', attachmentPath,),);
    request.fields.addAll(data);
    final Map <String ,String> header= {
      'Accept': 'application/json',
    };
    request.headers.addAll(header);
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    return json.decode(response.body.toString());
  }

}