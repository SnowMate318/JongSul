import 'package:flutter/material.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _key = GlobalKey<ExpandableFabState>();

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
        child: SingleChildScrollView(child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '스크랩한 문제들',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("전체보기"),
                        Icon(Icons.chevron_right, size: 18),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: false,
                viewportFraction: 0.45,
                reverse: true,
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //width:
                                // MediaQuery
                                //     .of(context)
                                //     .size
                                //     .width,
                                //width: 30,
                                padding: const EdgeInsets.all(12),

                                child: Text("1. 과목",
                                    style: const TextStyle(fontSize: 20)),
                              ),
                              Icon(Icons.more_vert),
                            ]),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('문제 개수: 15'),
                              Text('오답률: 0%'),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // TextButton(
                                  //   onPressed: () {},
                                  //   child: const Text("Details"),
                                  // ),
                                  FilledButton.tonal(
                                    onPressed: () {},
                                    child: const Text("시작하기"),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    );
                    // return Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.amber
                    //     ),
                    // );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),

            ///////////////////////////////////////////////
            Padding(
              padding: EdgeInsetsDirectional.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '스크랩한 문제들',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("전체보기"),
                        Icon(Icons.chevron_right, size: 18),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: false,
                viewportFraction: 0.45,
                reverse: true,
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //width:
                                // MediaQuery
                                //     .of(context)
                                //     .size
                                //     .width,
                                //width: 30,
                                padding: const EdgeInsets.all(12),

                                child: Text("1. 과목",
                                    style: const TextStyle(fontSize: 20)),
                              ),
                              Icon(Icons.more_vert),
                            ]),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('문제 개수: 15'),
                              Text('오답률: 0%'),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // TextButton(
                                  //   onPressed: () {},
                                  //   child: const Text("Details"),
                                  // ),
                                  FilledButton.tonal(
                                    onPressed: () {},
                                    child: const Text("시작하기"),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    );
                    // return Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.amber
                    //     ),
                    // );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
            ////////////////////////////////////////////////////////////
            Padding(
              padding: EdgeInsetsDirectional.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '스크랩한 문제들',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("전체보기"),
                        Icon(Icons.chevron_right, size: 18),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: false,
                viewportFraction: 0.45,
                reverse: true,
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //width:
                                // MediaQuery
                                //     .of(context)
                                //     .size
                                //     .width,
                                //width: 30,
                                padding: const EdgeInsets.all(12),

                                child: Text("1. 과목",
                                    style: const TextStyle(fontSize: 20)),
                              ),
                              Icon(Icons.more_vert),
                            ]),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('문제 개수: 15'),
                              Text('오답률: 0%'),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // TextButton(
                                  //   onPressed: () {},
                                  //   child: const Text("Details"),
                                  // ),
                                  FilledButton.tonal(
                                    onPressed: () {},
                                    child: const Text("시작하기"),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    );
                    // return Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.amber
                    //     ),
                    // );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              color: Color(0xFFD5C3B5),
              height: 1,
            ),
          ],
        ),),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showFloating();
      //   },
      //   child: const Icon(Icons.add),
      // ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(0.5),
        ),
        distance: 70.0,
        //childrenOffset: const Offset(0, 0),

        children: [
          FloatingActionButton.small(
            child: const Icon(Icons.edit),
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.file_open),
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.photo_camera),
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget showFloating() {
  return Column(
    children: [
      ElevatedButton(
        //icon: Icon(Icons.download, size: 18),
        child: Text("수정 완료"),
        onPressed: () {
          // Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => CommunitySearch()),
          //       );
        },
      ),
      ElevatedButton(
        //icon: Icon(Icons.camera, size: 18),
        child: Text("수정 완료"),
        onPressed: () {
          // Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => CommunitySearch()),
          //       );
        },
      ),
      ElevatedButton(
        //icon: Icon(Icons.person, size: 18),
        child: Text("수정 완료"),
        onPressed: () {
          // Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => CommunitySearch()),
          //       );
        },
      )
    ],
  );
}
