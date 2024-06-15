import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jongsul/models/library_testview.dart';
import 'package:jongsul/screen/2_lib_screen/lib_setting.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';

class Home1Screen extends StatelessWidget {
  const Home1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "JongSul"; // String형 text변수를 "JongSul"으로 지정

    return Scaffold(// 화면 반환
      appBar: AppBar(title: Text(text)),//앱바 설정 앱바 텍스트는 text변수에 저장된 "JongSul"
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea( //SafeArea: 화면 튀어나옴 그런것들 보호해줌
          child: Center(// 이건 중앙에 위치시킴(미관상 넣었는데 자주는 안쓰임)
              child: Column(
                children: [
                  // TextButton(// 텍스트 형식으로 된 버튼
                  //   child: Text("directory_testView"),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => DirectoryTestView(library: library)),
                  //     );
                  //   },
                  // ),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("testView"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/testView');//화면이동
                    },
                  ),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("LibrarySettingScreen"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LibrarySettingScreen()),
                      );
                    },
                  ),

                  // TextButton(// 텍스트 형식으로 된 버튼
                  //   child: Text("DirectoryTestView"),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => DirectoryTestView(library: library)),
                  //     );
                  //   },
                  // ),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("LibraryTestView"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LibraryTestView()),
                      );
                    },
                  ),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("libScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/library');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("loginScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/login');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("communityScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/community');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("generateProblemScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/generateProblem');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("uploadProblemScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/uploadProblem');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("profileScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/profile');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("solveProblemScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/solveProblem');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),
                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("updateProblemScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/updateProblem');//화면이동
                    },
                  ),
                  //SizedBox(height: 40.0,),

                  TextButton(// 텍스트 형식으로 된 버튼
                    child: Text("HomeScreen"),
                    onPressed: (){//버튼을 눌렀을 때
                      Get.toNamed('/home');//화면이동
                    },
                  ),
                  // TextButton(// 텍스트 형식으로 된 버튼
                  //   child: Text("상태관리"),
                  //   onPressed: (){//버튼을 눌렀을 때
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Practice()),
                  //     );
                  //   },
                  // ),

                ],
              )
          )
      ),
    );
  }
}
