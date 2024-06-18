import 'package:flutter/material.dart';
import 'package:jongsul/models/directory/directory.dart';
import 'package:jongsul/models/directory/directory_data.dart';
import 'package:jongsul/models/directory/mini_directory.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/shared/shared_tag.dart';
import 'package:jongsul/screen/3_community_screen/community_screen.dart';
import 'package:jongsul/tools/style.dart';
import 'dart:async';

class UploadProblemScreen extends StatefulWidget {
  MiniDirectory directory;
  Library library;

  UploadProblemScreen(
      {required this.directory, required this.library, super.key});

  @override
  State<UploadProblemScreen> createState() => _UploadProblemScreenState();
}

class _UploadProblemScreenState extends State<UploadProblemScreen> {
  final TextEditingController _conceptController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  List<SharedTag> sharedTagList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("문제 공유")), // 앱바 사용
        body: SafeArea(
          //메인 화면
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 50, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '설명',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '(100자 이내)',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Center(
                  child: Padding(
                    child: TextFormField(
                      maxLength: 100,
                      maxLines: 5,
                      controller: _conceptController,
                      decoration: InputDecoration(
                        hintText: '설명을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                        counterText: '', //글자수 제한 표시 없앰
                      ),
                      validator: (value) {
                        //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                        if (value!.isEmpty) {
                          return '공유 디렉토리 설명 입력해줘';
                        }

                        return null;
                      },
                      // textInputAction: TextInputAction.search,
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '태그',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 35,
                          child: TextFormField(
                            maxLength: 20,
                            controller: _tagController,
                            textAlignVertical: TextAlignVertical.top,
                            //textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '태그를 입력해 주세요.',
                              //border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: Color(0xFF8B5000)),
                              border: InputBorder.none,
                              counterText: '', //글자수 제한 표시 없앰
                            ),
                            validator: (value) {
                              //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                              if (value == null || value.isEmpty) {
                                return '공유 디렉토리 태그 입력해줘';
                              }

                              return null;
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (_tagController.text.isNotEmpty) {
                              sharedTagList.add(
                                  SharedTag.init(name: _tagController.text));
                              setState(() {});
                            }
                          },
                          child: Text('태그 추가',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF8B5000),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                        ),
                      ]),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  _buildTagChips(),
                ],),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: ElevatedButton(
                        //icon: Icon(Icons.download, size: 18),
                        child: Text("공유하기",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        onPressed: () async {
                          await shareDirectory(
                            widget.library.title,
                            widget.directory,
                            sharedTagList,
                            _conceptController.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CommunityScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFF8B5000),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTagChips() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: sharedTagList.map((SharedTag tag) {
        return Chip(
          label: Text(
            tag.name,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Color(0xFF8B5000), // 테두리 색상을 검은색으로 설정
              width: 1, // 테두리 두께 설정
            ),
          ),
          deleteIcon: Icon(Icons.cancel_outlined, size: 18, color: Color(0xFF8B5000),),
          onDeleted: () {
            setState(() {
              sharedTagList.remove(tag);
            });
          },
        );
      }).toList(),
    );
  }
}
