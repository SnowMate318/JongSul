class MiniDirectory {
  int id;
  String concept;
  String title;
  String directoryLastAccess;

  MiniDirectory.init({
    this.id = 0,
    this.concept = '',
    this.title = '',
    this.directoryLastAccess = '',
  });

  MiniDirectory.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? 0,
        concept = map['concept'] ?? '',
        title = map['title'] ?? '',
        directoryLastAccess = map['directory_last_access'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'concept': concept,
      'title': title,
      'directory_last_access': directoryLastAccess,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    id = map['id'] ?? id;
    concept = map['concept'] ?? concept;
    title = map['title'] ?? title;
    directoryLastAccess = map['directory_last_access'] ??directoryLastAccess;

  }
}
