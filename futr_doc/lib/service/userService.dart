import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken') ?? '';
    String idToken = prefs.getString('idToken') ?? '';
    String refreshToken = prefs.getString('refreshToken') ?? '';
    final _headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'accessToken': accessToken,
      'idToken': idToken,
      'refreshToken': refreshToken
    };
    return _headers;
  }

  static final _hostUrl = 'http://54.91.210.147:3000/user';

  UserService._privateConstructor();
  static final UserService instance = new UserService._privateConstructor();

  Future registerUser(String email, String phone_number, String legal,
      String password, String dropDownValue) async {
    final url = _hostUrl;
    var headers = await getHeaders();
    Object body = {
      "email": email + dropDownValue,
      "phone_number": '+1' + phone_number,
      "legal": legal,
      "password": password
    };
    try {
      var data = await http.post(Uri.parse(url), headers: headers, body: body);
      return {data};
    } catch (err) {
      return {'status': false};
    }
  }

  Future authenticateUser(String username, String password) async {
    final url = '$_hostUrl/login';
    var headers = await getHeaders();
    Object body = {username: username, password: password};
    try {
      var data = await http.post(Uri.parse(url), headers: headers, body: body);
      return {data};
    } catch (err) {
      return {'status': false};
    }
  }

  Future getEmailCode(String username, String password) async {
    final url = '$_hostUrl/getEmailCode';
    var headers = await getHeaders();
    Object body = {username: username, password: password};
    try {
      var data = await http.post(Uri.parse(url), headers: headers, body: body);
      return {data};
    } catch (err) {
      return {'status': false};
    }
  }

  Future validateSMS(String username, String code) async {
    final url = '$_hostUrl/validateSMS';
    var headers = await getHeaders();
    Object body = {username: username, code: code};
    try {
      var data = await http.post(Uri.parse(url), headers: headers, body: body);
      return {data};
    } catch (err) {
      return {'status': false};
    }
  }

  Future validateEmail(String username, String code) async {
    final url = '$_hostUrl/validateEmail';
    var headers = await getHeaders();
    Object body = {
      'username': username,
      'code': code,
      'accessToken': headers['accessToken'],
      'idToken': headers['idToken'],
      'refreshToken': headers['refreshToken']
    };
    try {
      var data = await http.post(Uri.parse(url), headers: headers, body: body);
      return {data};
    } catch (err) {
      return {'status': false};
    }
  }
}
