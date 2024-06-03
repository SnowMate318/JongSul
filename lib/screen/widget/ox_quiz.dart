import 'package:flutter/material.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/tools/color.dart';

Widget OxQuiz(BuildContext context, Question question) {
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
                Text('다음 중 참, 거짓을 판별하시오.'),
              ],
            ),
            SizedBox(height: 50),
            Text(question.questionTitle),
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
    ],
  );
}
