import 'package:flutter/material.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_user_choice_screen.dart';
import 'package:jongsul/screen/widget/download_button.dart';

class GenerateProblemScreen extends StatefulWidget {
  const GenerateProblemScreen({super.key});

  @override
  State<GenerateProblemScreen> createState() => _GenerateProblemScreenState();
}

class _GenerateProblemScreenState extends State<GenerateProblemScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController contentController = TextEditingController();

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
                    child: TextField(
                      maxLength: 20,
                      controller: subjectController,
                      decoration: InputDecoration(
                        hintText: '제목을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                        counterText: '', //글자수 제한 표시 없앰
                      ),
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
                    child: TextField(
                      // maxLines: 30, // 최대 높이(줄) 설정
                      // minLines: 1, // 최소 높이(줄) 설정
                      maxLength: 1000,
                      controller: contentController,
                      decoration: InputDecoration(
                        hintText: '내용을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                      ),
                      //textInputAction: TextInputAction.search,
                    ),
                    padding: EdgeInsets.all(20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          ElevatedButton(
                            //icon: Icon(Icons.download, size: 18),
                            child: Text("문제 생성하기"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GenerateProblemUserChoiceScreen()),
                              );

                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0XFF8B5000),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                textStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.normal)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
