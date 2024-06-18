import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_user_choice_screen.dart';
import 'package:jongsul/screen/widget/download_button.dart';

class GenerateProblemScreen extends StatefulWidget {
  Library library;
  String? text;
  GenerateProblemScreen({required this.library,
    this.text,
    super.key});

  @override
  State<GenerateProblemScreen> createState() => _GenerateProblemScreenState();
}

class _GenerateProblemScreenState extends State<GenerateProblemScreen> {
  final TextEditingController _directoryTitleController = TextEditingController();
  final TextEditingController _conceptController = TextEditingController(
      );
  @override
  void initState() {
    // TODO: implement initState
    if(widget.text!=null){
      String sanitizedText = widget.text!.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');
      _conceptController.text = sanitizedText;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("문제 생성"),
          shape: Border(
            bottom: BorderSide(
              color: Color(0xFFD5C3B5),
              width: 1,
            ),
          ),
        ),
        body: SafeArea(
          //메인 화면
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //검색창
                Center(
                  child: Padding(
                    child: TextFormField(
                      maxLength: 20,
                      controller: _directoryTitleController,
                      decoration: InputDecoration(
                        hintText: '디렉토리 제목을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                        counterText: '', //글자수 제한 표시 없앰
                      ),
                      validator: (value) {
                        //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                        if (value != null && value.isEmpty) {
                          return '디렉토리 제목 입력해줘';
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
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      maxLines: null, // 최대 높이(줄) 설정
                     // minLines: 1, // 최소 높이(줄) 설정

                      maxLength: 10000,
                      controller: _conceptController,
                      decoration: InputDecoration(
                        hintText: '문제를 생성할 개념을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                        if (value != null && value.isEmpty) {
                          return '생성 문제 개념 입력해줘';
                        }
                        return null;
                      },
                      //textInputAction: TextInputAction.search,
                    ),

                  ),
                ),

                // FlatButton(
                //   onPressed: () {
                //     // 여기에 게시글을 서버에 전송하는 로직을 추가할 수 있습니다.
                //     String postContent = subjectController.text;
                //   },
                //   color: Colors.blue,
                //   textColor: Colors.white,
                //   child: Text('Post'),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       child: Column(
                //         children: [
                //           ElevatedButton(
                //             //icon: Icon(Icons.download, size: 18),
                //             child: Text("문제 생성하기"),
                //             onPressed: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(builder: (context) => GenerateProblemUserChoiceScreen(library: widget.library, title: _directoryTitleController.text, concept: _conceptController.text )),
                //               );
                //
                //             },
                //             style: ElevatedButton.styleFrom(
                //                 foregroundColor: Colors.white,
                //                 backgroundColor: Color(0XFF8B5000),
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal: 30, vertical: 15),
                //                 textStyle: TextStyle(
                //                     fontSize: 14, fontWeight: FontWeight.normal)),
                //           )
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0), // 원하는 여유 공간 추가
        child: ElevatedButton(
          //icon: Icon(Icons.download, size: 18),
          child: Text("문제 생성하기"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GenerateProblemUserChoiceScreen(library: widget.library, title: _directoryTitleController.text, concept: _conceptController.text )),
            );

          },
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0XFF8B5000),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle:
              TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}