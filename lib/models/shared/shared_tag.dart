class SharedTag {
  String name;

// Library.init()
//     : title = '',
//       library_last_access = '',
//       is_deleted = false,

  SharedTag.init({
    this.name = '',
  });

  SharedTag.fromMap(Map<String, dynamic> map) : name = map['name'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    name = map['name'] ?? name;
  }
}
