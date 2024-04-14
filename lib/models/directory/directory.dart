class Directory {
  int last_successed;

  String concept;

  String title;
  String question_type;

  String directory_last_access;
  bool is_scrap_directory;

  bool is_deleted;

  // Library.init()
  //     : title = '',
  //       library_last_access = '',
  //       is_deleted = false,

  Directory.init({
    this.last_successed = 1,
    this.concept = '',
    this.title = '',
    this.question_type = '',
    this.directory_last_access = '',
    this.is_scrap_directory = false,
    this.is_deleted = false,
  });

  Directory.fromMap(Map<String, dynamic> map)
      : last_successed = map['last_successed'] ?? 1,
        concept = map['concept'] ?? '',
        title = map['title'] ?? '',
        question_type = map['question_type'] ?? '',
        directory_last_access = map['directory_last_access'] ?? '',
        is_scrap_directory = map['is_scrap_directory'] ?? false,
        is_deleted = map['is_deleted'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'last_successed': last_successed,
      'concept': concept,
      'title': title,
      'question_type': question_type,
      'directory_last_access': directory_last_access,
      'is_scrap_directory': is_scrap_directory,
      'is_deleted': is_deleted,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    last_successed = map['last_successed'] ?? last_successed;
    concept = map['concept'] ?? concept;
    title = map['title'] ?? title;
    question_type = map['question_type'] ?? question_type;
    directory_last_access = map['directory_last_access'] ??directory_last_access;
    is_scrap_directory = map['is_scrap_directory'] ??is_scrap_directory;
    is_deleted = map['is_deleted'] ?? is_deleted;

  }
}
