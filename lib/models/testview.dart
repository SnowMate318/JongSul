import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jongsul/models/shared_testview.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'library_testview.dart';


// String id;
// String email;
// bool is_supueruser;
// bool is_active;
// bool is_staff;
// String created_at;
// String updated_at;
// String user_name;
// String profile;


class TestView extends StatefulWidget {

  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}
class _TestViewState extends State<TestView> {
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
  void handleLogoutServiceUser() async {
    bool tmp = await logout();
    setState(() {
      if (tmp) {
        testUser = ServiceUser.init();
        debugPrint('logout service user success');
      } else {
        debugPrint('logout service user failed');
      }
    });
  }
  void handleSignUp(String email, String password) async {
    var newUser = await signUp(email, password);
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

  void handleGetServiceUser() async {
    var newUser = await getServiceUser();
    setState(() {
      testUser = newUser;
      debugPrint(testUser.toJson().toString());
    });
  }

  void handleDeleteServiceUser() async {
    bool tmp = await deleteServiceUser();
    setState(() {
      if (tmp) {
        testUser = ServiceUser.init();
        debugPrint('delete service user success');
      } else {
        debugPrint('delete service user failed');
      }
    });
  }
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController2 = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("현재 유저 정보"),
              SizedBox(height: 20),
              _buildPrintUser(testUser, prefs!),
              SizedBox(height: 30),
              Text('로그인'),
              TextFormField(
                controller: _emailController2,
                decoration: InputDecoration(
                  labelText: 'Email',
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
              TextFormField(
                controller: _passwordController2,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  //비밀번호 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              TextButton(onPressed: ()async{
                testUserlogin(_emailController2.text, _passwordController2.text);
                }, child: Text('login')),
              SizedBox(height: 30),
              Text('회원정보 입력'),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  //비밀번호 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              TextButton(onPressed: (){handleSignUp(_emailController.text, _passwordController.text);}, child: Text('sign up')),
              SizedBox(height: 20),
              TextButton(onPressed: handleKakaoLogin, child: Text('login button kakao')),
              Text("유저이름 입력"),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'username',
                ),
                obscureText: true,
                validator: (value) {
                  //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                  if (value!.isEmpty) {
                    return '유저이름 입력해줘';
                  }
                  return null;
                },
              ),
              //Todo: 프로필 사진 업로드
              TextButton(onPressed: (){handleSetServiceUser(_usernameController.text);}, child: Text('set service user')),
              TextButton(onPressed: handleGetServiceUser, child: Text('get service user')),
              TextButton(onPressed: handleLogoutServiceUser, child: Text('logout service user')),
              SizedBox(
                height: 20,
              ),
              TextButton(onPressed: handleDeleteServiceUser, child: Text('delete service user')),
              OutlinedButton(
                  onPressed: () {
                    Get.to(LibraryTestView());
                  },
                  child: Text(
                    '로그인 또는 회원가입 이후 이동',
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () {
                    Get.to(SharedTestView());
                  },
                  child: Text(
                    '로그인 또는 회원가입 이후 이동(커뮤니티)',
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                  height: 30
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildPrintUser(ServiceUser user, SharedPreferences prefs) {
    return Column(
      children: [
        Text('id: ${user.id}'),
        Text('email: ${user.email}'),
        Text('is_superuser: ${user.is_supueruser}'),
        Text('is_active: ${user.is_active}'),
        Text('is_staff: ${user.is_staff}'),
        Text('created_at: ${user.created_at}'),
        Text('updated_at: ${user.updated_at}'),
        Text('user_name: ${user.user_name}'),
        Text('profile: ${user.profile}'),

        Text('prefs access_token: ${prefs.getString('access_token')}'),
        Text('prefs refresh_token: ${prefs.getString('refresh_token')}'),
      ],
    );
  }
}


