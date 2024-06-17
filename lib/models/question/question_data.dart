import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jongsul/models/directory/directory.dart';
import 'package:jongsul/models/question/choice.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;
import 'package:jongsul/models/library/library.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/http_request.dart';
import '../../screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/strings.dart';

// 문제+선택지 테스트뷰 조회
Future<List<Question>> getQuestionList(int directoryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse(
      '$BASE_URL/api/directory/$directoryId/question/test/');
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

      return [];
    } if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<Question> problemChoice = [];
      for (Map<String, dynamic> map in responseBody) {
        Question question = Question.fromMap(map);
        // if(question.question_type==1){
        //   question.choices = (map['choices'] as List<dynamic>?)
        //       ?.map((choice) => Choice.fromMap(choice))
        //       ?.toList() ?? [];
        // }
        problemChoice.add(question);
      }
      return problemChoice;
    } else {
      debugPrint(response.statusCode.toString());
      return [];
    }
  }catch(e){
    debugPrint(e.toString());
    return [];
  }
}

//문제 상세 조회
Future<Question> getQuestion(int questionId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse(
      '$BASE_URL/api/question/$questionId/question/test/');
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
      return Question.init();
    } if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      return Question.fromMap(responseBody);
    } else {
      debugPrint(response.statusCode.toString());
      return Question.init();
    }
  }catch(e){
    debugPrint(e.toString());
    return Question.init();

  }
}

// 문제 삭제
Future<void> deleteQuestion(int questionId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/question/$questionId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  try{
    response = await http.delete(uri, headers: header);
    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.delete(uri, headers: header);
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우
      Get.offAll(LoginScreen);
    } if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
    } else {
      debugPrint(response.statusCode.toString());
    }
  }catch(e){
    debugPrint(e.toString());
  }
  //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
}

// 문제 수정, 패치
Future<void> patchQuestion(Question question) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int id = question.id;
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/question/$id');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };


  Map<String, dynamic> body = {
    "choices": question.choices.map((choice) => choice.toJson()).toList(),
    "question_title": question.questionTitle,
    "question_answer": question.questionAnswer,
    "question_explanation": question.questionExplanation,
  };
  debugPrint(jsonEncode(body));
  try{
    response = await http.patch(uri, headers: header, body: jsonEncode(body));
    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.patch(uri, headers: header, body: jsonEncode(body));
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우

    } if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
    } else {
      debugPrint(response.statusCode.toString());
    }
  }catch(e){
    debugPrint(e.toString());
  }
}

//문제 제출, 패치
Future<void> patchQuestionSubmit(int questionId, bool? lastSolved) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/question/$questionId/solve/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  Map<String,dynamic> body = {
    "last_solved": lastSolved
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

    } if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기

    } else {
      debugPrint(response.statusCode.toString());
    }
  } catch(e){
    debugPrint(e.toString());
  }
}


//문제 스크랩, 패치
Future<void> patchQuestionScrap(int questionId, bool isScrapped, String directoryName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/question/$questionId/scrap/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  Map<String,dynamic> body = {
    "is_scrapped": isScrapped,
    "dir_name": directoryName,
    "question_id": questionId,
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

    }
    if (response.statusCode == 200) {
      //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
      //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
    } else {
      debugPrint(response.statusCode.toString());
    }
  } catch(e){
    debugPrint(e.toString());
  }
}