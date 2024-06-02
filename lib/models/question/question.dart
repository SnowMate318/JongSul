import 'choice.dart';

class Question {
  int id;
  int questionNum;
  List<Choice> choices;
  String questionTitle;
  String questionContent;
  String questionAnswer;

  String questionExplanation;

  int questionType;
  bool isScrapped;
  bool lastSolved = false;

// Library.init()
//     : title = '',
//       library_last_access = '',
//       is_deleted = false,

  Question.init({
    this.id = 0,
    this.choices = const [],
    this.questionNum = 0,
    this.questionTitle = '',
    this.questionContent = '',
    this.questionAnswer = '',
    this.questionExplanation = '',
    this.questionType = 0,
    this.isScrapped = false,
    this.lastSolved = false,
  });

  Question.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? -1,
        choices = (map['choices'] as List<dynamic>?)
                ?.map((choice) => Choice.fromMap(choice))
                ?.toList() ??
            [],
        // Choice 리스트 변환
        questionNum = map['question_num'] ?? 1,
        questionTitle = map['question_title'] ?? '',
        questionContent = map['question_content'] ?? '',
        questionAnswer = map['question_answer'] ?? '',
        questionExplanation = map['question_explanation'] ?? '',
        questionType = map['question_type'] ?? 1,
        isScrapped = map['is_scrapped'] ?? false,
        lastSolved = map['last_solved'] ?? false;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'choices': choices.map((choice) => choice.toJson()).toList(),
      // Choice 리스트를 JSON으로 변환
      'question_num': questionNum,
      'question_title': questionTitle,
      'question_content': questionContent,
      'question_answer': questionAnswer,
      'question_explanation': questionExplanation,
      'question_type': questionType,
      'is_scrapped': isScrapped,
      'last_solved': lastSolved,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    id = map['id'] ?? id;
    choices = (map['choices'] as List<dynamic>?)
            ?.map((choice) => Choice.fromMap(choice))
            ?.toList() ??
        []; // Choice 리스트 변환
    questionNum = map['question_num'] ?? questionNum;
    questionTitle = map['question_title'] ?? questionTitle;
    questionContent = map['question_content'] ?? questionContent;
    questionAnswer = map['question_answer'] ?? questionAnswer;
    questionExplanation = map['question_explanation'] ?? questionExplanation;
    questionType = map['question_type'] ?? questionType;
    isScrapped = map['is_scrapped'] ?? isScrapped;
    lastSolved = map['last_solved'] ?? lastSolved;
  }
}
