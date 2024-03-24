import 'package:flutter/material.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/screen/widget/communityPost.dart';
import 'package:jongsul/screen/widget/profile.dart';
import 'package:jongsul/screen/widget/tag.dart';
import 'package:jongsul/screen/3_community_screen/search_screen.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/src/app.dart';
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
        child: Profile(),
      ),
    );
  }
}
