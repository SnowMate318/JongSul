import 'package:flutter/material.dart';
import 'package:jongsul/models/shared/shared.dart';
import 'package:jongsul/models/shared/shared_tag.dart';
import 'package:jongsul/models/shared/shared_data.dart';
import 'package:get/get.dart';

class SharedTestView extends StatefulWidget {
  const SharedTestView({super.key});

  @override
  State<SharedTestView> createState() => _SharedTestViewState();
}

class _SharedTestViewState extends State<SharedTestView> {

  List<Shared> shareds = [];
  List<List<SharedTag>> sharedTags = [];
  @override
  void initState() {
    initCommunity();
    super.initState();
  }

  initCommunity() async {
    shareds = await getSharedList();
    for (int i=0;i<shareds.length;i++){
      sharedTags.add(shareds[i].sharedTags);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('커뮤니티'),
                  _buildCommunity(),
                ],
              ),
            )
          )
      ),
    );
  }
  Widget _buildCommunity(){
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: shareds.length,
        itemBuilder: (context, index){
          return Card(
              child: Column(
                children: [
                  Text(shareds[index].userName),
                  Text(shareds[index].userProfile),
                  Text(shareds[index].sharedTitle),
                  Text(shareds[index].sharedContent),
                  Text(shareds[index].sharedUploadDatetime),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('다운로드 수: ${shareds[index].downloadCount.toString()}'),
                      TextButton(
                          onPressed: ()async{
                            await downloadShared(shareds[index].id, shareds[index].sharedTitle);
                            initCommunity();
                            },
                          child: Text('다운로드')
                      ),

                    ],
                  ),
                  _buildTagList(shareds[index]),
                ],
              )
          );
        },
      ),
    );
  }
  Widget _buildTagList(Shared shared){
    return Wrap(
      children: shared.sharedTags.map((tag) => _buildTag(tag.name)).toList(),
    );
  }
  Widget _buildTag(String tagTitle){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InputChip(
        label: Text(tagTitle),
        backgroundColor: Color(0xFFFFDCBE),
      ),
    );
  }
}
