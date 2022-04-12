import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futr_doc/models/ICD.dart';
import 'package:futr_doc/models/Tokens.dart';
import 'package:futr_doc/models/types/ForgotPasswordBody.dart';
import 'package:futr_doc/models/types/LoginBody.dart';
import 'package:futr_doc/models/types/UnauthenticatedUserBody.dart';
import 'package:futr_doc/models/types/UserSignUpBody.dart';
import 'package:futr_doc/models/types/UserUpdateBody.dart';
import 'package:futr_doc/models/types/VerifyAttributeBody.dart';
import 'package:futr_doc/providers/tokenProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
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
  static final _hostUrl = 'http://10.0.2.2:3000/shadowing';

  //Uncomment for local testing on iOS
  // static final _hostUrl = 'http://localhost:3000/shadowing';

  ShadowingService._privateConstructor();
  static final ShadowingService instance =
      new ShadowingService._privateConstructor();

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
}
