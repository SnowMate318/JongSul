import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
import 'package:jongsul/screen/0_preliminary_screen/sign_up.dart';
import 'package:jongsul/screen/1_main_screen/home_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

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

  void handleKakaoLogin() async {
    var newUser = await signUpForKakao();
    setState(() {
      testUser = newUser;
    });
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
      bottomNavigationBar: DownMenuBar(),
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
                    //obscureText: true,
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
                          Get.to(HomeScreen());}
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
