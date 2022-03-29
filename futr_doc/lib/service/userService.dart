import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futr_doc/models/Tokens.dart';
import 'package:futr_doc/providers/tokenProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/User.dart';
import '../providers/UserProvider.dart';

class UserService {
  Future<Map<String, String>> getHeaders(String? tokens) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken') ?? '';
    String idToken = prefs.getString('idToken') ?? '';
    String refreshToken = prefs.getString('refreshToken') ?? '';
    final _headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Cognito": tokens ?? ''
    };
    return _headers;
  }

  static final _hostUrl = 'http://54.91.210.147:3000/user';

  UserService._privateConstructor();
  static final UserService instance = new UserService._privateConstructor();

  //GET
  Future getUser(String id) async {
    final url = '$_hostUrl/';
    var headers = await getHeaders(null);
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(data);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      return {'status': true};
    } catch (err) {
      return {'status': false};
    }
  }

  //POST
  Future registerUser(String email, String phone_number, String legal,
      String password, String dropDownValue, BuildContext context) async {
    final url = _hostUrl;
    var headers = await getHeaders(null);
    Object body = {
      "email": 'tate@upineapps.com',
      "phone_number": '+1' + phone_number,
      "legal": legal,
      "password": password
    };
    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      context.read<UserProvider>().setUser(User.jsonToUser(data['user']));
      return {'status': true};
    } catch (err) {
      print(err);
      context.read<UserProvider>().clearUser();
      return {'status': false};
    }
  }

  Future authenticateUser(String username, String password) async {
    final url = '$_hostUrl/login';
    var headers = await getHeaders(null);
    Object body = {username: username, password: password};
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        Future<SharedPreferences> prefs = SharedPreferences.getInstance();
        prefs.then((value) {
          value.setString('accessToken', data['accessToken']);
          value.setString('idToken', data['idToken']);
          value.setString('refreshToken', data['refreshToken']);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      return {'status': true};
    } catch (err) {
      return {'status': false};
    }
  }

  Future getEmailCode(
      String username, String password, BuildContext context) async {
    final url = '$_hostUrl/getEmailCode';
    var headers = await getHeaders(null);
    Object body = {'username': username, 'password': password};
    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(Token.jsonToToken(data));
      context.read<TokenProvider>().setToken(Token.jsonToToken(data));
      return {data};
    } catch (err) {
      return {'status': false};
    }
  }

  // Future getPhoneCode(String username, String password) async {
  //   final url = '$_hostUrl/getEmailCode';
  //   var headers = await getHeaders();
  //   Object body = {'username': username, 'password': password};
  //   try {
  //     var data = await http.post(Uri.parse(url), headers: headers, body: body);
  //     return {data};
  //   } catch (err) {
  //     return {'status': false};
  //   }
  // }

  Future validateSMS(String email, String code) async {
    final url = '$_hostUrl/validateSMS';
    var headers = await getHeaders(null);
    Object body = {
      'username': email,
      'code': code,
    };
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        return {'status': true};
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future validateEmail(
      String username, String code, BuildContext context) async {
    final url = '$_hostUrl/validateEmail';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    Object body = {
      'username': username,
      'code': code,
    };
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        return {'status': true};
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future updateUser(String firstName, String lastName, String schoolYear,
      String degree, BuildContext context) async {
    final url = '$_hostUrl/user';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    final User user = context.read<UserProvider>().users;
    Object body = {
      'id': user.id,
      'first_name': firstName, 'last_name': lastName,
      //Need to implement schoolYear and degree in the backend and DB
    };
    try {
      http.Response response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      user.first_name = firstName;
      user.last_name = lastName;
      user.schoolYear = schoolYear;
      user.degree = degree;
      context.read<UserProvider>().setUser(user);
      return {'status': true};
    } catch (err) {
      return {'status': false};
    }
  }
}
