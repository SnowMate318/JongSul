import 'package:flutter/material.dart';

class CommunitySearch extends StatefulWidget {
  const CommunitySearch({super.key});

  @override
  State<CommunitySearch> createState() => _CommunitySearchState();
}

class _CommunitySearchState extends State<CommunitySearch> {
  //검색어로 입력된 값이 담기는 변수
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //불투명한 배경색 필요함
          children: [
            Container(
              height: 150,
            ),
            //색있는 큰 박스
            Container(
              width: 412,
              height: 690,
              //padding: const EdgeInsets.only(bottom: 598),
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                color: Color(0xFFFDF2EA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
              ),

              //textfield가 focus됐을 때 박스의 다른 부분을 클릭하면 unfocus해주는 기능
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),

                //색이 있는 큰 박스를 아래로 스와이프했을 때 뒤로 이동하는 기능
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      Navigator.of(context).pop(); // 뒤로 이동
                    }
                  },

                  //column()적용시에 키보드가 생성되면 overflowed경고가 뜰 수 있어 포함시킨 함수
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //중앙 상단의 짧은 사각형
                        Container(
                          width: double.infinity,
                          height: 36,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: 0.40,
                                child: Container(
                                  width: 32,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF837468),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //검색창
                        Center(
                          child: Padding(
                            child: TextField(
                              maxLength: 30,
                              controller: inputController,
                              decoration: InputDecoration(
                                labelText: 'search',
                                hintText: '검색어를 입력해 주세요.',
                                labelStyle: TextStyle(color: Color(0xFF8B5000)),

                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF51453A),
                                ),

                                //포커스 됐을 때
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF8B5000)),
                                ),

                                //포커스 되지 않았을 때
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF8B5000)),
                                ),

                                //포커스 되지 않았을 때 border여부
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                suffixIcon: IconButton(
                                  //x버튼 클릭 시 작성한 내용을 초기화시킴
                                  onPressed: () => setState(() {
                                    inputController.text = '';
                                  }),
                                  icon: const Icon(Icons.highlight_off),
                                  color: Color(0xFF51453A),
                                ),
                              ),
                              textInputAction: TextInputAction.search,
                            ),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
