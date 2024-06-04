import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../screen/0_preliminary_screen/login_screen.dart';
import '../strings.dart';

Future<void> tokenRefresh(SharedPreferences prefs) async {
  Uri uri = Uri.parse('$BASE_URL/api/token/refresh/');
  String refreshToken = prefs.getString('refresh_token') ?? '';
  var data = jsonEncode({
    'refresh': refreshToken,
  });
  http.Response refreshResponse = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data
  );
  var response = jsonDecode(refreshResponse.body);

  if(response.statusCode==200){
    debugPrint(response);
    await prefs.setString("access_token", response['access']);
    await prefs.setString("refresh_token", response['refresh']);

  } else if(response.statusCode==401){
    Get.offAll(LoginScreen);
  } else {
    //Todo: 에러코드 알림
  }

}
