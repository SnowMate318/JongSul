import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library_data.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/directory/directory.dart';
import 'package:jongsul/models/directory/directory_data.dart';
import 'package:jongsul/models/question/question.dart';
import 'package:get/get.dart';
import 'package:jongsul/models/question_testview.dart';
class DirectoryTestView extends StatefulWidget {
  Library library;

  DirectoryTestView({required this.library, super.key});

  @override
  State<DirectoryTestView> createState() => _DirectoryTestViewState();
}

class _DirectoryTestViewState extends State<DirectoryTestView> {

  List<Directory> directoryList = [];

  @override
  void initState() {
    initDirectories();
    super.initState();
  }

  initDirectories() async {
    directoryList = await getDirectoryList(widget.library.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              Text('라이브러리 이름: ${widget.library.title}'),

              SizedBox(
                height: 20,
              ),
              Text('라이브러리 아이디: ${widget.library.id}'),
              SizedBox(
                height: 20,
              ),
              _buildDirectoryList(),

            ]),
          ),
        ),
      ),
    );
  }
  Widget _buildDirectoryList() {
    List<TextEditingController> _titleControllerList = [];
    List<TextEditingController> _conceptControllerList = [];
    for (int i = 0; i < directoryList.length; i++) {
      _titleControllerList.add(TextEditingController());
      _conceptControllerList.add(TextEditingController());
    }
    return Column(

      children: [
        Text('디렉토리 리스트'),
        SizedBox(
          height: 20,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: directoryList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text('디렉토리 아이디: ${directoryList[index].id}'),
                SizedBox(
                  height: 10,
                ),
                Text('디렉토리 이름: ${directoryList[index].title}'),

                Text('디렉토리 설명: ${directoryList[index].concept}'),
                SizedBox(
                  height: 10,
                ),
                TextButton(onPressed: ()async{
                  Get.to(QuestionTestView(directory: directoryList[index]));

                }, child: Text("문제 풀어보기")),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _titleControllerList[index],
                  decoration: InputDecoration(
                    labelText: '수정할 디렉토리 이름',
                  ),
                  validator: (value) {
                    //유저이름 형식 체크 (1자리 이상) -> 이런 형태가 안나오면 에러
                    if (value!.isEmpty) {
                      return '디렉토리 제목 입력해줘';
                    }
                    if(directoryList.any((library) => library.title == value)) {
                      return '이미 존재하는 디렉토리';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _conceptControllerList[index],
                  decoration: InputDecoration(
                    labelText: '수정할 디렉토리 설명',
                  ),

                ),
                TextButton(onPressed: ()async{
                  await patchDirectory(directoryList[index].id, _titleControllerList[index].text, _conceptControllerList[index].text);
                  await initDirectories();

                }, child: Text("디렉토리 수정")),
                TextButton(onPressed: ()async{
                  await deleteDirectory(directoryList[index].id);
                  await initDirectories();

                }, child: Text("디렉토리 삭제")),


              ],
            );
          },
        ),
      ],
    );
  }

}
