import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futr_doc/models/Tokens.dart';
import 'package:futr_doc/models/types/ForgotPasswordBody.dart';
import 'package:futr_doc/models/types/LoginBody.dart';
import 'package:futr_doc/models/types/UnauthenticatedUserBody.dart';
import 'package:futr_doc/models/types/UserSignUpBody.dart';
import 'package:futr_doc/models/types/UserUpdateBody.dart';
import 'package:futr_doc/models/types/VerifyAttributeBody.dart';
import 'package:futr_doc/providers/tokenProvider.dart';
import 'package:futr_doc/service/shadowingService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/Shadowing.dart';
import '../models/User.dart';
import '../providers/ShadowingProvider.dart';
import '../providers/UserProvider.dart';

class UserService {
  Future<Map<String, String>> getHeaders(String? tokens) async {
    final _headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Cognito": tokens ?? ''
    };
    return _headers;
  }

  //Uncomment for prod testing
  // static final _hostUrl = 'http://54.91.210.147:3000/user';

  //Uncomment for local testing on Android
  // static final _hostUrl = 'http://10.0.2.2:3000/user';

  //Uncomment for local testing on iOS
  static final _hostUrl = 'http://localhost:3000/user';

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

  Future getUserByPhone(String phone_number, BuildContext context) async {
    final url = '$_hostUrl/phonenumber/+1' + '${phone_number}';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(data);
        return {'status': true, 'body': data};
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (err) {
      return {'status': false};
    }
  }

  //POST
  Future registerUser(
      UserSignUpBody userSignUpBody, BuildContext context) async {
    final url = _hostUrl;
    var headers = await getHeaders(null);

    Object body = userSignUpBody.toJson();

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('SIGN UP RETURN DATA');
      print(data);
      print(data['user']['id'].runtimeType);
      String user_id = data['user']['id'].toString();
      Future<SharedPreferences> prefs = SharedPreferences.getInstance();
      prefs.then((value) {
        value.setString('user_id', user_id);
        value.setString('phone_number', userSignUpBody.phone_number);
        value.setString('email', userSignUpBody.email);
      });
      context.read<UserProvider>().setUser(User.jsonToUser(data['user']));

      return {'status': true};
    } catch (err) {
      print(err);
      context.read<UserProvider>().clearUser();
      return {'status': false};
    }
  }

  /*
  Functions should do one thing. Clean up authenticate user and handle getUserByPhone in widget. 
  Abstract the response handling and have functions throw errors w messages if failing.
   Catch in widget
   */
  Future authenticateUser(LoginBody loginBody, BuildContext context) async {
    final url = '$_hostUrl/login';
    var headers = await getHeaders(null);

    print(loginBody);
    Object body = loginBody.toJson();
    print(body);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        //passed authentication
        context.read<TokenProvider>().setToken(Token.jsonToToken(data));
        var getUserResponse = await UserService.instance
            .getUserByPhone(loginBody.username, context);
        if (getUserResponse['status'] == false) {
          return {'status': false, 'message': 'Failed to get user'};
        } else {
          User convertedUser = User.jsonToUser(getUserResponse['body']);
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('user_id', convertedUser.id);
          prefs.setString('phone_number', convertedUser.phone_number);
          prefs.setString('email', convertedUser.email);
          context.read<UserProvider>().setUser(convertedUser);
          var shadowingResponse =
              await ShadowingService.instance.getAllShadowing(context);

          if (shadowingResponse['status'] == true) {
            if (shadowingResponse['body'] != null) {
              for (var shadowing in shadowingResponse['body']) {
                context
                    .read<ShadowingProvider>()
                    .addToShadowings(Shadowing.jsonToShadowing(shadowing));
              }
            }
          } else {
            return {'status': false, 'message': 'Failed to retrieve shadowing'};
          }
        }
      } else if (data['message'] == 'MFA_NEEDED') {
        var getUserResponse = await UserService.instance
            .getUserByPhone(loginBody.username, context);
        if (getUserResponse['status'] == false) {
          return {'status': false, 'message': 'Failed to get user'};
        } else {
          User convertedUser = User.jsonToUser(getUserResponse['body']);
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('user_id', convertedUser.id);
          prefs.setString('phone_number', convertedUser.phone_number);
          prefs.setString('email', convertedUser.email);
          context.read<UserProvider>().setUser(convertedUser);
          var shadowingResponse =
              await ShadowingService.instance.getAllShadowing(context);
          if (shadowingResponse['status'] == true) {
            if (shadowingResponse['body'] != null) {
              for (final shadowing in shadowingResponse['body']) {
                context.read<ShadowingProvider>().addToShadowings(shadowing);
              }
            }
          } else {
            return {'status': false, 'message': 'Failed to retrieve shadowing'};
          }
        }
        this.resendSms(UnauthenticatedUserBody(username: loginBody.username));
        return {'status': false, 'message': 'MFA_NEEDED'};
      } else {
        print(data);
        print('Request failed with status: ${response.statusCode}.');
        return {'status': false, 'message': data['message']};
      }
      return {'status': true};
    } catch (err) {
      print(err);
      return {'status': false};
    }
  }

  Future validateSms(VerifyAttributeBody verifyAttributeBody) async {
    print('inside call');
    final url = '$_hostUrl/validate-sms';
    var headers = await getHeaders(null);
    Object body = verifyAttributeBody.toJson();
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(data);
      print(response.statusCode);
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

  Future resendSms(UnauthenticatedUserBody unauthenticatedUserBody) async {
    final url = '$_hostUrl/resend-sms';
    var headers = await getHeaders(null);
    Object body = unauthenticatedUserBody.toJson();
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
      VerifyAttributeBody verifyAttributeBody, BuildContext context) async {
    final url = '$_hostUrl/validate-email';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    Object body = verifyAttributeBody.toJson();
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

  Future getEmailCode(LoginBody loginBody, BuildContext context) async {
    final url = '$_hostUrl/get-email-code';
    var headers = await getHeaders(null);
    Object body = loginBody.toJson();
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

  Future updateUser(UserUpdateBody userUpdateBody, BuildContext context) async {
    final url = '$_hostUrl';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    print('TOKENS');
    print(tokens);
    var headers = await getHeaders(jsonEncode(tokens));
    final User user = context.read<UserProvider>().user;
    userUpdateBody.phone_number = user.phone_number;
    userUpdateBody.email = user.email;
    print(user);
    userUpdateBody.institution = getInstitution(user.email, context);

    Object body = userUpdateBody.toJson();

    try {
      print(headers);
      print(body);
      print(url);
      http.Response response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        // Setting the attributes to the user model so that we can access it anywhere - Sham
        user.first_name = userUpdateBody.first_name;
        user.last_name = userUpdateBody.last_name;
        user.school_year = userUpdateBody.school_year;
        user.degree = userUpdateBody.degree;
        user.institution = context.read<UserProvider>().setUser(user);
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
  Future startForgotPassword(
      UnauthenticatedUserBody unauthenticatedUserBody) async {
    final url = '$_hostUrl/start-forgot-password';
    var headers = await getHeaders(null);
    Object body = unauthenticatedUserBody.toJson();
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

  Future completeForgotPassword(ForgotPasswordBody forgotPasswordBody) async {
    final url = '$_hostUrl/complete-forgot-password';
    var headers = await getHeaders(null);
    Object body = forgotPasswordBody.toJson();
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

  Future signOutUser(UnauthenticatedUserBody unauthenticatedUserBody,
      BuildContext context) async {
    final url = '$_hostUrl/sign-out';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    Object body = unauthenticatedUserBody.toJson();
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        return {'status': true};
      } else
        throw Error();
    } catch (err) {
      return {'status': false};
    }
  }

  getInstitution(String email, BuildContext context) {
    var index = email.indexOf('@');
    var emailEnd = email.substring(index, email.length);
    switch (emailEnd) {
      case 'utrgv.edu':
        return 'Univeristy of Texas Rio Grande Valley';
      case 'tamu.edu':
        return 'Texas A&M University';
      case 'baylor.edu':
        return 'Baylor University';
      case 'upineapps.com':
        return 'Upine Apps University';
      case 'futrdoc.com':
        return 'FutrDoc University';
      default:
        return 'Upine Apps University';
    }
  }

  // Future changeUserAttribute() async{
  //   //create type on the frontend as well
  // }
}
