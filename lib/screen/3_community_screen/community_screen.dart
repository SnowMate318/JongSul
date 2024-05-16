import 'package:flutter/material.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/screen/widget/community_post.dart';
import 'package:jongsul/screen/widget/tag.dart';
import 'package:jongsul/screen/3_community_screen/search_screen.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/class/uploadedTest.dart';
import 'package:jongsul/models/shared/shared.dart';
import 'package:jongsul/tools/style.dart';

class CommunityScreen extends StatefulWidget {
  //Shared tmpl;
  //CommunityScreen({super.key, required this.tmpl});
  CommunityScreen({super.key});


  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  // 리스트 뷰를 실행할 횟수(임시값)
  final List<String> entries = <String>['A', 'B', 'C'];

  //드롭다운 메뉴 리스트
  List<String> dropDownList = ['1', '2', '3'];

  // 드롭다운 버튼의 선택된 값을 저장할 변수
  String dropDownValue = "1";

  Shared shared = Shared.init(
      sharedId: 1,
      //shared_title: "First Share",
      shared_content: "Content of the first shared item",
      shared_upload_datetime: "2023-04-14T12:00:00",
      is_activated: true,
      is_deleted: false,
      download_count: 150,
      userName: 'User1',
      userProfile: 'https://via.placeholder.com/40x40',
      sharedTags: ['전자공학부', '지능로봇공학과'],
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("커뮤니티"),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),

      ),
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildTag("전자공학부"),
                      SizedBox(
                        width: 10,
                      ),
                      _buildTag("태그"),
                    ],
                  ),
                  _buildFilter(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildPosts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tagTitle){
      return InputChip(
        label: Text(tagTitle),
        labelStyle: labelTextStyle,
        backgroundColor: Color(0xFFFFDCBE),
        onDeleted: (){
          debugPrint("input chip deleted");
        },
      );
  }

  Widget _buildFilter(){
    return IconButton(//눌렀을 때 밑에서 위로 올라오는 걸로 변경
      iconSize: 30,
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CommunitySearch()),
        );
      },
    );
  }

  Widget _buildPosts (){
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length, //API에서 받아오는 개수로 바꿔주기
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              communityPost(context, shared),
              SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }
}

// actions: [
//   IconButton(//눌렀을 때 밑에서 위로 올라오는 걸로 변경
//     iconSize: 30,
//     icon: const Icon(Icons.search),
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => CommunitySearch()),
//       );
//     },
//   ),
// ],

// DropdownButton(
//   //https://api.flutter.dev/flutter/material/DropdownButton-class.html
//   //드롭다운메뉴로 바꾸고 싶으면 위 사이트에서 참고
//
//   //초기값
//   value: dropDownValue,
//   //드롭다운 아이템 목록
//   items: dropDownList
//       .map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(value),
//     );
//   }).toList(),
//   //사용자가 선택한 메뉴가 달라질 때마다 실행
//   onChanged: (String? newValue) {
//     setState(() {
//       dropDownValue = newValue!;
//     });
//   },
//   //아이콘
//   icon: Icon(Icons.filter_list),
// )