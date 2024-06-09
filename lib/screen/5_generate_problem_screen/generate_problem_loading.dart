import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_complete_screen.dart';
import 'package:jongsul/tools/color.dart';

class GenerateProblemLoadingScreen extends StatefulWidget {
  const GenerateProblemLoadingScreen({super.key});

  @override
  State<GenerateProblemLoadingScreen> createState() =>
      _GenerateProblemLoadingScreenState();
}

class _GenerateProblemLoadingScreenState
    extends State<GenerateProblemLoadingScreen> {
  @override
  // void initState() {
  //   Timer(Duration(milliseconds: 3000), () {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => GenerateProblemCompleteScreen()),
  //     );
  //   });
  // }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [
        SizedBox(height: 300,),
        Center(
          //로딩바 구현 부분
          child: Column(children: [
            SpinKitRing(
              // FadingCube 모양 사용
              color: primary, // 색상 설정
              size: 30.0, // 크기 설정
              //duration: Duration(seconds: 2), //속도 설정
            ),
            SizedBox(height: 10,),
            Text('문제를 생성중입니다...')
          ]),
        ),
      ]),
    );
  }
}
