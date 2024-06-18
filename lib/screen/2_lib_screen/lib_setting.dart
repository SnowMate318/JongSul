import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/library/library_data.dart';
import 'package:jongsul/screen/2_lib_screen/lib_all_view.dart';
import 'package:jongsul/tools/color.dart';

class LibrarySettingScreen extends StatefulWidget {
  const LibrarySettingScreen({
    super.key});

  @override
  State<LibrarySettingScreen> createState() => _LibrarySettingScreenState();
}

class _LibrarySettingScreenState extends State<LibrarySettingScreen> {
  List<Library> libraryList = [];
  Library currentLibrary = Library.init();

  @override
  void initState() {
    // TODO: implement initState
    initLibraryList();
    super.initState();
  }

  initLibraryList() async {
    libraryList = await getLibraryList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라이브러리"),
        shape: Border(
          bottom: BorderSide(
            color: Color(0xFFD5C3B5),
            width: 1,
          ),
        ),

      ),
      body: SafeArea(
        //메인 화면
        child: Column(
                          children: [

                             _buildLibraryList(libraryList),
                            SizedBox(
                              height: 10,
                            ),
                          ],


        ),

        //
        // SingleChildScrollView(
        //   // child: ConstrainedBox(
        //   //   constraints:
        //   //       BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        //   //   child: IntrinsicHeight(
        //       child: Column(
        //         children: [
        //
        //            _buildLibraryList(libraryList),
        //
        //           SizedBox(
        //             height: 10,
        //           ),
        //         ],
        //   //     ),
        //   //   ),
        //    ),
        // ),
      ),
      floatingActionButton: IntrinsicWidth(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 40),
          child: ElevatedButton(
            onPressed: () {
              AddDialog(context);
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

  List<TextEditingController> _titleControllerList = [];

  Widget _buildLibraryList(List<Library> libraryList) {
    for (int i = 0; i < libraryList.length; i++) {
      _titleControllerList.add(TextEditingController());
    }
    return Expanded(child: ListView.builder(
      itemCount: libraryList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.folder),
                      Text('  '),
                      Text(libraryList[index].title),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          DeleteDialog(context, index);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.white, size: 15),
                            Text(
                              '삭제',
                              style: TextStyle(
                                color: Colors.white, // 폰트 색상
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary, // 배경색상
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AditDialog(context, index);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.white, size: 15),
                            Text(
                              '이름 변경',
                              style: TextStyle(
                                color: Colors.white, // 폰트 색상
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary, // 배경색상
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: outlineVariant,
              height: 1,
            ),
          ],
        );
      },
    ),);
  }

  void DeleteDialog(BuildContext context, int index) {
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('취소')),
              ElevatedButton(
                  onPressed: () async {
                    //라이브러리 삭제
                    await deleteLibrary(libraryList[index].id);
                    await initLibraryList();
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('확인')),
            ],
          );
        });
  }

  void AditDialog(BuildContext context, int index) {
    TextEditingController description = TextEditingController();
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
                      return '타이틀 입력해줘';
                    }
                    if (libraryList.any((library) => library.title == value)) {
                      return '이미 존재하는 타이틀';
                    }
                    return null;
                  },
                ),
              ],
            ),

            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => UpdateProblemShortAnswerScreen()),
                    // );
                  },
                  child: Text('취소')),
              ElevatedButton(
                  onPressed: () async {
                    //라이브러리 수정하기
                    await patchLibrary(libraryList[index].id,
                        _titleControllerList[index].text);
                    await initLibraryList();
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('확인')),
            ],
          );
        });
  }

  void AddDialog(BuildContext context) {
    final TextEditingController _addTitleController = TextEditingController();
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
            title: Text('라이브러리 추가'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  maxLength: 20,
                  maxLines: 1,
                  controller: _addTitleController,
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
                      return '타이틀 입력해줘';
                    }
                    if (libraryList.any((library) => library.title == value)) {
                      return '이미 존재하는 타이틀';
                    }
                    return null;
                  },
                ),
              ],
            ),

            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => UpdateProblemShortAnswerScreen()),
                    // );
                  },
                  child: Text('취소')),
              ElevatedButton(
                  onPressed: () async {
                    await addLibrary(_addTitleController.text);
                    await initLibraryList();
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('추가')),
            ],
          );
        });
  }
}
