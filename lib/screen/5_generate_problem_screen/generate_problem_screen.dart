import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_user_choice_screen.dart';
import 'package:jongsul/screen/widget/download_button.dart';

class GenerateProblemScreen extends StatefulWidget {
  Library library;
  String? text;
  GenerateProblemScreen({required this.library,
    this.text,
    super.key});

  @override
  State<GenerateProblemScreen> createState() => _GenerateProblemScreenState();
}

class _GenerateProblemScreenState extends State<GenerateProblemScreen> {
  final TextEditingController _directoryTitleController = TextEditingController();
  final TextEditingController _conceptController = TextEditingController(
      text: TEST_TEXT);
  @override
  void initState() {
    // TODO: implement initState
    if(widget.text!=null){
      _conceptController.text = widget.text!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("문제 생성"),
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
                    child: TextFormField(
                      maxLength: 20,
                      controller: _directoryTitleController,
                      decoration: InputDecoration(
                        hintText: '디렉토리 제목을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                        counterText: '', //글자수 제한 표시 없앰
                      ),
                      validator: (value) {
                        //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                        if (value != null && value.isEmpty) {
                          return '디렉토리 제목 입력해줘';
                        }
                        return null;
                      },
                      // textInputAction: TextInputAction.search,
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Center(
                  child: Padding(
                    child: TextFormField(
                      maxLines: 300, // 최대 높이(줄) 설정
                      minLines: 1, // 최소 높이(줄) 설정
                      maxLength: 1000,
                      controller: _conceptController,
                      decoration: InputDecoration(
                        hintText: '문제를 생성할 개념을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                        if (value != null && value.isEmpty) {
                          return '생성 문제 개념 입력해줘';
                        }
                        return null;
                      },
                      //textInputAction: TextInputAction.search,
                    ),
                    padding: EdgeInsets.all(20),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       child: Column(
                //         children: [
                //           ElevatedButton(
                //             //icon: Icon(Icons.download, size: 18),
                //             child: Text("문제 생성하기"),
                //             onPressed: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(builder: (context) => GenerateProblemUserChoiceScreen(library: widget.library, title: _directoryTitleController.text, concept: _conceptController.text )),
                //               );
                //
                //             },
                //             style: ElevatedButton.styleFrom(
                //                 foregroundColor: Colors.white,
                //                 backgroundColor: Color(0XFF8B5000),
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal: 30, vertical: 15),
                //                 textStyle: TextStyle(
                //                     fontSize: 14, fontWeight: FontWeight.normal)),
                //           )
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0), // 원하는 여유 공간 추가
        child: ElevatedButton(
          //icon: Icon(Icons.download, size: 18),
          child: Text("문제 생성하기"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GenerateProblemUserChoiceScreen(library: widget.library, title: _directoryTitleController.text, concept: _conceptController.text )),
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


String TEST_TEXT = '''	어플리케이션 레이어
	네트워크 어플리케이션 원리
	호스트가 어플리케이션 서비스를 전달해주는 목적의 레이어
	네트워크로 의사소통
	네트워크 어플리케이션 구조s
	클라이언트 - 서버
	클라이언트 서버
•	서버
♦	정보 제공
♦	언제나 켜져있는 호스트
♦	고유 IP 주소 가짐
•	클라이언트
♦	정보 요청
♦	주로 간헐적으로 연결
♦	주로 동적 IP주소를 가짐
♦	클라이언트 끼리 상호작용하지 않음
	Peer-To-Peer(P2P)
•	서버 클라이언트 구조 아님
•	자기확장성을 가짐
•	피어는 다른 피어의 서비스를 제공
•	간헐적으로 연결되 호스트 쌍이 서로 직접 연결한다
	어플리케이션 레이어 프로토콜 정의
	메세지 유형
•	요청
•	응답
	메세지 형식
	메세지 송수신 규칙
	오픈 프로토콜
•	RCF와 같은 공개 문서를 통해 정의
•	다른 조직이나 업체에서 구현하고 사용할 수 있음
•	HTTP SMTP 등이 있다.
	공개적이지 않은 프로토콜
•	해당 조직 또는 업체의 제품 간에만 사용
•	스카이프가 이에 해당된다 
	어플리케이션 요구
	데이터 무결성
•	어떤 앱은 100%의 신뢰성 요구
•	다른 앱은 조금의 데이터 로스 허용
	타이밍
•	몇몇 앱은 적은 딜레이를 원함
	처리융(스루풋)
•	몇몇 어플은 처리율이 항상 r bps 이상인 앱이여야 한다
•	다른 어플은 처리율 제한이 없다
	보안
•	TCP vs UDP
♦	인터넷 프로토콜 스택에서 사용되는 두 가지 중요한 전송 계층 프로토콜
♦	TCP
	신뢰성 있는 전송
	데이터가 손실되거나 손상되지 않도록 보장하며, 순서대로 전달
	흐름 제어
	수신 측이 처리할 수 있는 속도에 따라 데이터의 전송 속도 전달
	혼잡 제어
	네트워크 혼잡을 감지하고 발신자의 전송 속도를 조절
	기타 요소
	타이밍, 최소 대역폭 보장, 보안, 연결 설정 등에 대한 지원을 제공하지 않음 이건 응용 프로그램 수준에서 관리해야 함
	연결 지향
	데이터 전송 전에 클라이언트와 서버 간의 연결 설정 요구
♦	UDP
	신뢰성 없는 데이터 전송
	데이터를 전송하지만, 데이터 손실이나 손상에 대한 보장을 제공하지 않음
	데이터 손실 또는 순서가 뒤섞일 수 있음
	흐름 제어 및 혼잡 제어 없음
	UDP는 흐름 제어, 혼잡 제어, 타이밍, 최소 대역폭 보장, 보안 연결설정과 같은 기능을 제공하지 않음
♦	소켓
	어플리케이션 계층과 트랜스포트 계층을 이어주는 통로
♦	주소 쳬게
	프로세스는 식별자가 필요하다
	Ipv4 기준 32bit 주소체계를 이용한다
	Ipv6는 128bit
	Ip주소가 있으면 충분할까?
	충분하지 않다
	같은 ip라도 프로세스가 많다
	프로세스를 구분하려면 포트 번호가 필요하다''';