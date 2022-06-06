import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/customer_model.dart';
import 'package:ticketing_system/model/user_model.dart';


class RegisterUser extends StatelessWidget {


  String? roll; // Admin or Organizer
  String? name;
  String? phone;
  String? email;
  String? user_id;

  void createUser() async {
    User customer = User(name: name, phone: phone, email: email);
    int id = await DatabaseHelper.instance.insertUser(customer, roll!);
    user_id = id.toString();

  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
