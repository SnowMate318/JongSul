import 'package:flutter/material.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/tools/color.dart';

Widget ShortAnswer(BuildContext context, Question question, TextEditingController shortAnswerController) {
  shortAnswerController = TextEditingController();
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
                  '${question.question_num}',
                ),
                Text(
                  '. ',
                ),
                Text(question.question_title),
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
            maxLength: 2,
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
          OutlinedButton(
            onPressed: () {},
            child: Text("다음문제로"),
          ),
        ],
      ),
      ]),
    ],
  );
}
