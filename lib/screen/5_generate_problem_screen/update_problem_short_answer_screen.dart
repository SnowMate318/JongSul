import 'package:flutter/material.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';

class UpdateProblemShortAnswerScreen extends StatefulWidget {
  const UpdateProblemShortAnswerScreen({super.key});

  @override
  State<UpdateProblemShortAnswerScreen> createState() => _UpdateProblemShortAnswerScreenState();
}

class _UpdateProblemShortAnswerScreenState extends State<UpdateProblemShortAnswerScreen> {
  TextEditingController inputController = TextEditingController();

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
        child: SingleChildScrollView(
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
                        Icon(Icons.delete),
                        Text('1'),
                        Text('/'),
                        Text('15'),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    child: TextField(
                      maxLength: 30,
                      controller: inputController,
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
                              '1.',
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
                            inputController.text = '';
                          }),
                          icon: const Icon(Icons.highlight_off),
                          color: Color(0xFF51453A),
                        ),
                      ),
                      textInputAction: TextInputAction.search,
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
                    '정답',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Center(
                  child: Padding(
                    child: TextField(
                      maxLength: 30,
                      controller: inputController,
                      decoration: InputDecoration(
                        hintText: '문제 내용을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        counterText: '',
                        //글자수 제한 표시 없앰

                        // prefixIcon:Container(
                        //   width: 20,
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       'A.',
                        //       style: TextStyle(
                        //         color: Color(0xFF51453A),
                        //       ),
                        //     ),
                        //   ),
                        // ),

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
                            inputController.text = '';
                          }),
                          icon: const Icon(Icons.highlight_off),
                          color: Color(0xFF51453A),
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                    ),
                    padding: EdgeInsets.only(top: 10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    //icon: Icon(Icons.download, size: 18),
                    child: Text("수정 완료", style: TextStyle(
                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal)),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => GenerateProblemLoadingScreen()),
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
          ),
        ),
      ),
    );
  }
}
