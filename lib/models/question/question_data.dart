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
Future<List<Question>> getProblemChoice(int directoryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse(
      '$BASE_URL/api/directory/$directoryId/question/test/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  response = await http.get(uri, headers: header);

  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    List<Question> problemChoice = await getProblemChoice(directoryId);
    return problemChoice;
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    //Todo: 로그인 화면 이동
    Get.offAll(LoginScreen());
    return [];
  } else if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    List<Question> problemChoice = [];
    for (Map<String, dynamic> map in responseBody) {
      Question question = Question.fromMap(map);
      problemChoice.add(question);
    }
    return problemChoice;
  } else {
    debugPrint(response.statusCode.toString());
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
  response = await http.get(uri, headers: header);

  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    Question question = await getQuestion(questionId);
    return question;
  } else if (response.statusCode == 400) {
    // access token이 invalid할 경우
    //Todo: 로그인 화면 이동
    Get.offAll(LoginScreen);
    return Question.init();
  } else if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    return Question.fromMap(responseBody);
  } else {
    debugPrint(response.statusCode.toString());
    return Question.init();
  }
}

//
// //디렉토리 추가, 포스트
// Future<void> addDirectory(int libraryId,
//     String title,
//     String script,
//     int difficulty,
//     int multipleChoice,
//     int shortAnswer,
//     int oxProb,
//     int allProb) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
//   String accessToken = prefs.getString('access_token') ?? '';
//   Uri uri =
//   Uri.parse('http://127.0.0.1:8000/api/library/$libraryId/directory/');
//   http.Response response;
//   Map<String, String> header = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $accessToken',
//   };
//   Map<String, dynamic> body = {
//     'title': title,
//     'script': script,
//     'difficulty': difficulty,
//     'multiple_choice': multipleChoice,
//     'short_answer': shortAnswer,
//     'ox_prob': oxProb,
//     'all_prob': allProb
//   };
//   response = await http.post(uri, headers: header, body: body);
//   if (response.statusCode == 401) {
//     // access token이 만료되었을 경우,
//     await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
//     addDirectory(
//         libraryId,
//         title,
//         script,
//         difficulty,
//         multipleChoice,
//         shortAnswer,
//         oxProb,
//         allProb);
//   } else if (response.statusCode == 400) {
//     // access token이 invalid할 경우
//     Get.offAll(LoginScreen);
//   } else if (response.statusCode == 200) {
//     //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
//     //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
//   } else {
//     debugPrint(response.statusCode.toString());
//   }
// }
//
// //디렉토리 공유, 포스트
// Future<void> shareDirectory(int directoryId,
//     String sharedTitle,
//     String sharedContent,) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
//   String accessToken = prefs.getString('access_token') ?? '';
//   Uri uri =
//   Uri.parse('http://127.0.0.1:8000/api/directory/$directoryId/share/');
//   http.Response response;
//   Map<String, String> header = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $accessToken',
//   };
//   Map<String, dynamic> body = {
//     'shared_title': sharedTitle,
//     'shared_content': sharedContent,
//   };
//   response = await http.post(uri, headers: header, body: body);
//   if (response.statusCode == 401) {
//     // access token이 만료되었을 경우,
//     await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
//     shareDirectory(
//       directoryId,
//       sharedTitle,
//       sharedContent,
//     );
//   } else if (response.statusCode == 400) {
//     // access token이 invalid할 경우
//     Get.offAll(LoginScreen);
//   } else if (response.statusCode == 200) {
//     //Todo: 생성 완료했을 때 로직 추가 ex) 전체 라이브러리 조회 페이지 리랜더링
//     //Todo: 만약 response.data(새로 만든 라이브러리에 대한 정보)가 필요한 경우 따로 말하기
//   } else {
//     debugPrint(response.statusCode.toString());
//   }
// }

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
  response = await http.delete(uri, headers: header);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    deleteQuestion(questionId);
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

// 문제 수정, 패치
Future<void> patchQuestion(int questionId, List<Choice> choices, int directory,
    String questionTitle, bool questionContent, String questionAnswer,
    String questionExplanation, int questionType, bool isScrapped,
    int questionNum) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/question/$questionId');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  List<Map<String, dynamic>> uploadChoices = choices.map((choice) {
    return {"choice_num": choice.choice_num, "choice_content": choice.choice_content};
  }).toList();

  Map<String, dynamic> body = {
    "id": questionId,
    "choices": uploadChoices,
    "directory": directory,
    "question_title": questionTitle,
    "question_content": questionContent,
    "question_answer": questionAnswer,
    "question_explanation": questionExplanation,
    "question_type": questionType,
    "is_scrapped": isScrapped,
    "question_num": questionNum
  };
  response = await http.patch(uri, headers: header, body: body);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    patchQuestion(
        questionId,
        choices,
        directory,
        questionTitle,
        questionContent,
        questionAnswer,
        questionExplanation,
        questionType,
        isScrapped,
        questionNum);
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

//문제 제출, 패치
Future<void> patchQuestionSubmmit(int questionId, int lastSolved) async {
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
  response = await http.patch(uri, headers: header, body: body);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    patchQuestionSubmmit(questionId, lastSolved);
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


//문제 스크랩, 패치
Future<void> patchQuestionScrap(int questionId, int isScrapped) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/question/$questionId/scrap/');
  http.Response response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  Map<String,dynamic> body = {
    "is_scrapped": isScrapped
  };
  response = await http.patch(uri, headers: header, body: body);
  if (response.statusCode == 401) {
    // access token이 만료되었을 경우,
    await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    patchQuestionScrap(questionId, isScrapped);
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