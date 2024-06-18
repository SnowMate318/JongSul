// import 'dart:convert';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:jongsul/functions/http_request.dart';
// import 'package:jongsul/models/library/library_data.dart';
// import 'package:jongsul/models/library/library.dart';
// import 'package:jongsul/models/directory/directory.dart';
// import 'package:jongsul/models/directory/directory_data.dart';
// import 'package:jongsul/models/question/question.dart';
// import 'package:get/get.dart';
// import 'package:jongsul/models/question_testview.dart';
// import 'package:jongsul/models/shared/shared_tag.dart';
// import 'package:mime/mime.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:http_parser/http_parser.dart'; // Add this import for MediaType
// import 'package:syncfusion_flutter_pdf/pdf.dart';
//
// import '../strings.dart';
// import 'directory/mini_directory.dart';
//
// class DirectoryTestView extends StatefulWidget {
//   Library library;
//
//   DirectoryTestView({required this.library, super.key});
//
//   @override
//   State<DirectoryTestView> createState() => _DirectoryTestViewState();
// }
//
// class _DirectoryTestViewState extends State<DirectoryTestView> {
//   List<Directory> directoryList = [];
//
//   @override
//   void initState() {
//     initDirectories();
//     super.initState();
//   }
//
//   initDirectories() async {
//     directoryList = await getDirectoryList(widget.library.id);
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Column(children: [
//               Text('라이브러리 이름: ${widget.library.title}'),
//               SizedBox(
//                 height: 20,
//               ),
//               Text('라이브러리 아이디: ${widget.library.id}'),
//               SizedBox(
//                 height: 20,
//               ),
//               _buildDirectoryList(),
//             SizedBox(
//               height: 20,
//             ),
//             TextButton(
//                 onPressed: () async {
//                   Get.to(AddQuestionView(library: widget.library));
//                 },
//                 child: Text("문제 추가")
//             ),
//
//             TextButton(
//                 onPressed: () async {
//                   String tmpText = await _getPdfText();
//                   Get.to(AddQuestionView(library: widget.library, text: tmpText));
//                 },
//                 child: Text("pdf 문제 추가")
//             ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDirectoryList() {
//     List<TextEditingController> _titleControllerList = [];
//     List<TextEditingController> _conceptControllerList = [];
//     for (int i = 0; i < directoryList.length; i++) {
//       _titleControllerList.add(TextEditingController());
//       _conceptControllerList.add(TextEditingController());
//     }
//     return Column(
//       children: [
//         Text('디렉토리 리스트'),
//         SizedBox(
//           height: 20,
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: directoryList.length,
//           itemBuilder: (context, index) {
//             return Column(
//               children: [
//                 Text('디렉토리 아이디: ${directoryList[index].id}'),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text('디렉토리 이름: ${directoryList[index].title}'),
//                 Text('디렉토리 설명: ${directoryList[index].concept}'),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () async {
//                       Get.to(QuestionTestView(directoryId: directoryList[index].id, directoryTitle: directoryList[index].title));
//                     },
//                     child: Text("문제 풀어보기")),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Get.to(ShareDirectotyView(
//                           directory: directoryList[index],
//                           library: widget.library));
//                     },
//                     child: Text('문제 공유하기')),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   controller: _titleControllerList[index],
//                   decoration: InputDecoration(
//                     labelText: '수정할 디렉토리 이름',
//                   ),
//                   validator: (value) {
//                     //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
//                     if (value!.isEmpty) {
//                       return '디렉토리 제목 입력해줘';
//                     }
//                     if (directoryList
//                         .any((library) => library.title == value)) {
//                       return '이미 존재하는 디렉토리';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _conceptControllerList[index],
//                   decoration: InputDecoration(
//                     labelText: '수정할 디렉토리 설명',
//                   ),
//                 ),
//                 TextButton(
//                     onPressed: () async {
//                       await patchDirectory(
//                           directoryList[index].id,
//                           _titleControllerList[index].text,
//                           _conceptControllerList[index].text);
//                       await initDirectories();
//                     },
//                     child: Text("디렉토리 수정")),
//                 TextButton(
//                     onPressed: () async {
//                       await deleteDirectory(directoryList[index].id);
//                       await initDirectories();
//                     },
//                     child: Text("디렉토리 삭제")),
//
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
//   Future<String> _getPdfText() async {
//     final byteData = await rootBundle.load('assets/pdfs/software.pdf');
//     final document = PdfDocument(inputBytes: byteData.buffer.asUint8ClampedList());
//     //Todo: 위에 두 줄 삭제
//     //Todo: 위 document를 자신의 휴대폰에서 선택한 pdf에 대한 도큐먼트로 교체
// //Disposes the document
// //Extract the text from all the pages.
//     String rettext = PdfTextExtractor(document).extractText();
//     document.dispose();
//     debugPrint(rettext);
//     return rettext;
//
// //Dispose the document.
//
//   }
// }
// //------------------------ 문제공유 ---------------------------
// class ShareDirectotyView extends StatefulWidget {
//   Directory directory;
//   Library library;
//
//   ShareDirectotyView(
//       {required this.directory, required this.library, super.key});
//
//   @override
//   State<ShareDirectotyView> createState() => _ShareDirecrotyViewState();
// }
//
// class _ShareDirecrotyViewState extends State<ShareDirectotyView> {
//   final TextEditingController _conceptController = TextEditingController();
//   final TextEditingController _tagController = TextEditingController();
//   List<SharedTag> sharedTagList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Text('공유 디렉토리 설명'),
//                 TextFormField(
//                   controller: _conceptController,
//                   decoration: InputDecoration(
//                     labelText: '공유 디렉토리 설명',
//                   ),
//                   validator: (value) {
//                     //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
//                     if (value!.isEmpty) {
//                       return '공유 디렉토리 설명 입력해줘';
//                     }
//
//                     return null;
//                   },
//                 ),
//
//                 //태그 입력
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text('공유 디렉토리 태그'),
//                 Row(children: [
//                   SizedBox(
//                     width: 200,
//                     height: 35,
//                     child: TextFormField(
//                       maxLength: 20,
//                       controller: _tagController,
//                       textAlignVertical: TextAlignVertical.top,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelStyle: TextStyle(color: Color(0xFF8B5000)),
//                         counterText: '', //글자수 제한 표시 없앰
//                       ),
//                       validator: (value) {
//                         //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
//                         if (value == null || value.isEmpty) {
//                           return '공유 디렉토리 태그 입력해줘';
//                         }
//
//                         return null;
//                       },
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       if (_tagController.text.isNotEmpty) {
//                         sharedTagList
//                             .add(SharedTag.init(name: _tagController.text));
//                         setState(() {});
//                       }
//                     },
//                     child: Text('태그 추가'),
//                   ),
//                 ]),
//                 //태그 리스트
//                 _buildTagChips(),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextButton(
//                     onPressed: () async {
//                       await shareDirectory(
//                         widget.library.title,
//                         widget.directory,
//                         sharedTagList,
//                         _conceptController.text,
//                       );
//                     },
//                     child: Text("디렉토리 공유하기")),
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Widget _buildTagChips() {
//     return Wrap(
//       spacing: 8.0, // gap between adjacent chips
//       runSpacing: 4.0, // gap between lines
//       children: sharedTagList.map((SharedTag tag) {
//         return Chip(
//           label: Text(tag.name),
//           onDeleted: () {
//             setState(() {
//               sharedTagList.remove(tag);
//             });
//           },
//         );
//       }).toList(),
//     );
//   }
// }
//
// //------------------------ 문제생성 ---------------------------
// class AddQuestionView extends StatefulWidget {
//   Library library;
//   String? text;
//   AddQuestionView({
//     required this.library,
//     this.text,
//     super.key
//   });
//
//   @override
//   State<AddQuestionView> createState() => _AddQuestionViewState();
// }
//
// class _AddQuestionViewState extends State<AddQuestionView> {
//   final TextEditingController _directoryTitleController = TextEditingController();
//   final TextEditingController _conceptController = TextEditingController(
//       text: TEST_TEXT);
//   final TextEditingController _difficultyController = TextEditingController();
//   final TextEditingController _multipleChoiceController = TextEditingController();
//   final TextEditingController _shortAnswerController = TextEditingController();
//   final TextEditingController _oxController = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     if(widget.text!=null){
//       _conceptController.text = widget.text!;
//     }
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Text('디렉토리 추가'),
//               SizedBox(
//                 height: 20,
//               ),
//               Text('디렉토리 제목'),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: '디렉토리 제목',
//                 ),
//                 controller: _directoryTitleController,
//                 validator: (value) {
//                   //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
//                   if (value != null && value.isEmpty) {
//                     return '디렉토리 제목 입력해줘';
//                   }
//                   return null;
//                 },
//
//               ),
//               Text('생성 문제 개념'),
//               TextFormField(
//                 maxLines: 1000, // 최대 높이(줄) 설정
//                 minLines: 1, // 최소 높이(줄) 설정
//                 maxLength: 10000,
//                 decoration: InputDecoration(
//                   labelText: '생성 문제 개념',
//                 ),
//                 controller: _conceptController,
//                 validator: (value) {
//                   //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
//                   if (value != null && value.isEmpty) {
//                     return '생성 문제 개념 입력해줘';
//                   }
//                   return null;
//                 },
//               ),
//               Text('생성 문제 난이도'),
//               SizedBox(
//                 width: 50,
//                 height: 35,
//                 child: TextFormField(
//                   maxLength: 20,
//                   controller: _difficultyController,
//                   textAlignVertical: TextAlignVertical.top,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelStyle: TextStyle(color: Color(0xFF8B5000)),
//                     counterText: '', //글자수 제한 표시 없앰
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return '생성 문제 난이도 입력해줘';
//                     }
//                     if (int.tryParse(value) == null) {
//                       return '숫자로 입력해줘';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text('객관식: '),
//                   SizedBox(
//                     width: 50,
//                     height: 35,
//                     child: TextFormField(
//                       maxLength: 20,
//                       controller: _multipleChoiceController,
//                       textAlignVertical: TextAlignVertical.top,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelStyle: TextStyle(color: Color(0xFF8B5000)),
//                         counterText: '', //글자수 제한 표시 없앰
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return '생성 문제 난이도 입력해줘';
//                         }
//                         if (int.tryParse(value) == null) {
//                           return '숫자로 입력해줘';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Text('주관식: '),
//                   SizedBox(
//                     width: 50,
//                     height: 35,
//                     child: TextFormField(
//                       maxLength: 20,
//                       controller: _shortAnswerController,
//                       textAlignVertical: TextAlignVertical.top,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelStyle: TextStyle(color: Color(0xFF8B5000)),
//                         counterText: '', //글자수 제한 표시 없앰
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return '생성 문제 난이도 입력해줘';
//                         }
//                         if (int.tryParse(value) == null) {
//                           return '숫자로 입력해줘';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Text('ox문제: '),
//                   SizedBox(
//                     width: 50,
//                     height: 35,
//                     child: TextFormField(
//                       maxLength: 20,
//                       controller: _oxController,
//                       textAlignVertical: TextAlignVertical.top,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelStyle: TextStyle(color: Color(0xFF8B5000)),
//                         counterText: '', //글자수 제한 표시 없앰
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return '생성 문제 난이도 입력해줘';
//                         }
//                         if (int.tryParse(value) == null) {
//                           return '숫자로 입력해줘';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//
//               TextButton(
//                   onPressed: () async {
//                     MiniDirectory miniDirectory = await addDirectory(
//                         widget.library.id,
//                         _directoryTitleController.text,
//                         _conceptController.text,
//                         int.parse(_difficultyController.text),
//                         int.parse(_multipleChoiceController.text),
//                         int.parse(_shortAnswerController.text),
//                         int.parse(_oxController.text));
//                     if(miniDirectory.id != 0){
//                       Get.to(GoToQuestionVIew(miniDirectory: miniDirectory));
//                     } else {
//                       //Todo: 오류 처리(디렉토리 생성 못함)
//                       //Todo: 알림창(디렉토리를 생성하지 못했습니다 다시 시도 등)
//                     }
//                   },
//                   child: Text("문제 추가")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class GoToQuestionVIew extends StatefulWidget {
//   MiniDirectory miniDirectory;
//   GoToQuestionVIew({
//     required this.miniDirectory,
//     super.key
//   });
//
//   @override
//   State<GoToQuestionVIew> createState() => _GoToQuestionVIewState();
// }
//
// class _GoToQuestionVIewState extends State<GoToQuestionVIew> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text('문제 추가 완료'),
//             TextButton(
//                 onPressed: () {
//                   Get.to(QuestionTestView(directoryId: widget.miniDirectory.id, directoryTitle: widget.miniDirectory.title,));
//                 },
//                 child: Text('문제 풀기'))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// String TEST_TEXT = '''	어플리케이션 레이어
// 	네트워크 어플리케이션 원리
// 	호스트가 어플리케이션 서비스를 전달해주는 목적의 레이어
// 	네트워크로 의사소통
// 	네트워크 어플리케이션 구조s
// 	클라이언트 - 서버
// 	클라이언트 서버
// •	서버
// ♦	정보 제공
// ♦	언제나 켜져있는 호스트
// ♦	고유 IP 주소 가짐
// •	클라이언트
// ♦	정보 요청
// ♦	주로 간헐적으로 연결
// ♦	주로 동적 IP주소를 가짐
// ♦	클라이언트 끼리 상호작용하지 않음
// 	Peer-To-Peer(P2P)
// •	서버 클라이언트 구조 아님
// •	자기확장성을 가짐
// •	피어는 다른 피어의 서비스를 제공
// •	간헐적으로 연결되 호스트 쌍이 서로 직접 연결한다
// 	어플리케이션 레이어 프로토콜 정의
// 	메세지 유형
// •	요청
// •	응답
// 	메세지 형식
// 	메세지 송수신 규칙
// 	오픈 프로토콜
// •	RCF와 같은 공개 문서를 통해 정의
// •	다른 조직이나 업체에서 구현하고 사용할 수 있음
// •	HTTP SMTP 등이 있다.
// 	공개적이지 않은 프로토콜
// •	해당 조직 또는 업체의 제품 간에만 사용
// •	스카이프가 이에 해당된다
// 	어플리케이션 요구
// 	데이터 무결성
// •	어떤 앱은 100%의 신뢰성 요구
// •	다른 앱은 조금의 데이터 로스 허용
// 	타이밍
// •	몇몇 앱은 적은 딜레이를 원함
// 	처리융(스루풋)
// •	몇몇 어플은 처리율이 항상 r bps 이상인 앱이여야 한다
// •	다른 어플은 처리율 제한이 없다
// 	보안
// •	TCP vs UDP
// ♦	인터넷 프로토콜 스택에서 사용되는 두 가지 중요한 전송 계층 프로토콜
// ♦	TCP
// 	신뢰성 있는 전송
// 	데이터가 손실되거나 손상되지 않도록 보장하며, 순서대로 전달
// 	흐름 제어
// 	수신 측이 처리할 수 있는 속도에 따라 데이터의 전송 속도 전달
// 	혼잡 제어
// 	네트워크 혼잡을 감지하고 발신자의 전송 속도를 조절
// 	기타 요소
// 	타이밍, 최소 대역폭 보장, 보안, 연결 설정 등에 대한 지원을 제공하지 않음 이건 응용 프로그램 수준에서 관리해야 함
// 	연결 지향
// 	데이터 전송 전에 클라이언트와 서버 간의 연결 설정 요구
// ♦	UDP
// 	신뢰성 없는 데이터 전송
// 	데이터를 전송하지만, 데이터 손실이나 손상에 대한 보장을 제공하지 않음
// 	데이터 손실 또는 순서가 뒤섞일 수 있음
// 	흐름 제어 및 혼잡 제어 없음
// 	UDP는 흐름 제어, 혼잡 제어, 타이밍, 최소 대역폭 보장, 보안 연결설정과 같은 기능을 제공하지 않음
// ♦	소켓
// 	어플리케이션 계층과 트랜스포트 계층을 이어주는 통로
// ♦	주소 쳬게
// 	프로세스는 식별자가 필요하다
// 	Ipv4 기준 32bit 주소체계를 이용한다
// 	Ipv6는 128bit
// 	Ip주소가 있으면 충분할까?
// 	충분하지 않다
// 	같은 ip라도 프로세스가 많다
// 	프로세스를 구분하려면 포트 번호가 필요하다''';