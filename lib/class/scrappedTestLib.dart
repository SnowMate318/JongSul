import 'package:jongsul/class/scrappedTest.dart';
import 'package:jongsul/class/testLib.dart';
import 'package:jongsul/class/commonTest.dart';

class ScrappedTestLib extends TestLib
{
  List<ScrappedTest> _tests= [];
  ScrappedTestLib(String testLibID, String libTitle) : super(testLibID, libTitle);

  //@ 라이브러리에 테스트 추가
  void addScrappedTest(ScrappedTest test)
  {
    _tests.add(test);
  }

  //@ 라이브러리에 테스트 작세
  void deleteScrappedTest(int index)
  {
    _tests.removeAt(index);
  }


}