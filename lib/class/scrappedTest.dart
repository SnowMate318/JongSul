import 'package:jongsul/class/problem.dart';
import 'package:jongsul/class/test.dart';

class ScrappedTest extends Test
{

  ScrappedTest(String testDirID, String title, List<Problem> tests) : super(testDirID,"스크랩" ,title, tests); // 기존 Test와 다를게 없(가독성을 위해 나눔)

}