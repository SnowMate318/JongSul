import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/screen/3_community_screen/search_screen.dart';
import 'package:jongsul/tools/color.dart';
import 'package:jongsul/models/shared/shared.dart';
import 'package:jongsul/tools/style.dart';

import '../../models/shared/shared_data.dart';
import '../../models/shared/shared_tag.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Shared> shareds = [];
  List<List<SharedTag>> sharedTags = [];

  @override
  void initState() {
    initCommunity();
    super.initState();
  }

  initCommunity() async {
    shareds = await getSharedList();
    for (int i = 0; i < shareds.length; i++) {
      sharedTags.add(shareds[i].sharedTags);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("커뮤니티"),
        shape: const Border(
          bottom: BorderSide(
            color: outlineVariant,
            width: 1,
          ),
        ),
      ),
      bottomNavigationBar: DownMenuBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         _buildTag1("전자공학부"),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         _buildTag1("태그"),
              //       ],
              //     ),
              //     _buildFilter(),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              _buildPosts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag1(String tagTitle) {
    return InputChip(
      label: Text(tagTitle),
      labelStyle: labelTextStyle,
      backgroundColor: Color(0xFFFFDCBE),
      onDeleted: () {
        debugPrint("input chip deleted");
      },
    );
  }

  Widget _buildFilter() {
    return IconButton(
      // 눌렀을 때 밑에서 위로 올라오는 걸로 변경
      iconSize: 30,
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CommunitySearch()),
        );
      },
    );
  }

  Widget _buildPosts() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: shareds.length, // API에서 받아오는 개수로 바꿔주 기
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Container(
                  width: MediaQuery.of(context).size.width < 360
                      ? MediaQuery.of(context).size.width
                      : 360,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: 400,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: surface, // 왜 적용이 안되지??
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => Container(
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
                      //                   ],
                      //                 ),
                      //               ),
                      //               const SizedBox(width: 16),
                      //               Expanded(
                      //                 child: Container(
                      //                   child: const Column(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     mainAxisAlignment:
                      //                     MainAxisAlignment.start,
                      //                     crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                     children: [
                      //                       SizedBox(
                      //                         width: double.infinity,
                      //                         child: Text(
                      //                           '글자',
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
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   child:
                      Row(
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
                            shareds[index].userName,
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
                      // ),
                      // const Flexible(
                      //   fit: FlexFit.tight,
                      //   flex: 4,
                      //   child: SizedBox(),
                      // ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      shareds[index].sharedTitle,
                                      style: const TextStyle(
                                        color: Color(0xFF201B16),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
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
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          '${shareds[index].downloadCount.toString()}',
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
                                  shareds[index].sharedContent,
                                  style: const TextStyle(
                                    color: Color(0xFF51453A),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.25,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTagList(shareds[index]),
                                ElevatedButton(
                                  onPressed: () async {
                                    await downloadShared(
                                      shareds[index].id,
                                      shareds[index].sharedTitle,
                                    );
                                    initCommunity();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_download,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '다운로드',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }

  // String tagString = '';
  // Widget _buildTagList(Shared shared) {
  //   tagString = shared.sharedTags.map((tag) => '#$tag').join(', ')
  //   return Wrap(
  //       children: Text(tagString)
  //   );
  // }
  Widget _buildTagList(Shared shared) {
    return Wrap(
      children: shared.sharedTags.map((tag) => _buildTag(tag.name)).toList(),
    );
  }

  Widget _buildTag(String tagTitle) {
    return Text(
      '#$tagTitle ',
      style: TextStyle(color: Colors.grey),
    );
    //   Padding(
    //   padding: const EdgeInsets.all(4.0),
    //   child: InputChip(
    //     label: Text(tagTitle),
    //     backgroundColor: Color(0xFFFFDCBE),
    //   ),
    // );
  }
}
