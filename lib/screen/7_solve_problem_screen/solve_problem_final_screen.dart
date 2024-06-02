import 'package:flutter/material.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/models/question/question_data.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_short_answer_screen.dart';
import 'package:jongsul/screen/widget/multiple_choice.dart';
import 'package:jongsul/screen/widget/ox_quiz.dart';
import 'package:jongsul/screen/widget/short_answer.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';

class SolveProblemFinalScreen extends StatefulWidget {
  const SolveProblemFinalScreen({super.key});

  @override
  State<SolveProblemFinalScreen> createState() =>
      _SolveProblemFinalScreenState();
}

class _SolveProblemFinalScreenState extends State<SolveProblemFinalScreen> {
  late List<Question> questionList;
  Question question = Question.init(
    id: 13,
    choices: [
      // {choice_num: 1, choice_content: "호스트가 어플리케이션 서비스를 전달해주는 목적의 레이어"},
      // {choice_num: 2, choice_content: "네트워크로 의사소통하는 목적의 레이어"},
      // {choice_num: 3, choice_content: "데이터를 저장하는 목적의 레이어"},
      // {choice_num: 4, choice_content: "데이터를 전송하는 목적의 레이어"}
      ///적용이 안되는중 ㅠㅠㅠㅠㅠ
    ],
    question_num: 13,
    question_title: '나는 전자공학부 학생이다.',
    question_content: [],
    question_answer: 'O',
    question_explanation: '',
    question_type: 3,
    is_scrapped: false,
  );

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    questionList = await getProblemChoice(13);

    super.didChangeDependencies();
  }

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
                          IconButton(
                            onPressed: () {
                              setState(() {
                                question.is_scrapped = !question.is_scrapped;
                              });
                              //스크랩 유무에 따른 동작 변화 만들기
                            },

                            // icon: Icon(Icons.star,
                            //   color: question.is_scrapped ? Colors.yellow : Colors
                            //       .black,
                            // ),
                            icon: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.black,
                                  size: 30, // 아이콘 크기 조절
                                ),
                                Icon(
                                  Icons.star,
                                  color: question.is_scrapped ? Colors.yellow : Colors.white,
                                  size: 20, // 아이콘 크기 조절, 바깥 테두리보다 작게 설정
                                ),
                              ],
                            ),
                          ),
                          Text('1'),
                          Text('/'),
                          //Text('$questionList.length'),
                          //마지막 페이지에서 제출하기 버튼 뜨는 것도 생각해두기
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                question.question_type == 1
                    ? MultipleChoice(context, question)
                    : question.question_type == 2
                    ? ShortAnswer(context, question)
                    : OxQuiz(context, question),

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
