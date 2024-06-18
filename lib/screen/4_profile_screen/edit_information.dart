import 'package:flutter/material.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
import 'package:jongsul/screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/screen/4_profile_screen/profile_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';

class EditInformation extends StatefulWidget {
  const EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final TextEditingController _usernameController = TextEditingController();

  ServiceUser user = ServiceUser.init();

  @override
  void initState() {
    // TODO: 퀘스쳔 리스트 받아오기
    initUser();
    super.initState();
  }

  void initUser() async {
    user = await getServiceUser();
    _usernameController.text = user.user_name;
    setState(() {});
  }

  void handleDeleteServiceUser() async {
    bool tmp = await deleteServiceUser();
  }

  void handleSetServiceUser(String username) async {
    var data = {
      'user_name': username,
      //'profile': TEST_PROFILE,
    };
    ServiceUser? tmp = await setServiceUserRetUser(data: data);
    if (tmp != null) {
      user = await getServiceUser();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 정보"),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),
      ),
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: '닉네임',
                  border: InputBorder.none,
                ),
                //obscureText: true,
                validator: (value) {
                  //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                  if (value!.isEmpty) {
                    return '유저이름 입력해줘';
                  }
                  return null;
                },
              ),
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('회원 정보를 삭제하시겠어요?'),
                  TextButton(
                    onPressed: () {

                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Text(
                        '회원탈퇴',
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
          ],
        ),
        //child: Profile(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0), // 원하는 여유 공간 추가
        child: ElevatedButton(
          //icon: Icon(Icons.download, size: 18),
          child: Text("수정 완료"),
          onPressed: () {
            handleSetServiceUser(_usernameController.text);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
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
                  "회원 탈퇴를 하시겠습니까?",
                ),
              ],
            ),

            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소')),
              ElevatedButton(
                  onPressed: () async {
                    await handleDeleteServiceUser;
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('확인')),
            ],
          );
        });
  }
}
