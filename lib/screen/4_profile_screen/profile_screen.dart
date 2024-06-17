import 'package:flutter/material.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
import 'package:jongsul/screen/0_preliminary_screen/login_screen.dart';
import 'package:jongsul/screen/4_profile_screen/edit_information.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/screen/widget/community_post.dart';
import 'package:jongsul/screen/widget/profile.dart';
import 'package:jongsul/screen/widget/tag.dart';
import 'package:jongsul/screen/3_community_screen/search_screen.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/class/uploadedTest.dart';
import 'package:jongsul/tools/style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 정보"),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),
      ),
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditInformation(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '내 정보 수정',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
            TextButton(
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '내가 올린 문제',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
            TextButton(
              onPressed: () {
                handleLogoutServiceUser();
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '로그아웃',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
          ],
        ),
        //child: Profile(),
      ),
    );
  }

  void handleLogoutServiceUser() async {
    bool tmp = await logout();
  }
}
