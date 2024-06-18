import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
import 'package:jongsul/screen/0_preliminary_screen/sign_up.dart';
import 'package:jongsul/screen/1_main_screen/home_screen.dart';
import 'package:jongsul/screen/2_lib_screen/lib_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ServiceUser testUser = ServiceUser.init();
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  void testUserlogin(String email, String password) async {
    var newUser = await loginRetUser(email, password);
    setState(() {
      testUser = newUser;
    });
  }

  void afterKakaoLogin()async{
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
      //Todo: 닉네임 및 이메일 정보 수신동의
      String userId = user.id.toString();
      String userEmail = user.kakaoAccount?.email ?? '';
      String userNickname = user.kakaoAccount?.profile?.nickname ?? '';

      testUser = await socialLogin(userId, 'KAKAO', userEmail, userNickname);
      setState(() {});

    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }
  void handleKakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        afterKakaoLogin();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          afterKakaoLogin();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        afterKakaoLogin();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  String idInputText = '';
  String passwordInputText = '';
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('로그인')), //앱바 설정 앱바 텍스트는 text변수에 저장된 "JongSul"
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 70, right: 70),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //_buildPrintUser(testUser, prefs!),
                Text('이메일'),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //width: 70,
                  height: 35,
                  child: TextFormField(
                    maxLength: 30,
                    controller: idController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Color(0xFF8B5000)),
                      counterText: '', //글자수 제한 표시 없앰
                    ),
                    validator: (value) {
                      // 이메일 형식 체크 (xxxx@xxx.com) -> 이런 형태가 안나오면 에러
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern.toString());
                      if (!regex.hasMatch(value!))
                        return 'Enter Valid Email';
                      else
                        return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('비밀번호'),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //width: 70,
                  height: 35,
                  child: TextFormField(
                    obscureText: true,
                    maxLength: 16,
                    controller: passwordController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Color(0xFF8B5000)),
                      counterText: '', //글자수 제한 표시 없앰
                    ),
                    validator: (value) {
                      //비밀번호 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        //icon: Icon(Icons.download, size: 18),
                        child: Text("입력",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        onPressed: () async {
                          setState(() {
                            testUserlogin(
                                idController.text, passwordController.text);
                          });
                          if(prefs!=null){
                          Get.to(LibraryScreen());}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFF8B5000),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        )),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: handleKakaoLogin,
                      icon: Image.asset(
                        'assets/images/kakao_login_medium_narrow.png',
                        width: 100.0,
                        // fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(onPressed: () {Get.to(SignUpScreen());}, child: Text('회원가입')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrintUser(ServiceUser user, SharedPreferences prefs) {
    return Column(
      children: [
        Text('prefs access_token: ${prefs.getString('access_token')}'),
        Text('prefs refresh_token: ${prefs.getString('refresh_token')}'),
      ],
    );
  }
}
