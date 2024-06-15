import 'package:flutter/material.dart';
import 'package:jongsul/models/question/choice.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:jongsul/tools/color.dart';

Widget MultipleChoice(BuildContext context, Question question) {
  List<Choice> choiceList = question.choices;

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
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: question.questionContent.length, //API에서 받아오는 개수로 바꿔주 기
          itemBuilder: (BuildContext context, int index) {
            return Column(
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
                  child: Row(
                    children: [
            Text(
            "${choiceList[index].choiceNum.toString()}. ${choiceList[index]
                .choiceContent}"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
