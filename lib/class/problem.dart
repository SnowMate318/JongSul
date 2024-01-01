//category num
//1: 객관식, 2: ox, 3: 단답형

class Problem
{
  String _testId = ""; // 문제 id
  String _title = ""; // 문제 이름
  int _category = 0; // 카테고리(1: 객관식, 2: ox, 3: 단답형)
  List<String>? _options = []; // 선택지 (null 허용)
  bool _isScrap = false; // 스크랩 여부
  bool? _lastSuccess; // 지난번 문제풀이 여부 (null 허용)
  String _answer = ""; // 정답
  String _commentary = ""; // 해설

  String get getTitle => _title; // 문제이름 반환
  List<String> get getOptions => _options!;//선택지 반환(선택지가 null 경우 오류남)
  bool get getIsScrap => _isScrap;//스크랩 여부 반환
  bool get getLastSuccess => _lastSuccess!;//지난번 문제풀이 여부 출력(null 경우 오류남)
  String get getAnswer => _answer;//정답 출력
  String get commentary => _commentary;//해설 출력

  Problem(String testId, String title, int category, List<String>? options, String answer, String commentary)// Test 클래스 생성자
  {
    try {
      if(category != 1 || category != 2 || category != 3){ // 카테고리 번호가 1, 2, 3이 아닐 경우 오류
        throw "카테고리 번호 오류";
      }
      if(category==1 && options==null){ // 객관식 문제에 선택지가 없을 경우 오류
        throw "선택지 누락 오류";
      }
      if((category==2 || category == 3) && options!=null){ // 객관식 문제가 아닌데 선택지가 있을 경우 오류
        throw "선택지 기입 오류";
      }

      _testId = testId;
      _title = title;
      _category = category;
      _options = options;
      _answer = answer;
      _commentary = commentary;

    }catch (e){
      print("Test 생성자 오류 발생 $e");

    }
  }

  //@문제 제목 변경
  void setTitle(String title)
  {
    _title = title;
  }
  //@선택지 변경
  void setOption(int optionIndex, String newOption)
  {
    _options![optionIndex] = newOption;
  }
  //@스크랩
  void scrapProblem()
  {
    _isScrap = true;
  }
  //@스크랩 취소
  void unScrapProblem()
  {
    _isScrap = false;
  }
  //@ 정답 골랐을 때
  void correctProblem()
  {
    _lastSuccess = true;
  }

  //@오답 골랐을 때

  void failProblem()
  {
    _lastSuccess = false;
  }

  //Todo: 더 필요할 것 같은 메서드 있으면 추가하기(답 변경, 해설 변경 등등)



}