import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/question/choice.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/models/question/question_data.dart';
import 'package:jongsul/screen/1_main_screen/home_screen.dart';
import 'package:jongsul/screen/2_lib_screen/lib_screen.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';

class SolveProblemFinalScreen extends StatefulWidget {
  final int directoryId;
  final String directoryTitle;
  final Library library;

  SolveProblemFinalScreen(
      {required this.library,
      required this.directoryId,
      required this.directoryTitle,
      super.key});

  @override
  _SolveProblemFinalScreenState createState() =>
      _SolveProblemFinalScreenState();
}

class _SolveProblemFinalScreenState extends State<SolveProblemFinalScreen> {
  List<Question> questionList = [];
  PageController _pageController = PageController();
  int count = 0;

  @override
  void initState() {
    super.initState();
    initQuestions();
  }

  initQuestions() async {
    questionList = await getQuestionList(widget.directoryId);
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.library.title),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),
      ),
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child:
        // questionList.isEmpty
        //     ? Center(
        //         child: Text('오류'),
        //       )
        //     :
        PageView.builder(
                controller: _pageController,
                itemCount: questionList.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.directoryTitle,
                                style: const TextStyle(fontSize: 25),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await patchQuestionScrap(
                                          questionList[index].id,
                                          !questionList[index].isScrapped,
                                          widget.directoryTitle);
                                      initQuestions();
                                    },
                                    icon: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: questionList[index].isScrapped
                                              ? Colors.yellow
                                              : Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text('${index + 1}'),
                                  const Text('/'),
                                  Text('${questionList.length}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          '${questionList[index].questionNum.toString()}. ${questionList[index].questionTitle}',
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 300,
                          child: _buildQuestionWidget(
                            questionList[index],
                            context,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (index == 0)
                              SizedBox(
                                width: 10,
                              ),
                            if (index > 0)
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            if (index < questionList.length - 1)
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            if (index == questionList.length - 1)
                              ElevatedButton(
                                onPressed: () {
                                  _submmitDialog(context);
                                  // 모든 문제를 풀고 제출하는 로직을 여기에 작성
                                },
                                child: const Text('끝내기'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),);
                },
              ),
      ),
    );
  }

  Widget _buildQuestionWidget(Question question, BuildContext context) {
    switch (question.questionType) {
      case 1:
        return _buildMultipleChoice(context, question);
      case 2:
        return _buildShortAnswer(context, question);
      default:
        return _buildOXQuiz(context, question);
    }
  }

  Widget _buildMultipleChoice(BuildContext context, Question question) {
    List<Choice> choiceList = question.choices;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: choiceList.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () async {
            // 버튼이 눌렸을 때의 동작
            bool solve = choiceList[index].choiceNum.toString() ==
                question.questionAnswer;
            await patchQuestionSubmit(question.id, solve);
            initQuestions();

            if (question.questionAnswer == (index+1).toString()) {
              debugPrint('정답입니다.');
              count++;
              debugPrint('$count');
              _answerDialog(context, question, true);
            } else {
              debugPrint('틀렸습니다.');
              _answerDialog(context, question, false);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // 모서리 둥글기
            ),
            fixedSize: Size(360, 70), // 정사각형 크기
          ),
          child: Text(
              "${choiceList[index].choiceNum.toString()}. ${choiceList[index].choiceContent}"),
        );
      },
    );
  }

  Widget _buildShortAnswer(BuildContext context, Question question) {
    TextEditingController shortAnswerController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '정답:',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 200,
            height: 35,
            child: TextField(
              maxLength: 20,
              controller: shortAnswerController,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color(0xFF8B5000)),
                counterText: '', //글자수 제한 표시 없앰
              ),
            ),
          ),
        ]),
        SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // 버튼이 눌렸을 때의 동작
                bool solve =
                    shortAnswerController.text == question.questionAnswer;
                await patchQuestionSubmit(question.id,
                    shortAnswerController.text == question.questionAnswer);
                initQuestions();
                if (shortAnswerController.text == question.questionAnswer) {
                  debugPrint('정답입니다.');
                  count++;
                  debugPrint('$count');
                  _answerDialog(context, question, true);
                } else {
                  debugPrint('틀렸습니다.');
                  _answerDialog(context, question, false);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 모서리 둥글기
                ),
                fixedSize: Size(120, 50), // 정사각형 크기
              ),
              child: Text(
                '제출하기',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOXQuiz(BuildContext context, Question question) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () async {
          // 버튼이 눌렸을 때의 동작
          bool solve = question.questionAnswer == 'O'; // O일 때 true, X일 때 false
          await patchQuestionSubmit(question.id, solve);
          initQuestions();
          if (question.questionAnswer == 'O') {
            debugPrint('정답입니다.');
            count++;
            debugPrint('$count');
            _answerDialog(context, question, true);
          } else {
            debugPrint('틀렸습니다.');
            debugPrint('${question.questionAnswer}');
            _answerDialog(context, question, false);
          }
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
        onPressed: () async {
          // 버튼이 눌렸을 때의 동작
          bool solve = question.questionAnswer == 'X';
          await patchQuestionSubmit(question.id, solve);
          initQuestions();
          if (question.questionAnswer == 'X') {
            debugPrint('정답입니다.');
            count++;
            debugPrint('$count');
            _answerDialog(context, question, true);
          } else {
            debugPrint('틀렸습니다.');
            _answerDialog(context, question, false);
          }
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
    ]);
  }

  void _submmitDialog(BuildContext context) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,
        //barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "문제를 제출할까요?",
                ),
              ],
            ),

            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LibraryScreen()),
                    );
                  },
                  child: Text('확인')),
            ],
          );
        });
  }

  void _answerDialog(BuildContext context, Question question, bool answer) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,
        //barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                answer
                    ? Text(
                        "정답입니다!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      )
                    : Text(
                        "틀렸습니다!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                question.lastSolved
                    ? Text(
                        "이전에 맞춘 문제입니다",
                        style: TextStyle(
                          //fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : Text(
                        "이전에 틀린 문제입니다",
                        style: TextStyle(
                          //fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                SizedBox(height: 20),

                Text(
                  '문제',
                  style: TextStyle(
                    //fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('${question.questionTitle}'),

                SizedBox(height: 20),
                Text(
                  '문제 정답',
                  style: TextStyle(
                    //fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${question.questionAnswer}',
                  style: TextStyle(
                    //fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                //Text('질문 내용: ${question.questionContent}'),
                Text(
                  '해설',
                  style: TextStyle(
                    //fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('${question.questionExplanation}'),
              ],
            ),

            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('확인')),
            ],
          );
        });
  }
}
