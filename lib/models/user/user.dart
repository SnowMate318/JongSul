import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String email;
  bool is_supueruser;
  bool is_active;
  bool is_staff;
  String created_at;
  String updated_at;
  String user_name;
  String profile;

  User.init({
    this.id= '',
    this.email= '',
    this.is_supueruser=false,
    this.is_active=false,
    this.is_staff=false,
    this.created_at= '',
    this.updated_at= '',
    this.user_name= '',
    this.profile= '',
});

  User.fromMap(String documentId, Map<String, dynamic> map)
      : id = documentId,
        email= map['email']??'',
        is_supueruser=map['is_supueruser']??false,
        is_active=map['is_active']??false,
        is_staff=map['is_staff']??false,
        created_at=map['created_at']?? '',
        updated_at=map['updated_at'] ??'',
        user_name=map['user_name'] ??'',
        profile=map['profile']?? '';

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return {
     'id':id,
     'email':email,
     'is_supueruser':is_supueruser,
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