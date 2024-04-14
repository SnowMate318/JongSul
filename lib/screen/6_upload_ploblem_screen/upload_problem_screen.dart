import 'package:flutter/material.dart';
import 'package:jongsul/tools/style.dart';

class UploadProblemScreen extends StatefulWidget {
  const UploadProblemScreen({super.key});

  @override
  State<UploadProblemScreen> createState() => _UploadProblemScreenState();
}

class _UploadProblemScreenState extends State<UploadProblemScreen> {
  TextEditingController description = TextEditingController();
  TextEditingController tag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("문제 공유")), // 앱바 사용
        body: SafeArea(
          //메인 화면
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20, top: 50, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '설명',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '(100자 이내)',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Center(
                  child: Padding(
                    child: TextField(
                      maxLength: 20,
                      controller: description,
                      decoration: InputDecoration(
                        hintText: '설명을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                        counterText: '', //글자수 제한 표시 없앰
                      ),
                      // textInputAction: TextInputAction.search,
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '태그',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),

                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 400,
                        child: Padding(
                          child: TextField(
                            // maxLines: 30, // 최대 높이(줄) 설정
                            // minLines: 1, // 최소 높이(줄) 설정
                            maxLength: 1000,
                            controller: tag,
                            decoration: InputDecoration(
                              hintText: '태그를 입력해 주세요.',
                              labelStyle: TextStyle(color: Color(0xFF8B5000)),
                              border: InputBorder.none,
                              counterText: '', //글자수 제한 표시 없앰
                            ),
                            //textInputAction: TextInputAction.search,
                          ),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            //icon: Icon(Icons.download, size: 18),
                            child: Text("추가", style: TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal)),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF8B5000),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                            ),
                          )),
                    ]),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    _buildTag("전자공학부"),
                    SizedBox(
                      width: 10,
                    ),
                    _buildTag("태그"),
                  ],
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
                        children: [
                          ElevatedButton(
                            //icon: Icon(Icons.download, size: 18),
                            child: Text("공유하기",style: TextStyle(
                                color: Colors.white, fontSize: 14,
                                fontWeight: FontWeight.normal)),
                            onPressed: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => GenerateProblemUserChoiceScreen()),
                              //   );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF8B5000),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                ),
                          )
                        ],
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
        ));
  }
}

Widget _buildTag(String tagTitle) {
  return InputChip(
    label: Text(tagTitle),
    labelStyle: labelTextStyle,
    backgroundColor: Color(0xFFFFDCBE),
    onDeleted: () {
      debugPrint("input chip deleted");
    },
  );
}
