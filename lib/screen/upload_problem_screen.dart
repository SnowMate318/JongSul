import 'package:flutter/material.dart';

class UploadProblemScreen extends StatelessWidget {
  const UploadProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("문제 공유")), // 앱바 사용
        body: SafeArea(
          child: Text( //메인 화면
              "uploadProblemScreen"
          ),
        )
    );
  }
}
