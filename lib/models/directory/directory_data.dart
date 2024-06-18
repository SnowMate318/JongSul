import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jongsul/models/directory/directory.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;
import 'package:jongsul/models/library/library.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/http_request.dart';
import '../../screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/strings.dart';

import '../shared/shared_tag.dart';
import 'mini_directory.dart';

// 상세 조회 페이지 디렉토리 조회
Future<Directory> getDirectory(int directoryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/directory/$directoryId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  try{
    response = await http.get(uri, headers: header);

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);
    } else if (response.statusCode == 400) {
      // 잘못된 요청
    }
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      return Directory.fromMap(responseBody);
    } else {
      debugPrint(response.statusCode.toString());
      return Directory.init();
    }
  }catch(e){
    debugPrint(e.toString());
    return Directory.init();
  }
}

//전체 디렉토리 조회
Future<List<Directory>> getDirectoryList(int libraryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/library/$libraryId/directory/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  try{
    response = await http.get(uri, headers: header);

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우
      //Todo: 로그인 화면 이동
      Get.offAll(LoginScreen);
      return [];
    }
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<Directory> directoryList = [];
      for (Map<String, dynamic> map in responseBody) {
        Directory directory = Directory.fromMap(map);
        directoryList.add(directory);
      }
      return directoryList;
    } else {
      debugPrint(response.statusCode.toString());
      return [];
    }
  }catch (e){
    debugPrint(e.toString());
    return [];
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
}

//디렉토리 추가, 포스트
Future<MiniDirectory> addDirectory(
    int libraryId,
    String title,
    String script,
    int difficulty,
    int multipleChoice,
    int shortAnswer,
    int oxProb,
    ) async {
  int allProb = multipleChoice + shortAnswer + oxProb;
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/library/$libraryId/directory/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  Map<String, dynamic> body = {
    'title': title,
    'script': script,
    'difficulty': difficulty,
    'multiple_choice': multipleChoice,
    'short_answer': shortAnswer,
    'ox_prob': oxProb,
    'all_prob': allProb
  };
  try{
    response = await http.post(uri, headers: header, body: jsonEncode(body));
    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.post(uri, headers: header, body: jsonEncode(body));
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우
      Get.offAll(LoginScreen);
    }
    if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      return MiniDirectory.fromMap(responseBody);
    } else {
      debugPrint('네트워크 에러, ResponseCode: ${response.statusCode.toString()}');
      return MiniDirectory.init();
    }
  } catch (e){
    debugPrint(e.toString());
    return MiniDirectory.init();
  }
}

//디렉토리 공유, 포스트
Future<void> shareDirectory(String libraryName, MiniDirectory directory,
    List<SharedTag> sharedTags, String concept) async {
  String sharedTitle = '$libraryName/${directory.title}';
  List<Map<String, dynamic>> tags = [];
  for (var tag in sharedTags) {
    tags.add(tag.toJson());
  }
  String sharedContent = concept;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/directory/${directory.id}/share/');
  var header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  var body = {
    'shared_title': sharedTitle,
    'shared_content': sharedContent,
    'shared_tags': tags,
  };
  try {
    http.Response response =
    await http.post(uri, headers: header, body: jsonEncode(body));
    if (response.statusCode == 401) {
      await tokenRefresh(prefs);
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response =
      await http.post(uri, headers: header, body: jsonEncode({body}));
    }
    if (response.statusCode == 200) {
      debugPrint('Success');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

// 디렉토리 삭제
Future<void> deleteDirectory(int directoryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/directory/$directoryId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  try {
    response = await http.delete(uri, headers: header);
    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      deleteDirectory(directoryId);
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우
    }
    if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
    } else {
      debugPrint(directoryId.toString());
      debugPrint(response.statusCode.toString());
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
}

// 디렉토리 패치
Future<void> patchDirectory(
    int directoryId, String title, String concept) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/directory/$directoryId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  Map<String, dynamic> body = {"title": title, "concept": concept};
  try {
    response = await http.patch(uri, headers: header, body: jsonEncode(body));
    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.patch(uri, headers: header, body: jsonEncode(body));
    } else if (response.statusCode == 400) {}

    if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
    } else {
      debugPrint(response.statusCode.toString());
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
