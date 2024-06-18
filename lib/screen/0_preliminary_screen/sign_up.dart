import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
import 'package:jongsul/screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/screen/1_main_screen/home_screen.dart';
import 'package:jongsul/screen/2_lib_screen/lib_screen.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ServiceUser testUser = ServiceUser.init();
  SharedPreferences? prefs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  void handleSignUp(String email, String password) async {
    var newUser = await signUp(email, password);
    setState(() {
      testUser = newUser;
    });
  }

  void handleSetServiceUser(String username) async {
    var data = {
      'user_name': username,
      //'profile': TEST_PROFILE,
    };
    ServiceUser? tmp = await setServiceUserRetUser(data: data);
    setState(() {
      if (tmp != null) {
        testUser = tmp;
        debugPrint('set service user success');
      } else {
        debugPrint('set service user failed');
      }
    });
  }

  String idInputText = '';
  String passwordInputText = '';
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('회원가입')), //앱바 설정 앱바 텍스트는 text변수에 저장된 "JongSul"
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 70, right: 70),
          child: Center(
            child: Form(
              key: _formKey,
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
                          return '유효한 이메일을 입력해 주세요';
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
                          return '비밀번호를 입력해 주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('닉네임'),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    //width: 70,
                    height: 35,
                    child: TextFormField(
                      obscureText: false,
                      maxLength: 7,
                      controller: _usernameController,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        counterText: '', //글자수 제한 표시 없앰
                      ),
                      validator: (value) {
                        //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                        if (value!.isEmpty) {
                          return '닉네임을 입력해 주세요';
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
                          child: Text("가입하기",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              handleSignUp(idController.text, passwordController.text);
                              handleSetServiceUser(_usernameController.text);
                              if (prefs != null) {
                                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                                //Get.to(LoginScreen());
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF8B5000),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          )),
                    ],
                  ),
                ],
              ),
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
