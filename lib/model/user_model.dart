
import 'package:flutter/material.dart';



class UserTableField{
  static final String? id = '_id';
  static final String? userName = 'user_name';
  static final String? password = 'password';
  static final String? email = 'email';
  static final String? user_type = 'user_type';
}



class UserTable {
  int? id;
  String? userName;
  String? passowrd;
  String? email;
  String? user_type;


  UserTable({
    this.id,
    required this.userName,
    required this.passowrd,
    required this.email,
    required this.user_type,
  } );

  factory UserTable.fromMap(Map<String, dynamic> json) =>
      UserTable(
          id: json[UserTableField.id],
          userName: json[UserTableField.userName],
          passowrd: json[UserTableField.password],
          email: json[UserTableField.email],
          user_type: json[UserTableField.user_type],
      );

  Map<String, dynamic> toMap() {
    return {
      UserTableField.id! : id,
      UserTableField.userName! : userName,
      UserTableField.password!: passowrd,
      UserTableField.email!: email,
      UserTableField.user_type!: user_type
    };
  }
}