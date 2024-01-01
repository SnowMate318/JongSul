import 'package:flutter/material.dart';

class UpdateProblemScreen extends StatelessWidget {
  const UpdateProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("문제 수정")), // 앱바 사용
        body: SafeArea(
          child: Text( //메인 화면
             "updateProblemScreen"
          ),
        )
    );
  }
}
