import 'package:flutter/material.dart';
import 'package:jongsul/models/question/choice.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/models/question/question_data.dart';
import 'package:get/get.dart';
class QuestionTestView extends StatefulWidget {
  int directoryId;
  String directoryTitle;

  QuestionTestView({
        required this.directoryId,
        required this.directoryTitle,
        super.key
      });

  @override
  State<QuestionTestView> createState() => _QuestionTestViewState();
}

class _QuestionTestViewState extends State<QuestionTestView> {
  List<Question> questionList = [];

  @override
  void initState() {
    // TODO: implement initState
    initQuestions();
    super.initState();
  }

  initQuestions() async {
    questionList = await getQuestionList(widget.directoryId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('디렉토리 이름: ${widget.directoryTitle}'),
                SizedBox(height: 20),
                Text('디렉토리 아이디: ${widget.directoryId}'),
                SizedBox(height: 20),
                _buildQuestionList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: questionList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text('질문 제목: ${questionList[index].questionTitle}'),
            Text('질문 내용: ${questionList[index].questionContent}'),
            Text('지난번 풀이: ${questionList[index].lastSolved}'),
            Text('스크랩: ${questionList[index].isScrapped}'),
            Text('문제 정답: ${questionList[index].questionAnswer}'),
            Text('질문 설명: ${questionList[index].questionExplanation}'),

            questionList[index].questionType == 1
                ? _buildMultipleChoice(context, questionList[index])
                : questionList[index].questionType == 2
                    ? _buildShortAnswer(context, questionList[index])
                    : _buildOXQuiz(context, questionList[index]),
            SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                // 버튼이 눌렸을 때의 동작
                await patchQuestionScrap(questionList[index].id, !questionList[index].isScrapped, widget.directoryTitle);
                initQuestions();
              },
              child: Text('스크랩: ${questionList[index].isScrapped}'),
            ),
            TextButton(
              onPressed: () async {
                // 버튼이 눌렸을 때의 동작
                await initQuestions();
              },
              child: Text('새로고침'),
            ),
            TextButton(
              onPressed: () {
                // 버튼이 눌렸을 때의 동작
                Get.to(QuestionModifyView(question: questionList[index]));
              },
              child: Text('문제 수정'),
            ),
            TextButton(
              onPressed: () async{
                // 버튼이 눌렸을 때의 동작
                await deleteQuestion(questionList[index].id);
                initQuestions();
              },
              child: Text('문제 삭제'),
            ),
          ],
        );
      },
    );
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
            bool solve = choiceList[index].choiceNum.toString() == question.questionAnswer;
            await patchQuestionSubmit(question.id, solve);
            initQuestions();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // 모서리 둥글기
            ),
            fixedSize: Size(360, 70), // 정사각형 크기
          ),
          child: Text(
              "${choiceList[index].choiceNum.toString()}. ${choiceList[index]
                  .choiceContent}"
          ),
        );
      },
    );
  }
  Widget _buildShortAnswer(BuildContext context, Question question) {
    TextEditingController shortAnswerController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
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
                bool solve = shortAnswerController.text == question.questionAnswer;
                await patchQuestionSubmit(question.id, shortAnswerController.text == question.questionAnswer);
                initQuestions();
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
}

class QuestionModifyView extends StatefulWidget {
  Question question;
  QuestionModifyView({
    required this.question,
    super.key
  });

  @override
  State<QuestionModifyView> createState() => _QuestionModifyViewState();
}

class _QuestionModifyViewState extends State<QuestionModifyView> {
  late Question modifiedQuestion;
  List<TextEditingController> _choiceModifyController = [];
  late TextEditingController _titleModifyController;
  late TextEditingController _answerModifyController;
  late TextEditingController _explanationModifyController;
  @override
  void initState() {
    // TODO: implement initState
    modifiedQuestion = widget.question;
    for(int i=0; i<modifiedQuestion.choices.length; i++){
      _choiceModifyController.add(TextEditingController(text:modifiedQuestion.choices[i].choiceContent));
    }
    _titleModifyController = TextEditingController(text:widget.question.questionTitle);
    _answerModifyController = TextEditingController(text:widget.question.questionAnswer);
    _explanationModifyController = TextEditingController(text:widget.question.questionExplanation);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('문제 제목 수정'),
                Container(
                  width: 200,
                  height: 35,
                  child: TextField(
                    maxLength: 20,
                    controller: _titleModifyController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Color(0xFF8B5000)),
                      counterText: '', //글자수 제한 표시 없앰
                    ),
                  ),
                ),
                SizedBox(height: 20),
                widget.question.questionType==1 ? _buildMultipleChoice(widget.question) : SizedBox(),
                SizedBox(height: 20),
                Text('문제 정답 수정'),
                Container(
                  width: 200,
                  height: 35,
                  child: TextField(
                    maxLength: 20,
                    controller: _answerModifyController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Color(0xFF8B5000)),
                      counterText: '', //글자수 제한 표시 없앰
                    ),
                  ),
                ),
                Text('문제 설명 수정'),
                Container(
                  width: 200,
                  height: 35,
                  child: TextField(
                    maxLength: 20,
                    controller: _explanationModifyController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Color(0xFF8B5000)),
                      counterText: '', //글자수 제한 표시 없앰
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () async {
                    modifiedQuestion.questionTitle =
                        _titleModifyController.text;
                    modifiedQuestion.questionAnswer =
                        _answerModifyController.text;
                    modifiedQuestion.questionExplanation =
                        _explanationModifyController.text;
                    if (modifiedQuestion.questionType == 1) {
                      for (int i = 0; i <
                          modifiedQuestion.choices.length; i++) {
                        modifiedQuestion.choices[i].choiceContent =
                            _choiceModifyController[i].text;
                      }
                    }
                    await patchQuestion(modifiedQuestion);
                    Get.back();
                  },
                  child: Text('수정 완료')
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildMultipleChoice(Question question){

    return Column(
      children: [
        Text('선택지 수정'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.question.choices.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text('선택지 ${widget.question.choices[index].choiceNum}'),
                Container(
                  width: 200,
                  height: 35,
                  child: TextField(
                    maxLength: 20,
                    controller: _choiceModifyController[index],
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Color(0xFF8B5000)),
                      counterText: '', //글자수 제한 표시 없앰
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
