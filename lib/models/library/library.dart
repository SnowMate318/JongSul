import 'package:jongsul/models/directory/mini_directory.dart';

class Library {
  int id;
  String title;
  String library_last_access;
  bool is_deleted;

  List<MiniDirectory> miniDirectories;

  Library.init({
    this.id = 0,
    this.title = '',
    this.library_last_access = '',
    this.is_deleted = false,
    this.miniDirectories = const [],
  });

  Library.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? 0,
        title = map['title'] ?? '',
        library_last_access = map['library_last_access'] ?? '',
        is_deleted = map['is_deleted'] ?? false,
        miniDirectories = (map['directories'] as List<dynamic>?)
                ?.map((miniDirectory) => MiniDirectory.fromMap(miniDirectory))
                ?.toList() ??
            [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'library_last_access': library_last_access,
      'is_deleted': is_deleted,
      'directories': miniDirectories.map((miniDirectory) => miniDirectory.toJson()).toList(),
    };
  }

  void fromJson(Map<String, dynamic> map) {
    id = map['id'] ?? id;
    title = map['title'] ?? title;
    library_last_access = map['library_last_access'] ?? library_last_access;
    is_deleted = map['is_deleted'] ?? is_deleted;
    miniDirectories = (map['directories'] as List<dynamic>?)
            ?.map((miniDirectory) => MiniDirectory.fromMap(miniDirectory))
            ?.toList() ??
        [];
  }
}
