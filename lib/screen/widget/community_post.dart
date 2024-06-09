//커뮤니티에서 보이는 포스트
import 'package:flutter/material.dart';
import 'package:jongsul/models/shared/shared_data.dart';
import 'package:jongsul/screen/3_community_screen/community_profile_screen.dart';
import 'package:jongsul/screen/widget/download_button.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/models/shared/shared.dart';

Widget communityPost(BuildContext context, Shared shared) {
  String tagString = '';
  tagString = shared.sharedTags.map((tag) => '#$tag').join(', ');

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Container(
        width: MediaQuery.of(context).size.width < 360
            ? MediaQuery.of(context).size.width
            : 360,
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
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const CommunityProfileScreen()),
                // );
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
                              shared.sharedTitle,
                              //shared.shared_title,
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
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.file_download_outlined,
                                      color: Colors.black,
                                      // <--- Icon color
                                      size: 20,
                                    )),
                                Text(
                                  '${shared.downloadCount}',
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
                          shared.sharedContent,
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
                        Text(tagString,
                            style: const TextStyle(
                              color: Color(0xFF848484),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.25,
                            )),
                        ElevatedButton(
                          // onPressed: ()async{
                          //   await downloadShared(shared.id, shared.sharedTitle);
                          //   initCommunity();
                          // },
                          onPressed: () {},

                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 20),
                              SizedBox(width: 5), // 텍스트와 아이콘 사이의 간격 추가
                              Text(
                                '폴더 추가',
                                style: TextStyle(
                                  color: Colors.white, // 폰트 색상
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary, // 배경색상
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        )),
  );
}
