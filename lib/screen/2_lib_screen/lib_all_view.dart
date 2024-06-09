import 'package:flutter/material.dart';
import 'package:jongsul/models/directory/directory.dart';
import 'package:jongsul/models/directory/directory_data.dart';
import 'package:jongsul/models/directory_testview.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/question_testview.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/update_problem_short_answer_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LibraryAllViewScreen extends StatefulWidget {
  Library library;

  LibraryAllViewScreen({required this.library, super.key});

  @override
  State<LibraryAllViewScreen> createState() => _LibraryAllViewScreenState();
}

class _LibraryAllViewScreenState extends State<LibraryAllViewScreen> {
  final _key = GlobalKey<ExpandableFabState>();
  List<Directory> directoryList = [];

  @override
  void initState() {
    initDirectories();
    super.initState();
  }

  initDirectories() async {
    directoryList = await getDirectoryList(widget.library.id);
    setState(() {});
  }

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
        child: ListView.builder(
            itemCount: directoryList.length,
            itemBuilder: (context, index) {
              return _card(directoryList[index], index);
            }),
      ),
      floatingActionButton: IntrinsicWidth(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 40),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => GenerateProblemScreen(library: widget.library)),
              // );
            },
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 20),
                Text(
                  '폴더 추가',
                  style: TextStyle(
                    color: Colors.white, // 폰트 색상
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary, // 배경색상
              //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _card(Directory directory, int index) {
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

                      child: Text(directory.title,
                          style: const TextStyle(fontSize: 20)),
                    ),
                    IconButton(
                        onPressed: () {
                          FlutterDialog(context, index);
                        },
                        //onPressed: () =>
                        icon: Icon(Icons.more_vert)),
                  ]),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(directory.concept),

                    // Text('문제 개수: 15'),
                    // Text('오답률: 0%'),
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
                          onPressed: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => QuestionTestView(directory: directory)),
                            // );
                          },
                          child: const Text("문제풀기"),
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

  Widget _buildDirectoryList() {
    List<TextEditingController> _titleControllerList = [];
    List<TextEditingController> _conceptControllerList = [];
    for (int i = 0; i < directoryList.length; i++) {
      _titleControllerList.add(TextEditingController());
      _conceptControllerList.add(TextEditingController());
    }
    return Column(
      children: [
        Text('디렉토리 리스트'),
        SizedBox(
          height: 20,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: directoryList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text('디렉토리 아이디: ${directoryList[index].id}'),
                SizedBox(
                  height: 10,
                ),
                Text('디렉토리 이름: ${directoryList[index].title}'),
                Text('디렉토리 설명: ${directoryList[index].concept}'),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () async {
                      // Get.to(QuestionTestView(directory: directoryList[index]));
                    },
                    child: Text("문제 풀어보기")),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      // Get.to(ShareDirectotyView(
                      //     directory: directoryList[index],
                      //     library: widget.library));
                    },
                    child: Text('문제 공유하기')),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _titleControllerList[index],
                  decoration: InputDecoration(
                    labelText: '수정할 디렉토리 이름',
                  ),
                  validator: (value) {
                    //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                    if (value!.isEmpty) {
                      return '디렉토리 제목 입력해줘';
                    }
                    if (directoryList
                        .any((library) => library.title == value)) {
                      return '이미 존재하는 디렉토리';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _conceptControllerList[index],
                  decoration: InputDecoration(
                    labelText: '수정할 디렉토리 설명',
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      await patchDirectory(
                          directoryList[index].id,
                          _titleControllerList[index].text,
                          _conceptControllerList[index].text);
                      await initDirectories();
                    },
                    child: Text("디렉토리 수정")),
                TextButton(
                    onPressed: () async {
                      await deleteDirectory(directoryList[index].id);
                      await initDirectories();
                    },
                    child: Text("디렉토리 삭제")),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    // onPressed: () async {
                    //   Get.to(AddQuestionView(library: widget.library));
                    // },

                    onPressed: () {},
                    child: Text("문제 추가"))
              ],
            );
          },
        ),
      ],
    );
  }

  void FlutterDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,
        //barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    AditDialog(context, index);
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
                    DelteDialog(context, index);
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

  void DelteDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,
        //barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),

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
                  onPressed: () async {
                    await deleteDirectory(directoryList[index].id);
                    await initDirectories();
                    Navigator.of(context).pop();
                  },
                  child: Text('확인')),
            ],
          );
        });
  }

  void AditDialog(BuildContext context, int index) {
    List<TextEditingController> _titleControllerList = [];
    List<TextEditingController> _conceptControllerList = [];
    for (int i = 0; i < directoryList.length; i++) {
      _titleControllerList.add(TextEditingController());
      _conceptControllerList.add(TextEditingController());
    }
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,
        //barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text('문제폴더 이름 변경'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  maxLength: 20,
                  maxLines: 1,
                  controller: _titleControllerList[index],
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
                  validator: (value) {
                    //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                    if (value!.isEmpty) {
                      return '디렉토리 제목 입력해줘';
                    }
                    if (directoryList
                        .any((library) => library.title == value)) {
                      return '이미 존재하는 디렉토리';
                    }
                    return null;
                  },
                ),
              ],
            ),

            actions: [
              IntrinsicWidth(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateProblemShortAnswerScreen()),
                    );
                  },
                  child: Row(
                    children: [Text('문제수정'), Icon(Icons.chevron_right)],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await patchDirectory(
                        directoryList[index].id,
                        _titleControllerList[index].text,
                        _conceptControllerList[index].text);
                    await initDirectories();
                    Navigator.of(context).pop();
                  },
                  child: Text('이름변경')),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소')),
            ],
          );
        }

        );
  }
}
