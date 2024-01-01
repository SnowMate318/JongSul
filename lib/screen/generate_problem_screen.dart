import 'package:flutter/material.dart';

class GenerateProblemScreen extends StatelessWidget {
  const GenerateProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(  //메인 화면
        child: Text(
          "generateProblemScreen"
        ),
      )
    );
  }
}
