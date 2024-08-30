// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';

class UserModel extends UserEntitie {
  UserModel({required super.email, required super.uId, super.name = ''});
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'email': email,
      'name': name,
    };
  }
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] as String,
      email: map['email'] as String,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  UserModel copyWith({
    String? uId,
    String? email,
    String? name,
  }) {
    return UserModel(
      uId: uId ?? this.uId,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
