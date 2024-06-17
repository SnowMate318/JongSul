import 'package:flutter/material.dart';
import 'package:jongsul/models/directory/directory_data.dart';
import 'package:jongsul/models/directory/mini_directory.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_complete_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_loading.dart';

class GenerateProblemUserChoiceScreen extends StatefulWidget {
  Library library;
  String title;
  String concept;

  GenerateProblemUserChoiceScreen(
      {required this.library,
      required this.title,
      required this.concept,
      super.key});

  @override
  State<GenerateProblemUserChoiceScreen> createState() =>
      _GenerateProblemUserChoiceScreenState();
}

class _GenerateProblemUserChoiceScreenState
    extends State<GenerateProblemUserChoiceScreen> {
  final TextEditingController _difficultyController = TextEditingController();
  final TextEditingController _multipleChoiceController =
      TextEditingController();
  final TextEditingController _shortAnswerController = TextEditingController();
  final TextEditingController _oxController = TextEditingController();

  int _totalQuestions = 0;

  void _updateTotalQuestions() {
    setState(() {
      int multipleChoice = int.tryParse(_multipleChoiceController.text) ?? 0;
      int shortAnswer = int.tryParse(_shortAnswerController.text) ?? 0;
      int oxQuiz = int.tryParse(_oxController.text) ?? 0;
      _totalQuestions = multipleChoice + shortAnswer + oxQuiz;
    });
  }

  @override
  void initState() {
    super.initState();
    _multipleChoiceController.addListener(_updateTotalQuestions);
    _shortAnswerController.addListener(_updateTotalQuestions);
    _oxController.addListener(_updateTotalQuestions);
  }

  @override
  void dispose() {
    _multipleChoiceController.dispose();
    _shortAnswerController.dispose();
    _oxController.dispose();
    super.dispose();
  }

  Future<void> _generateProblems() async {

    MiniDirectory miniDirectory = await addDirectory(
        widget.library.id,
        widget.title,
        widget.concept,
        7,
        int.parse(_multipleChoiceController.text),
        int.parse(_shortAnswerController.text),
        int.parse(_oxController.text));
    if(miniDirectory.id != 0){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GenerateProblemCompleteScreen(library: widget.library, miniDirectory: miniDirectory)),
    );
    } else {
      //Todo: 오류 처리(디렉토리 생성 못함)
      //Todo: 알림창(디렉토리를 생성하지 못했습니다 다시 시도 등)

    }
  }


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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //검색창

              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  widget.title,
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
                    // SizedBox(height: 20),
                    // Text(
                    //   '난이도(1~10)',
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 70,
                    //       height: 35,
                    //       child: TextFormField(
                    //         maxLength: 2,
                    //         controller: _difficultyController,
                    //         textAlignVertical: TextAlignVertical.top,
                    //         textAlign: TextAlign.center,
                    //         decoration: InputDecoration(
                    //           border: OutlineInputBorder(),
                    //           labelStyle: TextStyle(color: Color(0xFF8B5000)),
                    //           counterText: '', //글자수 제한 표시 없앰
                    //         ),
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return '생성 문제 난이도 입력해줘';
                    //           }
                    //           if (int.tryParse(value) == null) {
                    //             return '숫자로 입력해줘';
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ),
                    //     //Text('   ',style: TextStyle(fontSize: 20),),
                    //   ],
                    // ),
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
                          child: TextFormField(
                            maxLength: 2,
                            controller: _multipleChoiceController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: Color(0xFF8B5000)),
                              counterText: '', //글자수 제한 표시 없앰
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '생성 문제 난이도 입력해줘';
                              }
                              if (int.tryParse(value) == null) {
                                return '숫자로 입력해줘';
                              }
                              return null;
                            },
                          ),
                        ),
                        Text(
                          '   개',
                          style: TextStyle(fontSize: 20),
                        ),
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
                          child: TextFormField(
                            maxLength: 2,
                            controller: _shortAnswerController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: Color(0xFF8B5000)),
                              counterText: '', //글자수 제한 표시 없앰
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '생성 문제 난이도 입력해줘';
                              }
                              if (int.tryParse(value) == null) {
                                return '숫자로 입력해줘';
                              }
                              return null;
                            },
                          ),
                        ),
                        Text(
                          '   개',
                          style: TextStyle(fontSize: 20),
                        ),
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
                          child: TextFormField(
                            maxLength: 2,
                            controller: _oxController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: Color(0xFF8B5000)),
                              counterText: '', //글자수 제한 표시 없앰
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '생성 문제 난이도 입력해줘';
                              }
                              if (int.tryParse(value) == null) {
                                return '숫자로 입력해줘';
                              }
                              return null;
                            },
                          ),
                        ),
                        Text(
                          '   개',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '총 ${_totalQuestions}문제',
                          style: TextStyle(fontSize: 20),
                        ),
                        ElevatedButton(
                          //icon: Icon(Icons.download, size: 18),
                          child: Text("문제 생성하기",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          // onPressed: () async {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             GenerateProblemLoadingScreen()),
                          //   );
                          //   await addDirectory(
                          //       widget.library.id,
                          //       widget.title,
                          //       widget.concept,
                          //       int.parse(_difficultyController.text),
                          //       int.parse(_multipleChoiceController.text),
                          //       int.parse(_shortAnswerController.text),
                          //       int.parse(_oxController.text));
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             GenerateProblemCompleteScreen()),
                          //   );
                          // },
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GenerateProblemLoadingScreen()),
                            );
                            await _generateProblems();
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
      ),
    );
  }
}
