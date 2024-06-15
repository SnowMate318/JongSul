import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_final_screen.dart';

class SolveProblemScreen extends StatefulWidget {
  int directoryId;
  String directoryTitle;
  String directoryConcept;
  Library library;

  SolveProblemScreen({required this.library, required this.directoryId,
  required this.directoryTitle, required this.directoryConcept,super.key});

  @override
  State<SolveProblemScreen> createState() => _SolveProblemScreenState();
}

class _SolveProblemScreenState extends State<SolveProblemScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.library.title),
        shape: Border(
          bottom: BorderSide(
            color: Color(0xFFD5C3B5),
            width: 1,
          ),
        ),
      ),
      body: SafeArea(
        //메인 화면
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //검색창
              Center(
                child: Padding(
          padding: EdgeInsets.all(20),
                  child: Text(
                    widget.directoryTitle,
                    style: TextStyle(color: Color(0xFF8B5000)),
                    ),

                  ),

                ),
              Divider(
                color: Color(0xFFD5C3B5),
                height: 1,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                       widget.directoryConcept,
                        style: TextStyle(color: Color(0xFF8B5000)),
                        ),
                    //textInputAction: TextInputAction.search,
                  ),
                ),

              // FlatButton(
              //   onPressed: () {
              //     // 여기에 게시글을 서버에 전송하는 로직을 추가할 수 있습니다.
              //     String postContent = subjectController.text;
              //   },
              //   color: Colors.blue,
              //   textColor: Colors.white,
              //   child: Text('Post'),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Column(
                      children: [],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0), // 원하는 여유 공간 추가
        child: ElevatedButton(
          //icon: Icon(Icons.download, size: 18),
          child: Text("문제 풀어보기"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SolveProblemFinalScreen(library: widget.library, directoryId: widget.directoryId, directoryTitle: widget.directoryTitle)),
            );
          },
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0XFF8B5000),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
