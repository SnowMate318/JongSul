import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;
import 'package:jongsul/models/library/library.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/http_request.dart';
import '../../screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/strings.dart';

// 상세 조회 페이지 라이브러리 조회
Future<Library> getLibrary(int libraryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/library/$libraryId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
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
    return Library.init();
  }
  if (response.statusCode == 200) {
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    return Library.fromMap(responseBody);
  } else {
    debugPrint(response.statusCode.toString());
    return Library.init();
  }
}

//전체 라이브러리 조회
Future<List<Library>> getLibraryList() async {
  List<Library> libraryList = [];
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/library/');
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
      return libraryList;
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우
      //Todo: 로그인 화면 이동
      Get.offAll(LoginScreen);
      return [];
    }
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(responseBody.toString());
      List<Library> libraryList = [];
      for (Map<String, dynamic> map in responseBody) {
        Library library = Library.fromMap(map);
        libraryList.add(library);
      }
      return libraryList;
    } else {
      debugPrint(response.statusCode.toString());
      return [];
    }
  } catch(e){
    debugPrint(e.toString());
    return [];
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
}

//라이브러리 추가
//
Future<void> addLibrary(String title) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/library/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  Map<String, dynamic> body = {'title': title};
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
    } else if (response.statusCode == 201) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기

    } else {
      debugPrint(response.statusCode.toString());
    }
  } catch (e){
    debugPrint(e.toString());
  }
}
// 라이브러리 삭제
Future<void> deleteLibrary(int libraryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/library/$libraryId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  response = await http.delete(uri, headers: header);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    deleteLibrary(libraryId);
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    Get.offAll(LoginScreen);
  } if (response.statusCode == 200) {
    //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
    //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
  } else {
    debugPrint(response.statusCode.toString());
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
}

// 라이브러리 패치
Future<void> patchLibrary(int libraryId, String title) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/library/$libraryId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  Map<String,dynamic> body = {
    "title": title
  };
  try{
    response = await http.patch(uri, headers: header, body: jsonEncode(body));
    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.patch(uri, headers: header, body: jsonEncode(body));
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우
      Get.offAll(LoginScreen);
    }
    if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
    } else {
      debugPrint(response.statusCode.toString());
    }
  }catch(e){
    debugPrint(e.toString());
  }
}
