import 'package:jongsul/class/problem.dart';

class Test
{
  String _testDirID = ""; // 테스트 id
  String _libName = ""; // 이 테스트가 속한 라이브러리의 이름(구조 상 필요없다 싶으면 빼도 됨)
  String _title = ""; // 테스트 제목
  List<Problem> _test = []; // 테스트 문제들
  int _testNum = 0; // 문제갯수
  double _correctRate = 0.0; // 정답률
  DateTime _lastTestAccess = DateTime.now(); // 마지막 접근시각

  String get getTitle => _title; // 이름 반환
  List<Problem> get getTests => _test; // 시험 문제를 리스트 형태로 반환
  int get getTestNum => _testNum; // 문제 갯수 반환
  double get getCorrectRate => _correctRate;//정답률 반환
  DateTime get getLastTestAccess => _lastTestAccess;

  Test(String testDirID, String libName, String title, List<Problem> tests)//생성자
  {
    _testDirID = testDirID;
    _libName = libName;
    _title = title;
    _test = tests;
    _testNum = tests.length;

  }

  //@ 시험 문제를 시작했을 때
  void startTest()
  {
    _lastTestAccess = DateTime.now();
    //Todo: 시험 시작 시 바뀌는 것들이 더 있으면 로직 추가하기
  }
  //@ 시험 문제를 끝냈을 때
  void endTest()
  {
    int correctCount = 0;
    for(Problem pbm in _test){
      if(pbm.getLastSuccess == true){
        correctCount++;
      }
    }

    _correctRate = (_testNum/correctCount);
    //Todo: 시험 종료 시 바뀌는 것들이 더 있으면 로직 추가하기
  }
  //@ 시험 문제를 맞췄을 때
  void correct(int index)
  {
    _test[index].correctProblem();
  }
  //@ 시험 문제를 틀렸을 때
  void fail(int index)
  {
    _test[index].failProblem();
  }
  //@ 시험 문제를 스크랩하려 할 때
  void scrap(int index)
  {
    _test[index].scrapProblem();
  }
  //@ 시험 문제 스크랩을 해제하려 할 때
  void unscrap(int index)
  {
    _test[index].unScrapProblem();
  }

}