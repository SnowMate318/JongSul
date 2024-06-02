import 'package:flutter/material.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_user_choice_screen.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_final_screen.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_oxquiz_screen.dart';
import 'package:jongsul/screen/widget/download_button.dart';

class SolveProblemScreen extends StatefulWidget {
  const SolveProblemScreen({super.key});

  @override
  State<SolveProblemScreen> createState() => _SolveProblemScreenState();
}

class _SolveProblemScreenState extends State<SolveProblemScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("컴퓨터 네트워크"),
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
                    maxLines: 300,
                    // 최대 높이(줄) 설정
                    minLines: 1,
                    // 최소 높이(줄) 설정
                    maxLength: 1000,
                    controller: contentController,
                    decoration: InputDecoration(
                        hintText: '내용을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                        counterText: ''),
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
                      children: [],
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0), // 원하는 여유 공간 추가
        child: ElevatedButton(
          //icon: Icon(Icons.download, size: 18),
          child: Text("문제 풀어보기"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SolveProblemFinalScreen()),
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
