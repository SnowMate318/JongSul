class Choice {
  int choiceNum;
  String choiceContent;

// Library.init()
//     : title = '',
//       library_last_access = '',
//       is_deleted = false,

  Choice.init({
    this.choiceNum = 1,
    this.choiceContent = '',
  });

  Choice.fromMap(Map<String, dynamic> map)
      : choiceNum = map['choice_num'] ?? 1,
        choiceContent = map['choice_content'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'choice_num': choiceNum,
      'choice_content': choiceContent,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    choiceNum = map['choice_num'] ?? choiceNum;
    choiceContent = map['choice_content'] ?? choiceContent;
  }
}
