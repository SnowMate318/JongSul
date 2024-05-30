import 'package:flutter/material.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_multiple_choice_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';

class SolveProblemOxQuizScreen extends StatefulWidget {
  const SolveProblemOxQuizScreen({super.key});

  @override
  State<SolveProblemOxQuizScreen> createState() =>
      _SolveProblemOxQuizScreenState();
}

class _SolveProblemOxQuizScreenState extends State<SolveProblemOxQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("컴퓨터 네트워크"),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),
      ),
      bottomNavigationBar: DownMenuBar(), // 앱바 사용
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '제 1장',
                        style: TextStyle(fontSize: 25),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star),
                          Text('1'),
                          Text('/'),
                          Text('15'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1. 다음중 참 거짓을 판별하시오'),
                      SizedBox(height: 50),
                      Text('TCP와 CDP는 어플리케이션 계층 프로토콜에 속한다.'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [

                  ElevatedButton(
                    onPressed: () {
                      // 버튼이 눌렸을 때의 동작
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 모서리 둥글기
                      ),
                      fixedSize: Size(70, 70), // 정사각형 크기
                    ),
                    child: Text(
                      'O',
                      style: TextStyle(fontSize: 45),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 버튼이 눌렸을 때의 동작
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 모서리 둥글기
                      ),
                      fixedSize: Size(70, 70), // 정사각형 크기
                    ),
                    child: Text(
                      'X',
                      style: TextStyle(fontSize: 45),
                    ),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SolveProblemMultipleChoiceScreen()),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
