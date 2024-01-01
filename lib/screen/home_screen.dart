import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "JongSul"; // String형 text변수를 "JongSul"으로 지정

    return Scaffold(// 화면 반환
      appBar: AppBar(title: Text(text)),//앱바 설정 앱바 텍스트는 text변수에 저장된 "JongSul"
      body: SafeArea( //SafeArea: 화면 튀어나옴 그런것들 보호해줌
          child: Center(// 이건 중앙에 위치시킴(미관상 넣었는데 자주는 안쓰임)
              child: Column(
                children: [
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("libScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("loginScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("comunityScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("generateProblemScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("loginScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("profileScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("solveProblemScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("updateProblemScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  SizedBox(height: 40.0,),
                ],
              )
          )
      ),
    );
  }
}
