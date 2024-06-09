// import 'package:flutter/material.dart';
// import 'package:jongsul/screen/widget/menu_bar.dart';
// import 'package:jongsul/screen/widget/community_post.dart';
// import 'package:jongsul/screen/widget/profile.dart';
// import 'package:jongsul/screen/widget/tag.dart';
// import 'package:jongsul/screen/3_community_screen/search_screen.dart';
// import 'package:jongsul/tools/color.dart';
// import 'package:jongsul/class/uploadedTest.dart';
// import 'package:jongsul/tools/style.dart';
//
// class CommunityProfileScreen extends StatefulWidget {
//   const CommunityProfileScreen({super.key});
//
//   @override
//   State<CommunityProfileScreen> createState() => _CommunityProfileScreenState();
// }
//
// class _CommunityProfileScreenState extends State<CommunityProfileScreen> {
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("커뮤니티"),
//         shape: const Border(
//           bottom: BorderSide(
//             color: outlineVariant,
//             width: 1,
//           ),
//         ),
//       ),
//       bottomNavigationBar: DownMenuBar(),
//       body: SafeArea(
//         child: Container(
//           height: 40,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: BoxDecoration(),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: const ShapeDecoration(
//                         color: Color(0xFF8B5000),
//                         shape: OvalBorder(),
//                       ),
//                     ),
//                     // SizedBox(
//                     //   width: 40,
//                     //   height: 40,
//                     //   child:
//                     // ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Container(
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         child: Text(
//                           nickName,
//                           style: TextStyle(
//                             color: Color(0xFF201B16),
//                             fontSize: 16,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             height: 0.09,
//                             letterSpacing: 0.15,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//         ),
//       ),
//     );
//   }
// }