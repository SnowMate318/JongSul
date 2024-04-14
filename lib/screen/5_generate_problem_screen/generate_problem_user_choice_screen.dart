import 'package:flutter/material.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_complete_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_loading.dart';

class GenerateProblemUserChoiceScreen extends StatefulWidget {
  const GenerateProblemUserChoiceScreen({super.key});

  @override
  State<GenerateProblemUserChoiceScreen> createState() =>
      _GenerateProblemUserChoiceScreenState();
}

class _GenerateProblemUserChoiceScreenState
    extends State<GenerateProblemUserChoiceScreen> {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //검색창

            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '제목',
                style: TextStyle(fontSize: 20),
              ),
              // textInputAction: TextInputAction.search,
            ),

            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '문제 생성 갯수',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '문제 생성 또는 추가 생성 시 출제되는 문제의 갯수를 설정할 수 있습니다.',
                    style: TextStyle(
                      color: Color(0xFF9D9D9D),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '객관식',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 35,
                        child: TextField(
                          maxLength: 2,
                          controller: multipleChoiceController,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Color(0xFF8B5000)),
                            counterText: '', //글자수 제한 표시 없앰
                          ),
                        ),
                      ),
                      Text('   개',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '주관식',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 70,
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
                      Text('   개',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'OX퀴즈',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 35,
                        child: TextField(
                          maxLength: 2,
                          controller: oxQuizController,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Color(0xFF8B5000)),
                            counterText: '', //글자수 제한 표시 없앰
                          ),
                        ),
                      ),
                      Text('   개',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '총 11문제',
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                        //icon: Icon(Icons.download, size: 18),
                        child: Text("문제 생성하기",style: TextStyle(
                            color: Colors.white,
                            fontSize: 14, fontWeight: FontWeight.normal)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GenerateProblemLoadingScreen()),
                          );

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF8B5000),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
