import 'package:flutter/material.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_short_answer_screen.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';

class SolveProblemMultipleChoiceScreen extends StatefulWidget {
  const SolveProblemMultipleChoiceScreen({super.key});

  @override
  State<SolveProblemMultipleChoiceScreen> createState() =>
      _SolveProblemMultipleChoiceScreenState();
}

class _SolveProblemMultipleChoiceScreenState
    extends State<SolveProblemMultipleChoiceScreen> {
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
                      Text('1. 다음 설명으로 옳은 것을 고르시오'),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 버튼이 눌렸을 때의 동작
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // 모서리 둥글기
                          ),
                          fixedSize: Size(360, 70), // 정사각형 크기
                        ),
                        child: Row(children: [Text('1. '),Text(
                          ('aaaaaaaaaaaaaaaaaaaaaaaaaa'),
                          //style: TextStyle(fontSize: 32),
                        ),
                        ],),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text("OUTLINED BUTTON"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text("OUTLINED BUTTON"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text("OUTLINED BUTTON"),
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
                                      SolveProblemShortAnswerScreen()),
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
