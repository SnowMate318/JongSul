import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(  //메인 화면
        body: SafeArea(
          child: Text(
              "lib_screen"
          ),
        )
    );
  }
}
