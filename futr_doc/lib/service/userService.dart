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
  //Uncomment for prod testing
  // static final _hostUrl = 'http://54.91.210.147:3000/user';

  //Uncomment for local testing
  static final _hostUrl = 'http://10.0.2.2:3000/user';
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
      "email": email + dropDownValue,
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

  Future authenticateUser(String phone_number, String password,
      [String? code]) async {
    final url = '$_hostUrl/login';
    var headers = await getHeaders(null);
    Object body = code != null
        ? {'username': '+1' + phone_number, 'password': password, 'code': code}
        : {
            'username': '+1' + phone_number,
            'password': password
          }; //not sure if this is going to go through correctly
    print(body);
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
        return {'status': false};
      }
      return {'status': true};
    } catch (err) {
      print(err);
      return {'status': false};
    }
  }

  Future validateSms(String phone_number, String code) async {
    final url = '$_hostUrl/validate-sms';
    var headers = await getHeaders(null);
    Object body = {
      'username': '+1' + phone_number,
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

  Future resendSms(String phone_number) async {
    final url = '$_hostUrl/resend-sms';
    var headers = await getHeaders(null);
    Object body = {
      'username': '+1' + phone_number,
    };
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return {'status': true};
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return {'status': false, 'message': data['message']};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future validateEmail(
      String phone_number, String code, BuildContext context) async {
    final url = '$_hostUrl/validate-email';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    Object body = {
      'username': '+1' + phone_number,
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

  Future getEmailCode(
      String phone_number, String password, BuildContext context) async {
    final url = '$_hostUrl/get-email-code';
    var headers = await getHeaders(null);
    Object body = {'username': '+1' + phone_number, 'password': password};
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      context.read<TokenProvider>().setToken(Token.jsonToToken(data));
      if (response.statusCode == 200) {
        return {'status': true};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future updateUser(String firstName, String lastName, String schoolYear,
      String degree, BuildContext context) async {
    final url = '$_hostUrl';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    print('here');
    final User user = context.read<UserProvider>().user;
    Object body = {
      'id': user.id.toString(),
      'first_name': firstName,
      'last_name': lastName,
      'school_year': schoolYear,
      'degree': degree
    };
    try {
      http.Response response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        //why are we doing all of this? Didn't we just read it from the provider?
        user.first_name = firstName;
        user.last_name = lastName;
        user.schoolYear = schoolYear;
        user.degree = degree;
        context.read<UserProvider>().setUser(user);
        return {'status': true};
      } else {
        print(response.statusCode);
        print(data['message']);
        return {'status': false};
      }
    } catch (err) {
      print(err);
      return {'status': false};
    }
  }

  //Account Recovery
  Future startForgotPassword(String phone_number) async {
    final url = '$_hostUrl/start-forgot-password';
    var headers = await getHeaders(null);
    Object body = {'username': '+1' + phone_number};
    print(body);
    print(url);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return {'status': true};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future completeForgotPassword(
      String phone_number, String code, String password) async {
    final url = '$_hostUrl/complete-forgot-password';
    var headers = await getHeaders(null);
    Object body = {
      'username': '+1' + phone_number,
      'code': code,
      'password': password
    };
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        return {'status': true};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  // Future changeUserAttribute() async{
  //   //create type on the frontend as well
  // }
}
