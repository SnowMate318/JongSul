import 'package:flutter/material.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String idInputText='';
  String passwordInputText='';
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')), //앱바 설정 앱바 텍스트는 text변수에 저장된 "JongSul"
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text('ID:'),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 70,
                    height: 35,
                    child: TextField(
                      maxLength: 16,
                      controller: idController,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        counterText: '', //글자수 제한 표시 없앰
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('password:'),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 70,
                    height: 35,
                    child: TextField(
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
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    //icon: Icon(Icons.download, size: 18),
                    child: Text("입력", style: TextStyle(
                      color: Colors.white,
                      fontSize: 14, fontWeight: FontWeight.normal)
                    ),
                    onPressed: () {
                      setState(() {
                        idInputText = idController.text;
                        passwordInputText = passwordController.text;
                        debugPrint(idInputText);
                        debugPrint(passwordInputText);

                      });
                    },
                    style: ElevatedButton.styleFrom(

                        backgroundColor: Color(0XFF8B5000),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    )
                  ),
                  const SizedBox(width: 200),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
