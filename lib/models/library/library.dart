class Library {
  int id;
  String title;
  String library_last_access;

  bool is_deleted;

  // Library.init()
  //     : title = '',
  //       library_last_access = '',
  //       is_deleted = false,

  Library.init({
    this.id = 0,
    this.title = '',
    this.library_last_access = '',
    this.is_deleted = false,
  });

  Library.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? 0,
        title = map['title'] ?? '',
        library_last_access = map['library_last_access'] ?? '',
        is_deleted = map['is_deleted'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'library_last_access': library_last_access,
      'is_deleted': is_deleted,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    id = map['id'] ?? id;
    title = map['title'] ?? title;
    library_last_access = map['library_last_access'] ?? library_last_access;
    is_deleted = map['is_deleted'] ?? is_deleted;
  }
}
