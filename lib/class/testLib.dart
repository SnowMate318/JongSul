import 'package:jongsul/class/commonTest.dart';
import 'package:jongsul/class/test.dart';

class TestLib // TestLib 슈퍼클래스
{
  String _testLibID = "";
  String _libTitle = "";
  DateTime _lastLibAccess = DateTime.now();

  String get getLibTitle => _libTitle;
  DateTime get getLastLibAccess => _lastLibAccess;

  TestLib(String testLibID, String libTitle)
  {
    _testLibID = testLibID;
    _libTitle = libTitle;
  }

  //@ 라이브러리 접근
  void libAccess()
  {
    _lastLibAccess = DateTime.now();
  }

  //@ 라이브러리 이름 변경
  void setTitle(String newLibTitle)
  {
    _libTitle = newLibTitle;
  }

}