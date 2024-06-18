import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jongsul/models/directory/directory.dart';
import 'package:jongsul/models/directory/directory_data.dart';
import 'package:jongsul/models/directory/mini_directory.dart';
import 'package:jongsul/models/directory_testview.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/library/library_data.dart';
import 'package:jongsul/screen/2_lib_screen/lib_all_view.dart';
import 'package:jongsul/screen/2_lib_screen/lib_setting.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/update_problem_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/update_problem_short_answer_screen.dart';
import 'package:jongsul/screen/6_upload_ploblem_screen/upload_problem_screen.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _key = GlobalKey<ExpandableFabState>();
  List<Library> libraryList = [];
  List<Directory> directoryList = [];
  PlatformFile? _pickedFile;

  //Library currentLibrary = Library.init();

  @override
  void initState() {
    // TODO: implement initState
    // initDirectories();
    initLibraryList();
    super.initState();
  }

  initLibraryList() async {
    libraryList = await getLibraryList();
    setState(() {});
  }

  // initDirectories() async {
  //   directoryList = await getDirectoryList(widget.library.id);
  //   setState(() {});
  // }
  Future<void> _onRefresh() {
  initLibraryList();
  return Future<void>.value();
  }
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
        actions: [
          TextButton(
            child: Text('상세보기'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LibrarySettingScreen(),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: libraryList.isEmpty
              ? Center(
            child: IntrinsicWidth(
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
                        '라이브러리 추가',
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
          )
              : ListView.builder(
              itemCount: libraryList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            libraryList[index].title,
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LibraryAllViewScreen(
                                            library: libraryList[index])),
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
                    libraryList[index].miniDirectories.isEmpty
                        ? Center(
                      child: IntrinsicWidth(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 40),
                          child: ElevatedButton(
                            onPressed: () {
                              _problemDialog(
                                  context, libraryList[index]);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add,
                                    color: Colors.white, size: 20),
                                Text(
                                  '문제 생성',
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
                    )
                        : CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.45,
                        reverse: false,
                      ),
                      items: List.generate(
                          libraryList[index].miniDirectories.length,
                              (i) {
                            final miniDirectory =
                            libraryList[index].miniDirectories[i];
                            return Builder(
                              builder: (BuildContext context) {
                                return Card(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: Text(miniDirectory.title,
                                                style: const TextStyle(
                                                    fontSize: 20)),
                                            trailing: IconButton(
                                              onPressed: () {
                                                FlutterDialog(
                                                    context,
                                                    index,
                                                    miniDirectory,
                                                    i);
                                              },
                                              icon: Icon(Icons.more_vert,
                                                  size: 18),
                                            ),
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
                                                // Text(miniDirectory.concept),
                                                // Text('문제 개수: 15'),
                                                // Text('오답률: 0%'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 16, 16),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: FilledButton.tonal(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SolveProblemScreen(
                                                        library:
                                                        libraryList[index],
                                                        directoryId:
                                                        miniDirectory.id,
                                                        directoryTitle:
                                                        miniDirectory.title,
                                                        directoryConcept:
                                                        miniDirectory
                                                            .concept,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: const Text("문제풀기"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
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
                );
              }),
        ),
        ),
      floatingActionButton: libraryList.isEmpty
          ? null
          : IntrinsicWidth(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 80),
                child: ElevatedButton(
                  onPressed: () {
                    AddDialog(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 20),
                      Text(
                        '라이브러리 추가',
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // IntrinsicWidth(
      //   child: Padding(
      //     padding: EdgeInsets.fromLTRB(10, 10, 0, 40),
      //     child: ElevatedButton(
      //       onPressed: () {
      //         AddDialog(context);
      //       },
      //       child: Row(
      //         children: [
      //           Icon(Icons.add, color: Colors.white, size: 20),
      //           Text(
      //             '라이브러리 추가',
      //             style: TextStyle(
      //               color: Colors.white, // 폰트 색상
      //               fontSize: 12,
      //               fontWeight: FontWeight.normal,
      //             ),
      //           )
      //         ],
      //       ),
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: primary, // 배경색상
      //         //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //       ),
      //     ),
      //   ),
      // ),

      // floatingActionButtonLocation: ExpandableFab.location,
      // floatingActionButton: ExpandableFab(
      //   key: _key,
      //   type: ExpandableFabType.up,
      //   overlayStyle: ExpandableFabOverlayStyle(
      //     color: Colors.black.withOpacity(0.5),
      //   ),
      //   distance: 70.0,
      //   //childrenOffset: const Offset(0, 0),
      //
      //   children: [
      //     FloatingActionButton.small(
      //       child: const Icon(Icons.edit),
      //       onPressed: () {
      //         final state = _key.currentState;
      //
      //         if (state != null) {
      //           state.toggle();
      //         }
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(
      //         //     builder: (context) => GenerateProblemScreen(library: library),
      //         //   ),
      //         // );
      //       },
      //     ),
      //     FloatingActionButton.small(
      //       child: const Icon(Icons.file_open),
      //       onPressed: () {
      //         final state = _key.currentState;
      //         if (state != null) {
      //           debugPrint('isOpen:${state.isOpen}');
      //           state.toggle();
      //         }
      //       },
      //     ),
      //     FloatingActionButton.small(
      //       child: const Icon(Icons.photo_camera),
      //       onPressed: () {
      //         final state = _key.currentState;
      //         if (state != null) {
      //           debugPrint('isOpen:${state.isOpen}');
      //           state.toggle();
      //         }
      //       },
      //     ),
      //   ],
      // ),
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<String> _getPdfText() async {
    if (_pickedFile == null) {
      return '';
    }
    // http.MultipartFile.fromBytes(
    //   'file',
    //   _pickedFile!.bytes!,
    //   filename: _pickedFile!.name,
    // ),
    final document = PdfDocument(inputBytes: _pickedFile!.bytes);
    //Todo: 위에 두 줄 삭제
    //Todo: 위 document를 자신의 휴대폰에서 선택한 pdf에 대한 도큐먼트로 교체
//Disposes the document
//Extract the text from all the pages.
    String rettext = PdfTextExtractor(document).extractText();
    document.dispose();
    debugPrint(rettext);
    return rettext;

//Dispose the document.
  }

  void _problemDialog(BuildContext context, Library library) {
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
                  "어떤 방식으로 문제를 생성할까요?",
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
                          builder: (context) =>
                              GenerateProblemScreen(library: library)),
                    );
                  },
                  child: Text('직접 입력')),
              ElevatedButton(
                  onPressed: () async {
                    await _pickFile();
                    if (_pickedFile != null) {
                      String tmpText = await _getPdfText();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GenerateProblemScreen(
                                library: library, text: tmpText)),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => AddQuestionView(
                      //           library: widget.library, text: tmpText)),
                      // );
                    }
                  },
                  child: Text('PDF파일 첨부')),
            ],
          );
        });
  }

  //라이브러리 추가 다이얼로그
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

  //디렉토리 관련 다이얼로그
  void FlutterDialog(BuildContext context, int libraryIndex,
      MiniDirectory miniDirectory, int directoryIndex) {
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
                    AditDialog(context, miniDirectory, directoryIndex);
                  },
                  child: Text("수정하기"),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadProblemScreen(
                                library: libraryList[libraryIndex],
                                directory: miniDirectory,
                              )),
                    );
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
                    DelteDialog(context, miniDirectory);
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

  void DelteDialog(BuildContext context, MiniDirectory miniDirectory) {
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
                    await deleteDirectory(miniDirectory.id);
                    await initLibraryList();
                    Navigator.of(context).pop();
                  },
                  child: Text('확인')),
            ],
          );
        });
  }

  void AditDialog(
      BuildContext context, MiniDirectory miniDirectory, int index) {
    List<TextEditingController> _titleControllerList = [];
    List<TextEditingController> _conceptControllerList = [];
    for (int i = 0; i < libraryList[index].miniDirectories.length; i++) {
      _titleControllerList.add(TextEditingController());
      _conceptControllerList.add(TextEditingController());
      _conceptControllerList[i] = TextEditingController(
          text: libraryList[index].miniDirectories[i].concept);
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
                TextField(
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
                          builder: (context) => UpdateProblemScreen(
                                library: libraryList[index],
                                directoryId: miniDirectory.id,
                                directoryTitle: miniDirectory.title,
                                directoryConcept: miniDirectory.concept,
                              )),
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
                        miniDirectory.id,
                        _titleControllerList[index].text,
                        _conceptControllerList[index].text);
                    await initLibraryList();
                    Navigator.of(context).pop();
                  },
                  child: Text('이름변경')),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소')),
            ],
          );
        });
  }
}
