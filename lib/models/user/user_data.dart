import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;
import 'package:jongsul/models/user/service_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/controller_my_info.dart';

Future<void> tokenRefresh(SharedPreferences prefs) async {
  Uri uri = Uri.parse('http://127.0.0.1/token/refresh/');
  String refreshToken = prefs.getString('refresh_token') ?? '';
  var data = jsonEncode({
    'refresh': refreshToken,
  });
  http.Response refreshResponse = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      }
  );
  var responseBody = jsonDecode(refreshResponse.body);
  await prefs.setString("access_token", responseBody['token']['access']);
  await prefs.setString("refresh_token", responseBody['token']['refresh']);
}

Future<ServiceUser> getServiceUser({String? token}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('http://127.0.0.1/auth/');
  http.Response response;

  response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      }
  );
  if (response.statusCode == 401) { // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    accessToken = prefs.getString('access_token')??'';
    uri = Uri.parse('http://127.0.0.1/auth/');
    response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        }
    );
  } else if (response.statusCode == 400) { // access token이 invalid할 경우
    //Todo: 로그인 화면으로 이동하는 로직

  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    return ServiceUser.fromMap(responseBody);
  } else {
    debugPrint(response.statusCode.toString());
    return ServiceUser.init();
  }
}

Future<ServiceUser> login(String email, String password) async {
  Uri authUri = Uri.parse('http://127.0.0.1/auth/'); // HTTPS 사용 권장
  var data = jsonEncode({
    'email': email,
    'password': password,
  });

  try {
    http.Response authResponse = await http.post(
      authUri,
      headers: {'Content-Type': 'application/json'},
      body: data,
    );

    if (authResponse.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseBody = jsonDecode(authResponse.body);

      // json web token를 활용하여 access_token, refresh_token을 로컬 스토리지에 저장
      prefs.setString("access_token", responseBody['token']['access']);
      prefs.setString("refresh_token", responseBody['token']['refresh']);

      // 유저 데이터 맵을 클래스로 변환
      ServiceUser serviceUser = ServiceUser.fromMap(responseBody['user']);

      if (await setServiceUser(data: serviceUser.toJson())) {
        MyInfo myInfo = Get.find();
        return await myInfo.getMyInfo();
      } else {
        debugPrint("ServiceUser 정보를 제대로 가져오지 못함");
        return ServiceUser.init();
      }

      // if(serviceUser.user_name==''){ // 유저네임이 없을 경우 랜덤 생성
      //   Uri uri = Uri.parse('https://nickname.hwanmoo.kr/?format=json&count=15');
      //   http.Response response = await http.get(uri); //TODO: 랜덤 이름 생성기. 추후 자체서버 구현 필요
      //   String username = 'invalid user';
      //   for (String word in jsonDecode(response.body)['words']) {
      //     if (word.length < 10) username = word;
      //   }
      //   DateTime now = await NTP.now();
      //   String nowString = now.toIso8601String();
      //   http.Response patchUser = await http.patch(uri,body:{"user_name":username, "updated_at": nowString});
      //   if(patchUser.statusCode == 400);
      // }

    } else {
      // 에러 처리
      debugPrint('Authentication failed: ${authResponse.body}');
      return ServiceUser.init();
    }
  } catch (e) {
    // 네트워크 요청 실패 시 처리
    debugPrint('Error making authentication request: $e');
    return ServiceUser.init();
  }
}



Future<bool> setServiceUser({String? token, required Map<String, dynamic> data}) async {
  Uri uri = Uri.parse('http://127.0.0.1/auth/');
  http.Response response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token')??'';
  response = await http.patch(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    },
    body: data,
  );

  if(response.statusCode==401){
    await tokenRefresh(prefs);
    accessToken = prefs.getString('access_token')??'';
    response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: data,
    );
  }else if (response.statusCode == 400) {
    //Todo: 로그인 화면으로 이동하는 로직

  }
  if(response.statusCode==200){
    return true;
  } else {
    debugPrint(response.statusCode.toString());
    return false;
  }

}

Future<bool> deleteServiceUser({String? token, String? email}) async {
  Uri uri = Uri.parse('http://127.0.0.1/auth/delete/');
  http.Response response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token')??'';
  response = await http.delete(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    },
  );
  if(response.statusCode==401){
    await tokenRefresh(prefs);
    accessToken = prefs.getString('access_token')??'';
    response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );
  }else if (response.statusCode == 400) {
    //Todo: 로그인 화면으로 이동하는 로직

  }
  if(response.statusCode==200){
    debugPrint("유저 정보가 성공적으로 삭제되었습니다.");
    return true;
  } else {
    debugPrint(response.statusCode.toString());
    return false;
  }

}
