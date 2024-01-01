import 'package:jongsul/class/problem.dart';
import 'package:jongsul/class/test.dart';

class CommonTest extends Test // Test 폴더
{
  String _concept = "";
  String get getConcept => _concept;


  CommonTest(String id, String libName, String title, String concept, List<Problem> tests) : super(id, libName, title, tests)
  {
    _concept = concept;
  }

}