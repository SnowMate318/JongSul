import 'package:flutter/material.dart';
import 'package:jongsul/models/testview.dart';
import 'package:jongsul/screen/1_main_screen/home_screen.dart';
import 'package:jongsul/screen/3_community_screen/community_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/generate_problem_screen.dart';
import 'package:jongsul/screen/1_main_screen/home1_screen.dart';
import 'package:get/get.dart';
import 'package:jongsul/screen/2_lib_screen/lib_screen.dart';
import 'package:jongsul/screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/screen/4_profile_screen/profile_screen.dart';
import 'package:jongsul/screen/7_solve_problem_screen/solve_problem_screen.dart';
import 'package:jongsul/screen/5_generate_problem_screen/update_problem_screen.dart';
import 'package:jongsul/screen/6_upload_ploblem_screen/upload_problem_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),

      ),
      getPages: [ // 스크린 지정
        GetPage(
          name: '/',
          page: () => Home1Screen(),
        ),
        GetPage(
          name: '/community',
          page: () => CommunityScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/generateProblem',
          page: () => GenerateProblemScreen(),
        ),
        GetPage(
          name: '/library',
          page: () => LibraryScreen(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileScreen(),
        ),
        GetPage(
          name: '/solveProblem',
          page: () => SolveProblemScreen(),
        ),
        GetPage(
          name: '/updateProblem',
          page: () => UpdateProblemScreen(),
        ),
        GetPage(
          name: '/uploadProblem',
          page: () => UploadProblemScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/testview',
          page: () => TestView(),
        ),

      ],
      title: 'Flutter Demo',
      home: const TestView(),
    );
  }
}
