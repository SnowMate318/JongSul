import 'package:cloud_firestore/cloud_firestore.dart';

class Library {
  String title;
  String library_last_access ;
  bool is_deleted ;

  // Library.init()
  //     : title = '',
  //       library_last_access = '',
  //       is_deleted = false,

        Library.init({
    this.title = '',
    this.library_last_access = '',
    this.is_deleted = false,

});



  Library.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '',
        library_last_access = map['library_last_access'] ?? '',
        is_deleted = map['is_deleted'] ?? false;

  Library.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'library_last_access': library_last_access,
      'is_deleted': is_deleted,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    title = map['title'] ?? title;
    library_last_access = map['library_last_access'] ?? library_last_access;
    is_deleted = map['is_deleted'] ?? is_deleted;
  }
}
