import 'package:jongsul/models/shared/shared_tag.dart';

class Shared {
  int id;
  String sharedTitle;
  String sharedContent;
  String sharedUploadDatetime;
  bool isActivated;
  bool isDeleted;
  int downloadCount;

  List<SharedTag> sharedTags;
  //Todo: Shared 시리얼라이져에 유저정보 추가
  String userUuid;
  String userName;
  String userProfile;

  // Library.init()
  //     : title = '',
  //       library_last_access = '',
  //       is_deleted = false,

  Shared.init({
    this.id = 0,
    this.sharedTitle = '',
    this.sharedContent = '',
    this.sharedUploadDatetime = '',
    this.isActivated = false,
    this.isDeleted = false,
    this.downloadCount = 0,
    this.userUuid = '',
    this.userName = '',
    this.userProfile = '',
    this.sharedTags = const [],
  });

  Shared.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        sharedTitle = map['shared_title'] ?? '',
        sharedContent = map['shared_content'] ?? '',
        sharedUploadDatetime = map['shared_upload_datetime'] ?? '',
        isActivated = map['is_activated'] ?? false,
        isDeleted = map['is_deleted'] ?? false,
        downloadCount = map['download_count'] ?? 0,
        userUuid = map['user']['user_uuid'] ?? '',
        userName = map['user']['user_name'] ?? '',
        userProfile = map['user']['user_profile'] ?? '',
        sharedTags = (map['shared_tags'] as List<dynamic>?)
                ?.map((tag) => SharedTag.fromMap(tag))
                ?.toList() ??
            [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shared_title': sharedTitle,
      'shared_content': sharedContent,
      'shared_upload_datetime': sharedUploadDatetime,
      'is_activated': isActivated,
      'is_deleted': isDeleted,
      'download_count': downloadCount,
      'user': {
        'user_uuid' : userUuid,
        'user_name': userName,
        'user_profile': userProfile,
      },
      'shared_tags': sharedTags.map((tag) => tag.toJson()).toList(),
    };
  }

  void fromJson(Map<String, dynamic> map) {
    id = map['id'] ?? id;
    sharedContent = map['shared_content'] ?? sharedContent;
    sharedUploadDatetime = map['shared_upload_datetime'] ??sharedUploadDatetime;
    isActivated = map['is_activated'] ?? isActivated;
    isDeleted = map['is_deleted'] ?? isDeleted;
    downloadCount = map['download_count'] ?? downloadCount;
    userUuid = map['user']['user_uuid'] ?? userUuid;
    userName = map['user']['user_name'] ?? userName;
    userProfile = map['user']['user_profile'] ?? userProfile;
    sharedTags = (map['shared_tags'] as List<dynamic>?)
            ?.map((tag) => SharedTag.fromMap(tag))
            ?.toList() ??
        []; // Choice 리스트 변환
  }
}
