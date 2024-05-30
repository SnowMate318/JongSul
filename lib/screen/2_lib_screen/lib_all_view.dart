import 'package:flutter/material.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/update_problem_short_answer_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LibraryAllViewScreen extends StatefulWidget {
  const LibraryAllViewScreen({super.key});

  @override
  State<LibraryAllViewScreen> createState() => _LibraryAllViewScreenState();
}

class _LibraryAllViewScreenState extends State<LibraryAllViewScreen> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("컴퓨터 네트워크"),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),
      ),
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _card(),
              _card(),
              _card(),
              _card(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _card() {
  return Row(
    children: [
      Expanded(
        child: Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width:
                    // MediaQuery
                    //     .of(context)
                    //     .size
                    //     .width,
                    //width: 30,
                    padding: const EdgeInsets.all(12),

                    child: Text("1. 과목", style: const TextStyle(fontSize: 20)),
                  ),
                  IconButton(
                      onPressed: () {},
                      //onPressed: () => FlutterDialog(context),    ///여기를 수정!!!!!!
                      icon: Icon(Icons.more_vert)),
                ]),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('문제 개수: 15'),
                  Text('오답률: 0%'),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // TextButton(
                      //   onPressed: () {},
                      //   child: const Text("Details"),
                      // ),
                      FilledButton.tonal(
                        onPressed: () {},
                        child: const Text("시작하기"),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
      Expanded(
        child: Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width:
                    // MediaQuery
                    //     .of(context)
                    //     .size
                    //     .width,
                    //width: 30,
                    padding: const EdgeInsets.all(12),

                    child: Text("1. 과목", style: const TextStyle(fontSize: 20)),
                  ),
                  Icon(Icons.more_vert),
                ]),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('문제 개수: 15'),
                  Text('오답률: 0%'),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // TextButton(
                      //   onPressed: () {},
                      //   child: const Text("Details"),
                      // ),
                      FilledButton.tonal(
                        onPressed: () {},
                        child: const Text("시작하기"),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    ],
  );
}

void FlutterDialog(BuildContext context) {
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: true,
      //barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AditDialog(context);
                },
                child: Text("수정하기"),
              ),
              Divider(
                color: Color(0xFFD5C3B5),
                height: 1,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("공유하기"),
              ),
              Divider(
                color: Color(0xFFD5C3B5),
                height: 1,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  DelteDialog(context);
                },
                child: Text("삭제하기"),
              ),
            ],
          ),
          //
          // content: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Text(
          //       "Dialog Content",
          //     ),
          //   ],
          // ),
          // onPressed: () {
          //   Navigator.of(context).pop();
          // },
        );
      });
}

void DelteDialog(BuildContext context) {
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: true,
      //barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "문제 폴더를 삭제할까요?",
              ),
            ],
          ),

          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('취소')),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('확인')),
          ],
        );
      });
}

void AditDialog(BuildContext context) {
  TextEditingController description = TextEditingController();
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: true,
      //barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('문제폴더 이름 변경'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                maxLength: 20,
                maxLines: 1,
                controller: description,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Color(0xFF8B5000)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8B5000)),
                  ),
                  counterText: '', //글자수 제한 표시 없앰
                ),
              ),
            ],
          ),

          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProblemShortAnswerScreen()),
                  );
                },
                child: Text('문제수정')),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('확인')),
          ],
        );
      });
}
