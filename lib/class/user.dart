import 'package:jongsul/class/scrappedTest.dart';
import 'package:jongsul/class/testLib.dart';
import 'package:jongsul/class/uploadedTest.dart';

class User // User 클래스
{
  String _uid = ""; // 사용자의 UID
  String _name = ""; // 사용자 이름 또는 닉네임
  String _picURL = ""; // 사용자의 프로필사진 연결 URL

  String get getName => _name; // 사용자 닉네임 반환
  String get getPicURL => _picURL; // 사용자 프로필 URL 반환

  User(String uid, String name, String? picURL)//User 클래스 생성자
  {
    _uid = uid;
    _name = name;

    //Todo: 유저 데이터베이스에 URL 정보가 있으면 그 URL을 저장
    //Todo: 유저 데이터베이스에 URL 정보가 없으면 기본 이미지 URL을 저장
  }

  void setPic(String newURL) // 사용자 프로필 URL 수정(사용자 핸드폰 사진 폴더 연동 -> 사진 가져오기 후 사용)
  {
    _picURL = newURL;
  }

  void setName(String name) // 내 정보 -> 닉네임 수정
  {
    _name = name;
  }


}