import 'package:flutter/material.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/tools/color.dart';

Widget ShortAnswer(BuildContext context, Question question,
    ) {
  //TextEditingController shortAnswerController를 매개변수로 넣어야 하려나?
  TextEditingController shortAnswerController = TextEditingController();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${question.questionNum}',
                ),
                Text(
                  '. ',
                ),
                Text(question.questionTitle),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
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
            onPressed: () {
              // 버튼이 눌렸을 때의 동작
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 모서리 둥글기
              ),
              fixedSize: Size(120, 50), // 정사각형 크기
            ),
            child: Text(
              '제출하기',
              //style: TextStyle(fontSize: 45),
            ),
          ),
        ],
      ),
    ],
  );
}
