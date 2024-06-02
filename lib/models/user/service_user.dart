
class ServiceUser {
  int id;
  String uuid;
  String email;
  bool is_supueruser;
  bool is_active;
  bool is_staff;
  String created_at;
  String updated_at;
  String user_name;
  String profile;

  ServiceUser.init({
    this.id= 0,
    this.uuid= '',
    this.email= '',
    this.is_supueruser=false,
    this.is_active=false,
    this.is_staff=false,
    this.created_at= '',
    this.updated_at= '',
    this.user_name= '',
    this.profile= '',
});

  ServiceUser.fromMap(Map<String, dynamic> map)
      : id = map['id']??0,
        uuid= map['uuid']??'',
        email= map['email']??'',
        is_supueruser=map['is_superuser']??false,
        is_active=map['is_active']??false,
        is_staff=map['is_staff']??false,
        created_at=map['created_at']?? '',
        updated_at=map['updated_at'] ??'',
        user_name=map['user_name'] ??'',
        profile=map['profile']?? '';

  Map<String, dynamic> toJson() {
    return {
     'id':id,
     'uuid':uuid,
     'email':email,
     'is_superuser':is_supueruser,
     'is_active':is_active,
     'is_staff':is_staff,
     'created_at':created_at,
     'updated_at':updated_at,
     'user_name':user_name,
     'profile':profile,
    };
  }
  void fromJson(Map<String, dynamic> map) {
    id = map['id']??id;
    uuid= map['uuid']??uuid;
    email= map['email']??email;
    is_supueruser=map['is_supueruser']??is_supueruser;
    is_active=map['is_active']??is_active;
    is_staff=map['is_staff']??is_staff;
    created_at=map['created_at']?? created_at;
    updated_at=map['updated_at'] ??updated_at;
    user_name=map['user_name'] ??user_name;
    profile=map['profile']?? profile;
  }
}
