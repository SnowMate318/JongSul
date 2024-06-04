//Todo: shared와 shared_tag 결합해서 구현함
//Todo: 이처럼 question - choice 결합해야함
class SharedTag {
  String name;

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
