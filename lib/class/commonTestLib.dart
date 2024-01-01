import 'package:jongsul/class/testLib.dart';
import 'package:jongsul/class/commonTest.dart';

class CommonTestLib extends TestLib
{
  List<CommonTest> _tests= [];
  CommonTestLib(String testLibID, String libTitle, CommonTest firstCommonTest) : super(testLibID, libTitle)
  {
    _tests.add(firstCommonTest);
  }

  //@ 라이브러리에 테스트 추가
  void addCommonTest(CommonTest test)
  {
   _tests.add(test);
  }

  //@ 라이브러리에 테스트 작세
  void deleteCommonTest(int index)
  {
    _tests.removeAt(index);
  }


}