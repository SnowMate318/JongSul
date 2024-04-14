import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jongsul/models/shared/shared.dart';

Future<List<Shared>> getSharedList(String? user, List<String>? tags) async {
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

  Uri url = Uri.parse('http://127.0.0.1/shared/$queryString');

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

