//문제 생성 완료 페이지
//완료 버튼 클릭시에 홈으로 이동함
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jongsul/screen/1_main_screen/home1_screen.dart';

class GenerateProblemCompleteScreen extends StatefulWidget {
  const GenerateProblemCompleteScreen({super.key});

  @override
  State<GenerateProblemCompleteScreen> createState() =>
      _GenerateProblemCompleteScreenState();
}

class _GenerateProblemCompleteScreenState
    extends State<GenerateProblemCompleteScreen> {
  TextEditingController multipleChoiceController = TextEditingController();
  TextEditingController shortAnswerController = TextEditingController();
  TextEditingController oxQuizController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문제 생성'),
        shape: Border(
          bottom: BorderSide(
            color: Color(0xFFD5C3B5),
            width: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 600,
              child: Center(
                child: Text(
                  '문제 생성이 완료되었습니다.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    //icon: Icon(Icons.download, size: 18),
                    child: Text(
                      "홈으로",
                      style: TextStyle(
                        color: Colors.white, // 폰트 색상
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home1Screen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF8B5000),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    //icon: Icon(Icons.download, size: 18),
                    child: Text(
                      "문제 풀기",
                      style: TextStyle(
                        color: Colors.white, // 폰트 색상
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => generate_\()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF8B5000),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,)
          ]),
        ),
      ),
    );
  }
}
