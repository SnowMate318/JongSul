class Shared {
  int sharedId;

  //String shared_title;
  String shared_content;
  String shared_upload_datetime;
  bool is_activated;
  bool is_deleted;
  int download_count;

  List<String> sharedTags;
  //Todo: Shared 시리얼라이져에 유저정보 추가
  String userName;
  String userProfile;

  // Library.init()
  //     : title = '',
  //       library_last_access = '',
  //       is_deleted = false,

  Shared.init({
    this.sharedId = 0,
    //this.shared_title = '',
    this.shared_content = '',
    this.shared_upload_datetime = '',
    this.is_activated = false,
    this.is_deleted = false,
    this.download_count = 0,
    this.userName = '',
    this.userProfile = '',
    this.sharedTags = const[],
  });

  Shared.fromMap(Map<String, dynamic> map)
      : sharedId = map['id'] ?? '',
        //shared_title = map['shared_title'] ?? '',
        shared_content = map['shared_content'] ?? '',
        shared_upload_datetime = map['shared_upload_datetime'] ?? '',
        is_activated = map['is_activated'] ?? false,
        is_deleted = map['is_deleted'] ?? false,
        download_count = map['download_count'] ?? 0,
        userName = map['user']['user_name'] ?? '',
        userProfile = map['user']['user_profile'] ?? '',
        sharedTags = [];

  Map<String, dynamic> toJson() {
    return {
      //'shared_title': shared_title,
      'shared_content': shared_content,
      'shared_upload_datetime': shared_upload_datetime,
      'is_activated': is_activated,
      'is_deleted': is_deleted,
      'download_count': download_count,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    sharedId = map['id'] ?? sharedId;
    //shared_title = map['shared_title'] ??shared_title;
    shared_content = map['shared_content'] ?? shared_content;
    shared_upload_datetime = map['shared_upload_datetime'] ??shared_upload_datetime;
    is_activated = map['is_activated'] ?? is_activated;
    is_deleted = map['is_deleted'] ?? is_deleted;
    download_count = map['download_count'] ?? download_count;
    userName = map['user']['user_name'] ?? userName;
    userProfile = map['user']['user_profile'] ?? userProfile;
    sharedTags = [];
  }
}
