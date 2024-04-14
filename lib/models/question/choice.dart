class Choice {
  int choice_num;
  String choice_content;

// Library.init()
//     : title = '',
//       library_last_access = '',
//       is_deleted = false,

  Choice.init({
    this.choice_num = 1,
    this.choice_content = '',
  });

  Choice.fromMap(Map<String, dynamic> map)
      : choice_num = map['choice_num'] ?? 1,
        choice_content = map['choice_content'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'choice_num': choice_num,
      'choice_content': choice_content,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    choice_num = map['choice_num'] ?? choice_num;
    choice_content = map['choice_content'] ?? choice_content;
  }
}
