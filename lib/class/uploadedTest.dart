import 'package:jongsul/class/problem.dart';
import 'package:jongsul/class/test.dart';

class UploadedTest // 게시글을 살짝 다른 형태로 표현
{
  String _uploadTestID = "";
  String _uploaderName = ""; // 업로더의 이름 또는 닉네임
  String _uploaderPicURL = ""; // 업로더의 프로필사진 연결 URL
  String _description = ""; // 공유 문제에 대한 설명
  DateTime _uploadedDateTime = DateTime.now(); // 업로드 일자
  List<String> _tags= []; //태그정보
  int _downloadNum = 0; // 다운로드 횟수
  late Test _uploadedTest; // 업로드하는 테스트 정보

  String get getName => _uploaderName; // 사용자 닉네임 반환
  String get getPicURL => _uploaderPicURL; // 사용자 프로필 URL 반환
  String get getDescription => _description; // 설명 반환
  DateTime get getUploadedDateTime => _uploadedDateTime; //업로드 데이트타임 반환
  int get getDownloadNum => _downloadNum; // 다운로드 횟수 반환
  List<String> get tag => _tags; // 태그 반환
  Test get getUploadedTest => _uploadedTest; // 업로드된 테스트 정보 반환

  UploadedTest(String uploadTestID, String uploaderName, String uploaderPicURL, Test uploadedTest)
  {
    _uploadTestID = uploadTestID;
    _uploaderName = uploaderName;
    _uploaderPicURL = uploaderPicURL;
    _uploadedTest = uploadedTest;
  }

  //@ 태그 추가
  void addTag(String tag)
  {
    _tags.add(tag);
  }

  //@ 태그 삭제
  void deleteTag(int index)
  {
    _tags.removeAt(index);
  }

  //@ 설명 변경
  void setDescription(String newDescription)
  {
    _description = newDescription;
  }
  //@ 다운로드
  void download()
  {
    _downloadNum++;
    //Todo: 다운로드 로직 구현(여기 말고 다른곳에 구현해야 할 수도 있음)
  }

  //Todo: 로그인한 사용자의 문제풀이 유무에 대한 내용

}