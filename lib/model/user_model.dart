
import 'package:flutter/material.dart';



class UserTableFields{
  static final String? tableName = 'UserTable';
  static final String? id = '_id';
  static final String? name = 'name';
  static final String? phone = 'phone';
  static final String? email = 'email';
  static final String? password = 'password';
  static final String? roll_id = 'roll_id';
}



class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  int? roll_id;
  String? password;


  User({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.roll_id,
    required this.password
  } );

  factory User.fromMap(Map<String, dynamic> json) =>
      User(
          id: json[UserTableFields.id],
        name: json[UserTableFields.name],
        phone: json[UserTableFields.phone],
          email: json[UserTableFields.email],
        roll_id: json[UserTableFields.roll_id],
        password: json[UserTableFields.password],
      );

  Map<String, dynamic> toMap() {
    return {
      UserTableFields.id! : id,
      UserTableFields.name! : name,
      UserTableFields.phone!: phone,
      UserTableFields.email!: email,
      UserTableFields.roll_id!: roll_id,
      UserTableFields.password!: password,
    };
  }
}