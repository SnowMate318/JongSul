class Shared {
  String shared_title;

  String shared_content;

  String shared_upload_datetime;

  bool is_activated;
  bool is_deleted;
  int download_count;

  // Library.init()
  //     : title = '',
  //       library_last_access = '',
  //       is_deleted = false,

  Shared.init({
    this.shared_title = '',
    this.shared_content = '',
    this.shared_upload_datetime = '',
    this.is_activated = false,
    this.is_deleted = false,
    this.download_count = 0,
  });

  Shared.fromMap(Map<String, dynamic> map)
      : shared_title = map['shared_title'] ?? '',
        shared_content = map['shared_content'] ?? '',
        shared_upload_datetime = map['shared_upload_datetime'] ?? '',
        is_activated = map['is_activated'] ?? false,
        is_deleted = map['is_deleted'] ?? false,
        download_count = map['download_count'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'shared_title': shared_title,
      'shared_content': shared_content,
      'shared_upload_datetime': shared_upload_datetime,
      'is_activated': is_activated,
      'is_deleted': is_deleted,
      'download_count': download_count,
    };
  }

  void fromJson(Map<String, dynamic> map) {
    shared_title = map['shared_title'] ??shared_title;
    shared_content = map['shared_content'] ?? shared_content;
    shared_upload_datetime = map['shared_upload_datetime'] ??shared_upload_datetime;
    is_activated = map['is_activated'] ?? is_activated;
    is_deleted = map['is_deleted'] ?? is_deleted;
    download_count = map['download_count'] ?? download_count;
  }
}
