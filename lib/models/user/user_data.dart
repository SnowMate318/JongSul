import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;
import 'package:jongsul/models/user/service_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/controller_my_info.dart';
import '../../functions/http_request.dart';
import '../../screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/strings.dart';

Future<void> tokenRefresh(SharedPreferences prefs) async {
  Uri uri = Uri.parse('$BASE_URL/api/token/refresh/');
  String refreshToken = prefs.getString('refresh_token') ?? '';
  // {
  //   "refresh": "enskagharktjaslkyhrselkygjdslkures;atawekjrhlsrj;egahejorv"
  // }
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

Future<ServiceUser> getServiceUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();// 저장소

  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/auth/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  response = await http.get(
      uri,
      headers: header
  );

  if (response.statusCode == 401) { // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    ServiceUser serviceUser = await getServiceUser();
    return serviceUser;
  } else if (response.statusCode == 400) { // access token이 invalid할 경우
    debugPrint(response.body);
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
  if (response.statusCode == 200) {
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    return ServiceUser.fromMap(responseBody);
  } else {
    debugPrint(response.statusCode.toString());
    return ServiceUser.init();
  }
}

Future<ServiceUser> signUp(String email, String password) async{
  //회원가입 후 ServiceUser 객체 반환
  Uri uri = Uri.parse('$BASE_URL/api/register/');
  var data = jsonEncode({
    'email': email,
    'password': password,
  });

  try{
    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: data,
    );
    if(response.statusCode == 200){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      prefs.setString("access_token", responseBody['token']['access']);
      prefs.setString("refresh_token", responseBody['token']['refresh']);
      return ServiceUser.fromMap(responseBody['user']);
    } else {
      // 에러 처리
      debugPrint('인증 실패: ${response.body}');
      return ServiceUser.init();
    }
  } catch (e) {
    // 네트워크 요청 실패 시 처리
    debugPrint('네트워크 요청 실패: $e');
    return ServiceUser.init();
  }
  
}
Future<ServiceUser> loginRetUser(String email, String password) async {
  Uri authUri = Uri.parse('$BASE_URL/api/auth/'); // HTTPS 사용 권장
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
      // MyInfo myInfo = Get.find();
      // myInfo.setMyInfo(serviceUser);
      return serviceUser;
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

Future<void> login(String email, String password) async {
  Uri authUri = Uri.parse('$BASE_URL/api/auth/'); // HTTPS 사용 권장
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

      String? accessToken = prefs.getString("access_token");
      // 유저 데이터 맵을 클래스로 변환
      ServiceUser serviceUser = await getServiceUser();
      MyInfo myInfo = Get.find();
      myInfo.setMyInfo(serviceUser);

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
    }
  } catch (e) {
    // 네트워크 요청 실패 시 처리
    debugPrint('Error making authentication request: $e');
  }
}

// Future<ServiceUser> signUpForKakao()async{
//   Uri uri = Uri.parse('$BASE_URL/api/kakao/login');
//
//   try{
//     http.Response response = await http.get(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//     );
//     if(response.statusCode == 200){
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
//       prefs.setString("access_token", responseBody['token']['access']);
//       prefs.setString("refresh_token", responseBody['token']['refresh']);
//       return ServiceUser.fromMap(responseBody);
//     } else {
//       // 에러 처리
//       debugPrint('인증 실패: ${response.body}');
//       return ServiceUser.init();
//     }
//   } catch (e) {
//     // 네트워크 요청 실패 시 처리
//     debugPrint('네트워크 요청 실패: $e');
//     return ServiceUser.init();
//   }
// }

Future<ServiceUser> signUpForKakao()async{
  // if (await isKakaoTalkInstalled()) {
  //   try {
  //     await UserApi.instance.loginWithKakaoTalk();
  //     print('카카오톡으로 로그인 성공');
  //   } catch (error) {
  //     print('카카오톡으로 로그인 실패 $error');
  //
  //     // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
  //     // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
  //     if (error is PlatformException && error.code == 'CANCELED') {
  //       return ServiceUser.init();
  //     }
  //     // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
  //     try {
  //       await UserApi.instance.loginWithKakaoAccount();
  //       print('카카오계정으로 로그인 성공');
  //     } catch (error) {
  //       print('카카오계정으로 로그인 실패 $error');
  //     }
  //   }
  // } else {
  //   try {
  //     await UserApi.instance.loginWithKakaoAccount();
  //     print('카카오계정으로 로그인 성공');
  //   } catch (error) {
  //     print('카카오계정으로 로그인 실패 $error');
  //   }
  // }
  return ServiceUser.init();
}

// data =
// {
//   "name": "수정할 이름",
//   "profiile_image": "수정할 프로필 url"
// }
Future<ServiceUser?> setServiceUserRetUser({required Map<String, dynamic> data}) async {

  Uri uri = Uri.parse('$BASE_URL/api/auth/');
  http.Response response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token')??'';
  response = await http.patch(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    },
    body: jsonEncode(data),
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
    Get.offAll(LoginScreen);
  }
  if(response.statusCode==200){
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    ServiceUser newUser = ServiceUser.fromMap(responseBody);
    return newUser;
  } else {
    debugPrint(response.statusCode.toString());
  }
  return null;

}

Future<bool> setServiceUser({required Map<String, dynamic> data}) async {

  Uri uri = Uri.parse('$BASE_URL/api/auth/');
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
    Get.offAll(LoginScreen);
  }
  if(response.statusCode==200){
    return true;
  } else {
    debugPrint(response.statusCode.toString());
  }
  return false;

}


Future<bool> deleteServiceUser() async {
  Uri uri = Uri.parse('$BASE_URL/api/auth/delete/');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //shared preference 초기화
    prefs.remove('access_token');
    prefs.remove('refresh_token');
    debugPrint("유저 정보가 성공적으로 삭제되었습니다.");
    return true;
  } else {
    debugPrint(response.statusCode.toString());
    return false;
  }

}

Future<bool> logout() async {
  try{
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('access_token');
      prefs.remove('refresh_token');
    });
    return true;
  }
  catch(e){
    debugPrint('로그아웃 실패: $e');
    return false;
  }
}