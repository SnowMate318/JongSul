//커뮤니티에서 보이는 포스트
import 'package:flutter/material.dart';
import 'package:jongsul/screen/3_community_screen/community_profile_screen.dart';
import 'package:jongsul/screen/widget/download_button.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/models/shared/shared.dart';

Widget communityPost(BuildContext context, Shared shared){

  String tagString = '';
  tagString = shared.sharedTags.map((tag) => '#$tag').join(', ');


  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Container(
      width: MediaQuery.of(context).size.width < 360? MediaQuery.of(context).size.width : 360,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 520,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: surface, //왜 적용이 안되지??
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const CommunityProfileScreen()),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF8B5000),
                    shape: OvalBorder(),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  shared.userName,
                  style: const TextStyle(
                    color: Color(0xFF201B16),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                    letterSpacing: 0.15,
                  ),
                ),
              ],
            ),
          ),
          const Flexible(
            fit: FlexFit.tight,
            flex: 4,
              child: SizedBox(),
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shared.shared_title,
                            style: const TextStyle(
                              color: Color(0xFF201B16),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0.09,
                              letterSpacing: 0.50,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: (){},
                                  icon: const Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.black,
                                    // <--- Icon color
                                    size: 20,
                                  )
                              ),
                              Text(
                                '${shared.download_count}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        shared.shared_content,
                        style: const TextStyle(
                          color: Color(0xFF51453A),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.25,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          tagString,
                          style: const TextStyle(
                            color: Color(0xFF848484),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.25,
                          )),
                      DownloadButton(text: '다운로드', isIcon: true),
                    ],
                  )
                ],

              )
          ),
        ],
      )
    ),
  );
}

// class CommunityPost extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           //width: 360,
//           //height: 520,
//           width: MediaQuery.of(context).size.width < 360? MediaQuery.of(context).size.width : 360,
//           height: MediaQuery.of(context).size.height < 520? MediaQuery.of(context).size.height : 520,
//           //카드 전체 크기 결정
//           clipBehavior: Clip.antiAlias,
//           decoration: ShapeDecoration(
//             color: surface, //왜 적용이 안되지??
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   color: Color(0xFFFDF2EA),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 72,
//                         padding: const EdgeInsets.only(
//                           top: 12,
//                           left: 16,
//                           right: 4,
//                           bottom: 12,
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 height: 40,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       width: 40,
//                                       height: 40,
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: BoxDecoration(),
//                                       child: Stack(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                     CommunityProfileScreen()),
//                                               );
//                                             },
//                                             child: Container(
//                                               width: 40,
//                                               height: 40,
//                                               decoration: const ShapeDecoration(
//                                                 color: Color(0xFF8B5000),
//                                                 shape: OvalBorder(),
//                                               ),
//                                             ),
//                                           ),
//                                           // SizedBox(
//                                           //   width: 40,
//                                           //   height: 40,
//                                           //   child:
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16),
//                                     Expanded(
//                                       child: Container(
//                                         child: const Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: Text(
//                                                 'Snowmate28',
//                                                 style: TextStyle(
//                                                   color: Color(0xFF201B16),
//                                                   fontSize: 16,
//                                                   fontFamily: 'Roboto',
//                                                   fontWeight: FontWeight.w500,
//                                                   height: 0.09,
//                                                   letterSpacing: 0.15,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         //여기에 나중에 이미지 넣기
//                         width: 360,
//                         height: 188,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 360,
//                               height: 188,
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                       "https://via.placeholder.com/360x188"),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 250, //이미지 밑부분 전체 크기
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: double.infinity,
//                               // height: 44,
//                               child: const Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ListTile(
//                                     title: Text(
//                                       '디지털 시스템 설계',
//                                       style: TextStyle(
//                                         color: Color(0xFF201B16),
//                                         fontSize: 16,
//                                         fontFamily: 'Roboto',
//                                         fontWeight: FontWeight.w400,
//                                         height: 0.09,
//                                         letterSpacing: 0.50,
//                                       ),
//                                     ),
//                                     subtitle: Text(
//                                       '제 3장',
//                                       style: TextStyle(
//                                         color: Color(0xFF51453A),
//                                         fontSize: 14,
//                                         fontFamily: 'Roboto',
//                                         fontWeight: FontWeight.w400,
//                                         height: 0.10,
//                                         letterSpacing: 0.25,
//                                       ),
//                                     ),
//                                     trailing: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(
//                                           Icons.file_download_outlined,
//                                           color: Colors.black,
//                                           // <--- Icon color
//                                           size: 20,
//                                         ),
//                                         Text(
//                                           "243",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15,
//                                         ),
//                                         Icon(
//                                           Icons.share,
//                                           color: Colors.black,
//                                           // <--- Icon color
//                                           size: 15,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 32),
//                             const SizedBox(
//                               width: double.infinity,
//                               child: Text(
//                                 '디지털 시스템 설계 교과목의 제 3장과 관련된 문제들을 정리하였습니다.',
//                                 style: TextStyle(
//                                   color: Color(0xFF51453A),
//                                   fontSize: 14,
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.w400,
//                                   letterSpacing: 0.25,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 32),
//                             Container(
//                               width: double.infinity,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("# 전자공학부",
//                                       style: TextStyle(
//                                         color: Color(0xFF848484),
//                                         fontSize: 14,
//                                         fontFamily: 'Roboto',
//                                         fontWeight: FontWeight.w400,
//                                         letterSpacing: 0.25,
//                                       )),
//                                   DownloadButton(text: '다운로드', isIcon: true),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
