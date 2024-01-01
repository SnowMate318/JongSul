import 'package:flutter/material.dart';
import 'package:jongsul/screen/comunity_screen.dart';
import 'package:jongsul/screen/generate_problem_screen.dart';
import 'package:jongsul/screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:jongsul/screen/lib_screen.dart';
import 'package:jongsul/screen/login_screen.dart';
import 'package:jongsul/screen/profile_screen.dart';
import 'package:jongsul/screen/solve_problem_screen.dart';
import 'package:jongsul/screen/update_problem_screen.dart';
import 'package:jongsul/screen/upload_problem_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [ // 스크린 지정
        GetPage(
          name: '/',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/comunity',
          page: () => ComunityScreen(),
        ),
        GetPage(
          name: '/generateProblem',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/library',
          page: () => GenerateProblemScreen(),
        ),
        GetPage(
          name: '/login',
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

      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
