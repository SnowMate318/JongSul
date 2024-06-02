import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jongsul/functions/http_request.dart';
import 'dart:convert';
import 'package:jongsul/models/shared/shared.dart';
import 'package:get/get.dart';
import 'package:jongsul/screen/0_preliminary_screen/login_screen.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jongsul/strings.dart';

//태현상 저번에 만든 함수인데 이거쓸까 밑에꺼 쓸까????

Future<List<Shared>> getSharedList1(String? user, List<String>? tags) async {
  List<Shared> sharedList = [];

  if (user != null && tags != null) {
    debugPrint("잘못된 형식");
    return [];
  }

  // URL 쿼리 파라미터 구성
  List<String> queryParams = [];
  if (tags != null && tags.isNotEmpty) {
    String tagListString = tags.join(',');
    queryParams.add("tags=$tagListString");
  }
  if (user != null) {
    queryParams.add("user=$user");
  }
  String queryString = queryParams.isNotEmpty ? "?${queryParams.join('&')}" : "";

  Uri url = Uri.parse('$BASE_URL/shared/$queryString');

  try {
    http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          //Todo: 토큰인증 구현
      }
    );
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      for (var item in responseData) {
        Shared tmp = Shared.fromMap(item);
        List<String> newTagList = [];
        for(int i=0; item['shared_tags'].length;i++){
          String tag = item['shared_tags'][i]['name'];
          newTagList.add(tag);
        }
        tmp.sharedTags=newTagList;
        sharedList.add(tmp);
      }
      return sharedList;
    } else {
      debugPrint('Failed to load data: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    debugPrint('Error occurred: $e');
    return [];
  }
}

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

// 상세 조회 페이지 커뮤니티 조회
Future<Shared> getShared(int sharedId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/shared/$sharedId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  response = await http.get(uri, headers: header);

  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    Shared shared = await getShared(sharedId);
    return shared;
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    //Todo: 로그인 화면 이동
    Get.offAll(LoginScreen);
    return Shared.init();
  } else if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    return Shared.fromMap(responseBody);
  } else {
    debugPrint(response.statusCode.toString());
    return Shared.init();
  }
}

//전체 커뮤니티 조회
Future<List<Shared>> getSharedList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/shared/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  response = await http.get(uri, headers: header);

  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    List<Shared> sharedList = await getSharedList();
    return sharedList;
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    //Todo: 로그인 화면 이동
    Get.offAll(LoginScreen());
    return [];
  } else if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    List<Shared> sharedList = [];
    for (Map<String, dynamic> map in responseBody) {
      Shared shared = Shared.fromMap(map);
      sharedList.add(shared);
    }
    return sharedList;
  } else {
    debugPrint(response.statusCode.toString());
    return [];
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
}

//커뮤니티 다운로드
Future<void> putShared(int sharedId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/shared/$sharedId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  response = await http.post(uri, headers: header);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    putShared(sharedId);
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    Get.offAll(LoginScreen);
  } else if (response.statusCode == 200) {
    //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
    //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
  } else {
    debugPrint(response.statusCode.toString());
  }
}
// 커뮤니티 삭제
Future<void> deleteShared(int sharedId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/shared/$sharedId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  response = await http.delete(uri, headers: header);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    deleteShared(sharedId);
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    Get.offAll(LoginScreen);
  } else if (response.statusCode == 200) {
    //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
    //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
  } else {
    debugPrint(response.statusCode.toString());
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
}

// 커뮤니티 패치, 수정
Future<void> patchShared(int sharedId, String sharedTitle, String sharedContent, List<String>tags) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/liarary/$sharedId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  List<Map<String,String>> uploadTags = [];
  for(String tag in tags){
    uploadTags.add({"name":tag});
  }
  Map<String,dynamic> body = {
    "shared_title": sharedTitle,
    "shared_content": sharedContent,
    "shared_tags": uploadTags,
  };
  response = await http.patch(uri, headers: header, body: body);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    patchShared(sharedId, sharedTitle, sharedContent, tags);
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    Get.offAll(LoginScreen);
  } else if (response.statusCode == 200) {
    //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
    //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
  } else {
    debugPrint(response.statusCode.toString());
  }
}



