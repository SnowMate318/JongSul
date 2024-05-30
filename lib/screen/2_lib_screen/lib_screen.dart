import 'package:flutter/material.dart';
import 'package:jongsul/screen/2_lib_screen/lib_all_view.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/update_problem_short_answer_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("라이브러리"),
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
              Padding(
                padding: EdgeInsetsDirectional.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '스크랩한 문제들',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LibraryAllViewScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text("전체보기"),
                          Icon(Icons.chevron_right, size: 18),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.45,
                  reverse: false,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text("1. 과목",
                                        style: const TextStyle(fontSize: 20)),
                                    trailing: IconButton(
                                        onPressed: () => FlutterDialog(context),
                                        icon: Icon(Icons.more_vert)),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('문제 개수: 15'),
                                          Text('오답률: 0%'),
                                        ],
                                      ))
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16, 16),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: FilledButton.tonal(
                                    onPressed: () {},
                                    child: const Text("시작하기"),
                                  ),
                                ),
                              )
                            ]),
                      );
                      // return Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                      //     decoration: BoxDecoration(
                      //         color: Colors.amber
                      //     ),
                      // );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(
                color: Color(0xFFD5C3B5),
                height: 1,
              ),

              ///////////////////////////////////////////////
              Padding(
                padding: EdgeInsetsDirectional.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '스크랩한 문제들',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LibraryAllViewScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text("전체보기"),
                          Icon(Icons.chevron_right, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.45,
                  reverse: false,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
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

                                  child: Text("1. 과목",
                                      style: const TextStyle(fontSize: 20)),
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
                      );
                      // return Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                      //     decoration: BoxDecoration(
                      //         color: Colors.amber
                      //     ),
                      // );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(
                color: Color(0xFFD5C3B5),
                height: 1,
              ),
              ////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsetsDirectional.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '스크랩한 문제들',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("전체보기"),
                          Icon(Icons.chevron_right, size: 18),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.45,
                  reverse: true,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
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

                                  child: Text("1. 과목",
                                      style: const TextStyle(fontSize: 20)),
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
                      );
                      // return Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                      //     decoration: BoxDecoration(
                      //         color: Colors.amber
                      //     ),
                      // );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(
                color: Color(0xFFD5C3B5),
                height: 1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(0.5),
        ),
        distance: 70.0,
        //childrenOffset: const Offset(0, 0),

        children: [
          FloatingActionButton.small(
            child: const Icon(Icons.edit),
            onPressed: () {
              final state = _key.currentState;

              if (state != null) {
                state.toggle();
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenerateProblemScreen(),
                ),
              );
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.file_open),
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.photo_camera),
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
          ),
        ],
      ),
    );
  }
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
