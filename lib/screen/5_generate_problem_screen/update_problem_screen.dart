import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/question/choice.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/models/question/question_data.dart';
import 'package:jongsul/screen/1_main_screen/home_screen.dart';
import 'package:jongsul/screen/2_lib_screen/lib_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/update_problem_oxquiz_screen.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';

import '../../models/question/question.dart';

enum Answer { one, two, three, fore }

enum Answer2 { O, X }

class UpdateProblemScreen extends StatefulWidget {
  Library library;
  int directoryId;
  String directoryTitle;
  String directoryConcept;


  UpdateProblemScreen(
      {required this.library,
      required this.directoryId,
      required this.directoryTitle,
        required this.directoryConcept,
      super.key});

  @override
  State<UpdateProblemScreen> createState() => _UpdateProblemScreenState();
}

class _UpdateProblemScreenState extends State<UpdateProblemScreen> {
  Answer? _answer;
  Answer2? _answer2;

  List<Question> questionList = [];
  int page = 0;
  late Question modifiedQuestion;
  List<TextEditingController> _choiceModifyController = [];
  late TextEditingController _titleModifyController;
  late TextEditingController _answerModifyController;
  late TextEditingController _explanationModifyController;

  PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: 퀘스쳔 리스트 받아오기
    initQuestions();
    super.initState();
  }

  initQuestions() async {
    questionList = await getQuestionList(widget.directoryId);
    changeQuestion(page);

    setState(() {});
  }

  changeQuestion(int n) {
    modifiedQuestion = questionList[n];
    for (int i = 0; i < modifiedQuestion.choices.length; i++) {
      _choiceModifyController.add(TextEditingController(
          text: modifiedQuestion.choices[i].choiceContent));
    }
    _titleModifyController =
        TextEditingController(text: modifiedQuestion.questionTitle);
    _answerModifyController =
        TextEditingController(text: modifiedQuestion.questionAnswer);
    _explanationModifyController =
        TextEditingController(text: modifiedQuestion.questionExplanation);
    if (questionList[n].questionAnswer == "O") {
      _answer2 = Answer2.O;
    } else if (questionList[n].questionAnswer == "X") {
      _answer2 = Answer2.X;
    } else if (questionList[n].questionAnswer == "1") {
      _answer = Answer.one;
    } else if (questionList[n].questionAnswer == "2") {
      _answer = Answer.two;
    } else if (questionList[n].questionAnswer == "3") {
      _answer = Answer.three;
    } else if (questionList[n].questionAnswer == "4") {
      _answer = Answer.fore;
    }
    debugPrint(questionList[n].questionAnswer);
    debugPrint(_answer2.toString());

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
        title: Text("문제 수정"),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),
      ),
      bottomNavigationBar: DownMenuBar(), // 앱바 사용
      body: SafeArea(
        child: PageView.builder(
            controller: _pageController,
            itemCount: questionList.length,
            itemBuilder: (context, index) {
              page = index;
              changeQuestion(page);

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '문제',
                            style: TextStyle(fontSize: 25),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _delteDialog(context, index);
                                  },
                                  icon: Icon(Icons.delete)),
                              Text('${index + 1}'),
                              const Text('/'),
                              Text('${questionList.length}'),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          child: TextField(
                            maxLength: 100,
                            controller: _titleModifyController,
                            decoration: InputDecoration(
                              hintText: '문제를 입력해 주세요.',
                              labelStyle: TextStyle(color: Color(0xFF8B5000)),
                              counterText: '',
                              //글자수 제한 표시 없앰

                              prefixIcon: Container(
                                width: 20,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 1}. ',
                                    style: TextStyle(
                                      color: Color(0xFF51453A),
                                    ),
                                  ),
                                ),
                              ),

                              //포커스 됐을 때
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF8B5000)),
                              ),

                              //포커스 되지 않았을 때
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF8B5000)),
                              ),

                              //포커스 되지 않았을 때 border여부
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              suffixIcon: IconButton(
                                //x버튼 클릭 시 작성한 내용을 초기화시킴
                                onPressed: () => setState(() {
                                  _titleModifyController.text = '';
                                }),
                                icon: const Icon(Icons.highlight_off),
                                color: Color(0xFF51453A),
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      questionList[index].questionType == 1
                          ? _buildMultipleChoice(questionList[index])
                          : SizedBox(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '정답',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      questionList[index].questionType == 1
                          ? Column(
                              children: <Widget>[
                                ListTile(
                                  title: const Text('1'),
                                  leading: Radio<Answer>(
                                    value: Answer.one,
                                    groupValue: _answer,
                                    onChanged: (Answer? value) {
                                      setState(() {
                                        _answer = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('2'),
                                  leading: Radio<Answer>(
                                    value: Answer.two,
                                    groupValue: _answer,
                                    onChanged: (Answer? value) {
                                      setState(() {
                                        _answer = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('3'),
                                  leading: Radio<Answer>(
                                    value: Answer.three,
                                    groupValue: _answer,
                                    onChanged: (Answer? value) {
                                      setState(() {
                                        _answer = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('4'),
                                  leading: Radio<Answer>(
                                    value: Answer.fore,
                                    groupValue: _answer,
                                    onChanged: (Answer? value) {
                                      setState(() {
                                        _answer = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : questionList[index].questionType == 3
                              ? Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('O'),
                                      leading: Radio<Answer2>(
                                        value: Answer2.O,
                                        groupValue: _answer2,
                                        onChanged: (Answer2? value) {
                                          setState(() {
                                            _answer2 = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('X'),
                                      leading: Radio<Answer2>(
                                        value: Answer2.X,
                                        groupValue: _answer2,
                                        onChanged: (Answer2? value) {
                                          setState(() {
                                            _answer2 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Padding(
                                    child: TextField(
                                      maxLength: 20,
                                      controller: _answerModifyController,
                                      decoration: InputDecoration(
                                        hintText: '정답을 입력해 주세요.',
                                        labelStyle:
                                            TextStyle(color: Color(0xFF8B5000)),
                                        counterText: '',
                                        //글자수 제한 표시 없앰

                                        //포커스 됐을 때
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFF8B5000)),
                                        ),

                                        //포커스 되지 않았을 때
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFF8B5000)),
                                        ),

                                        //포커스 되지 않았을 때 border여부
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        suffixIcon: IconButton(
                                          //x버튼 클릭 시 작성한 내용을 초기화시킴
                                          onPressed: () => setState(() {
                                            _answerModifyController.text = '';
                                          }),
                                          icon: const Icon(Icons.highlight_off),
                                          color: Color(0xFF51453A),
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                  ),
                                ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '해설',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Center(
                        child: Padding(
                          child: TextField(
                            maxLength: 500,
                            controller: _explanationModifyController,
                            decoration: InputDecoration(
                              hintText: '해설을 입력해 주세요.',
                              labelStyle: TextStyle(color: Color(0xFF8B5000)),
                              counterText: '',
                              //글자수 제한 표시 없앰

                              //포커스 됐을 때
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF8B5000)),
                              ),

                              //포커스 되지 않았을 때
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF8B5000)),
                              ),

                              //포커스 되지 않았을 때 border여부
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              suffixIcon: IconButton(
                                //x버튼 클릭 시 작성한 내용을 초기화시킴
                                onPressed: () => setState(() {
                                  _explanationModifyController.text = '';
                                }),
                                icon: const Icon(Icons.highlight_off),
                                color: Color(0xFF51453A),
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            ElevatedButton(
                              //icon: Icon(Icons.download, size: 18),
                              child: Text("수정",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                              onPressed: () async {
                                modifiedQuestion.questionTitle =
                                    _titleModifyController.text;
                                if (questionList[index].questionType == 1) {
                                  if (_answer.toString() == "Answer.one"){
                                    modifiedQuestion.questionAnswer ="1";
                                  }
                                  else if (_answer.toString() == "Answer.two"){
                                    modifiedQuestion.questionAnswer ="2";
                                  }
                                  else if (_answer.toString() == "Answer.three"){
                                    modifiedQuestion.questionAnswer ="3";
                                  }
                                  else if (_answer.toString() == "Answer.fore"){
                                    modifiedQuestion.questionAnswer ="4";
                                  }

                                } else if (questionList[index].questionType ==
                                    3) {
                                  if (_answer2.toString() == "Answer2.O"){
                                    modifiedQuestion.questionAnswer ="O";
                                  }
                                  if (_answer2.toString() == "Answer2.X"){
                                    modifiedQuestion.questionAnswer ="X";
                                  }
                                } else {
                                  modifiedQuestion.questionAnswer =
                                      _answerModifyController.text;
                                }
                                modifiedQuestion.questionExplanation =
                                    _explanationModifyController.text;
                                if (modifiedQuestion.questionType == 1) {
                                  for (int i = 0;
                                      i < modifiedQuestion.choices.length;
                                      i++) {
                                    modifiedQuestion.choices[i].choiceContent =
                                        _choiceModifyController[i].text;
                                  }
                                }
                                await patchQuestion(modifiedQuestion);
                                _aditCheck(context, index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF8B5000),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
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
                                  _finishDialog(context, index);
                                  // 모든 문제를 풀고 제출하는 로직을 여기에 작성
                                },
                                child: const Text('끝내기'),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildMultipleChoice(Question question) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '선택지',
            style: TextStyle(fontSize: 25),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: question.choices.length,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                child: TextField(
                  maxLength: 200,
                  controller: _choiceModifyController[index],
                  decoration: InputDecoration(
                    hintText: '선택지를 입력해 주세요.',
                    labelStyle: TextStyle(color: Color(0xFF8B5000)),
                    counterText: '',
                    //글자수 제한 표시 없앰

                    prefixIcon: Container(
                      width: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}. ',
                          style: TextStyle(
                            color: Color(0xFF51453A),
                          ),
                        ),
                      ),
                    ),

                    //포커스 됐을 때
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF8B5000)),
                    ),

                    //포커스 되지 않았을 때
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF8B5000)),
                    ),

                    //포커스 되지 않았을 때 border여부
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    suffixIcon: IconButton(
                      //x버튼 클릭 시 작성한 내용을 초기화시킴
                      onPressed: () => setState(() {
                        _choiceModifyController[index].text = '';
                      }),
                      icon: const Icon(Icons.highlight_off),
                      color: Color(0xFF51453A),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(top: 10),
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _delteDialog(BuildContext context, int index) {
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
                  "문제를 삭제할까요?",
                ),
              ],
            ),

            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소')),
              ElevatedButton(
                  onPressed: () async {
                    // 버튼이 눌렸을 때의 동작
                    await deleteQuestion(questionList[index].id);
                    initQuestions();
                    Navigator.of(context).pop();
                  },
                  child: Text('확인')),
            ],
          );
        });
  }

  void _aditCheck(BuildContext context, int index) {
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
                  "${index + 1}번 문제를 수정했습니다.",
                ),
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

  void _finishDialog(BuildContext context, int index) {
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
                  "문제 수정을 끝냈습니다",
                ),
              ],
            ),

            actions: [
              ElevatedButton(
                  onPressed: () async {
                    // 버튼이 눌렸을 때의 동작
                    await initQuestions();
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LibraryScreen()),
                    );
                  },
                  child: Text('홈으로')),
              ElevatedButton(
                  onPressed: () async {
                    await initQuestions();
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SolveProblemScreen(
                              library: widget.library,
                              directoryId: widget.directoryId,
                              directoryTitle: widget.directoryTitle, directoryConcept: widget.directoryConcept,)),
                    );
                  },
                  child: Text('문제풀기')),
            ],
          );
        });
  }
}
