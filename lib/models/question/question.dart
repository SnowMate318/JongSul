import 'choice.dart';

class Question {
  int id;
  int question_num;
  List<Choice> choices;
  String question_title;
  List<String> question_content;
  String question_answer;

  String question_explanation;

  int question_type;
  bool is_scrapped;

// Library.init()
//     : title = '',
//       library_last_access = '',
//       is_deleted = false,

  Question.init({
    this.id = -1,
    this.choices = const [],
    this.question_num = 1,
    this.question_title = '',
    this.question_content = const [],
    this.question_answer = '',
    this.question_explanation = '',
    this.question_type = 1,
    this.is_scrapped = false,
  });

  Question.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? -1,
        choices = (map['choices'] as List<dynamic>?)
                ?.map((choice) => Choice.fromMap(choice))
                ?.toList() ??
            [],
        // Choice 리스트 변환
        question_num = map['question_num'] ?? 1,
        question_title = map['question_title'] ?? '',
        question_content = (map['question_content'] as List<dynamic>?)
                ?.map((content) => content as String)
                ?.toList() ??
            [],
        question_answer = map['question_answer'] ?? '',
        question_explanation = map['question_explanation'] ?? '',
        question_type = map['question_type'] ?? 1,
        is_scrapped = map['is_scrapped'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'choices': choices.map((choice) => choice.toJson()).toList(),
      // Choice 리스트를 JSON으로 변환
      'question_num': question_num,
      'question_title': question_title,
      'question_content': question_content,
      'question_answer': question_answer,
      'question_explanation': question_explanation,
      'question_type': question_type,
      'is_scrapped': is_scrapped,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    id = map['id'] ?? id;
    choices = (map['choices'] as List<dynamic>?)
            ?.map((choice) => Choice.fromMap(choice))
            ?.toList() ??
        []; // Choice 리스트 변환
    question_num = map['question_num'] ?? question_num;
    question_title = map['question_title'] ?? question_title;
    question_content = (map['question_content'] as List<dynamic>?)
            ?.map((content) => content as String)
            ?.toList() ??
        [];
    question_answer = map['question_answer'] ?? question_answer;
    question_explanation = map['question_explanation'] ?? question_explanation;
    question_type = map['question_type'] ?? question_type;
    is_scrapped = map['is_scrapped'] ?? is_scrapped;
  }
}
