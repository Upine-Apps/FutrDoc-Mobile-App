import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futr_doc/providers/tokenProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/Shadowing.dart';
import '../models/User.dart';
import '../providers/UserProvider.dart';

class ShadowingService {
  Future<Map<String, String>> getHeaders(String? tokens) async {
    final _headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Cognito": tokens ?? ''
    };
    return _headers;
  }

  //Uncomment for prod testing
  // static final _hostUrl = 'http://54.91.210.147:3000/shadowing';

  //Uncomment for local testing on Android
  // static final _hostUrl = 'http://10.0.2.2:3000/shadowing';

  //Uncomment for local testing on iOS
  static final _hostUrl = 'http://localhost:3000/shadowing';

  ShadowingService._privateConstructor();
  static final ShadowingService instance =
      new ShadowingService._privateConstructor();

  Future saveShadowing(Shadowing shadowing, BuildContext context) async {
    final url = '$_hostUrl';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    User user = context.read<UserProvider>().user;
    shadowing.user_id = user.id;
    Object body = shadowing.toJson();
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return {'status': true, 'body': data};
    } catch (err) {
      return {'status': false};
    }
  }

  Future getICD(String icdName, BuildContext context) async {
    final url = '$_hostUrl/icd/$icdName';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final List dataList = json.decode(response.body);
        return {'status': true, 'body': dataList};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future getAllShadowing(BuildContext context) async {
    User user = context.read<UserProvider>().user;
    final url = '$_hostUrl/user-id/${user.id}';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var bodyData = json.decode(response.body);
        if (bodyData['message'] == null) {
          final List dataList = bodyData['data'];
          return {'status': true, 'body': dataList};
        }
        return {'status': true};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future getRecentShadowing(BuildContext context) async {
    User user = context.read<UserProvider>().user;
    final url = '$_hostUrl/last-shadowing/${user.id}';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var bodyData = json.decode(response.body);
        final data = bodyData['data'];
        return {'status': true, 'body': data};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future getOverview(BuildContext context) async {
    User user = context.read<UserProvider>().user;
    final url = '$_hostUrl/overview/${user.id}';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var bodyData = json.decode(response.body);
        final data = bodyData['data'];
        return {'status': true, 'body': data};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }

  Future getFilterData(BuildContext context) async {
    User user = context.read<UserProvider>().user;
    final url = '$_hostUrl/filter/${user.id}';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var bodyData = json.decode(response.body);
        final data = bodyData['data'];
        return {'status': true, 'body': data};
      } else {
        return {'status': false};
      }
    } catch (err) {
      print(err);
      return {'status': false};
    }
  }

  Future getDataDashboard(BuildContext context, var body) async {
    User user = context.read<UserProvider>().user;
    final url = '$_hostUrl/data-dashboard';
    final Map<String, String> tokens =
        context.read<TokenProvider>().tokens.toJson();
    var headers = await getHeaders(jsonEncode(tokens));
    body['user_id'] = user.id;
    print('body: $body');
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        var bodyData = json.decode(response.body);
        final data = bodyData['data'];
        return {'status': true, 'body': data};
      } else {
        return {'status': false};
      }
    } catch (err) {
      return {'status': false};
    }
  }
}
