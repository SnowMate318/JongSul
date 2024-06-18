import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library_data.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/directory_testview.dart';

import 'package:get/get.dart';
import 'package:jongsul/models/question_testview.dart';

import 'directory/mini_directory.dart';

class LibraryTestView extends StatefulWidget {
  const LibraryTestView({super.key});

  @override
  State<LibraryTestView> createState() => _TestView2State();
}

class _TestView2State extends State<LibraryTestView> {
  List<Library> libraryList = [];
  Library currentLibrary = Library.init();
  @override
  void initState() {
    // TODO: implement initState
    initLibraryList();
    super.initState();
  }

  initLibraryList() async{
    libraryList = await getLibraryList();
    setState(() {});
  }

  final TextEditingController _addTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //스크롤 가능한 뷰
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        )
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text("라이브러리 상세보기"),
                _buildDetailLibrary(),
                TextButton(onPressed: (){
                 // Get.to(DirectoryTestView(library: currentLibrary));
                }, child: Text('디렉토리 화면 보기')),
                SizedBox(height: 30),
                Text("라이브러리 리스트"),
                SizedBox(height: 20),
                SizedBox(
                  height: 400,
                  child: _buildLibraryList(libraryList),

                ),
                SizedBox(height: 30),
                Text('-'*50),
                SizedBox(height: 30),
                Text('라이브러리 추가'),
                TextFormField(
                  controller: _addTitleController,
                  decoration: InputDecoration(
                    labelText: 'title',
                  ),
                  validator: (value) {
                    //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                    if (value!.isEmpty) {
                      return '타이틀 입력해줘';
                    }
                    if(libraryList.any((library) => library.title == value)) {
                      return '이미 존재하는 타이틀';
                    }
                    return null;
                  },
                ),
                TextButton(onPressed: ()async{
                  await addLibrary(_addTitleController.text);
                  await initLibraryList();
                  setState(() {

                  });
                  }, child: Text('라이브러리 추가하기'))
              ],
            ),
          )
      ),
    );
  }

  //라이브러리 상세보기
  Widget _buildDetailLibrary(){
    return Column(
      children: [
        Text(currentLibrary.title),
        Text(currentLibrary.library_last_access),

      ],
    );
  }

  Widget _buildDirectoryList(List<MiniDirectory> miniDirectories){
    return ListView.builder(
      itemCount: miniDirectories.length,
      itemBuilder: (context, index){
        return Card(
          child: Column(
            children: [
              Text(miniDirectories[index].id.toString()),
              Text(miniDirectories[index].title),
              Text(miniDirectories[index].concept),
              Text(miniDirectories[index].directoryLastAccess),
              TextButton(
                  onPressed: () async {
                    Get.to(QuestionTestView(directoryId: miniDirectories[index].id, directoryTitle: miniDirectories[index].title));
                  },
                  child: Text("문제 풀어보기")),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
  List<TextEditingController> _titleControllerList = [];

  //라이브러리 리스트
  Widget _buildLibraryList(List<Library> libraryList){
    for(int i = 0; i < libraryList.length; i++){
      _titleControllerList.add(TextEditingController());
    }
    return ListView.builder(
      itemCount: libraryList.length,
      itemBuilder: (context, index){
        return Column(
          children: [
            Text(libraryList[index].title),
            Text(libraryList[index].library_last_access),
            SizedBox(height: 300, child: _buildDirectoryList(libraryList[index].miniDirectories)),
            SizedBox(height: 10),
            TextButton(
                onPressed: ()async{
                  //라이브러리 상세보기
                  currentLibrary = await getLibrary(libraryList[index].id);
                  setState(() {});
                  //Get.to(DirectoryPage(library: currentLibrary,));
                },
                child: Text('상세보기')
            ),
            SizedBox(height: 10),
            Text("제목 수정"),
            TextFormField(
              controller: _titleControllerList[index],
              decoration: InputDecoration(
                labelText: 'title',
              ),
              validator: (value) {
                //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                if (value!.isEmpty) {
                  return '타이틀 입력해줘';
                }
                if(libraryList.any((library) => library.title == value)) {
                  return '이미 존재하는 타이틀';
                }
                return null;
              },
            ),
            TextButton(
                onPressed: ()async{
                  //라이브러리 상세보기
                  await patchLibrary(libraryList[index].id, _titleControllerList[index].text);
                  await initLibraryList();
                  setState(() {

                  });
                },
                child: Text('수정하기')
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: ()async{
                  //라이브러리 삭제
                  await deleteLibrary(libraryList[index].id);
                  await initLibraryList();
                  setState(() {});
                },
                child: Text('삭제하기'),
            ),
          ],
        );
      },
    );
  }
}



