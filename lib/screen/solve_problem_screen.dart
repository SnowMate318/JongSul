import 'package:flutter/material.dart';

class SolveProblemScreen extends StatelessWidget {
  const SolveProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("문제 생성")), // 앱바 사용
        body: SafeArea(
          child: Text( //메인 화면
              "solveProblemScreen"
          ),
        )
    );
  }
}
