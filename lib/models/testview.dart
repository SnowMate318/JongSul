import 'package:flutter/material.dart';
import 'package:jongsul/models/shared_testview.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
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
  void handleSignUp(String email, String password) async {
    var newUser = await signUp(email, password);
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


