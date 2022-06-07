import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/customer_model.dart';

class RegisterCustomer extends StatelessWidget {

  String? type; // reguler or VIP
  String? name;
  String? phone;
  String? email;
  String? customer_id;

  void createCustomer() async {
    // Customer customer = Customer(name: name, phone: phone, email: email);
    // int id = await DatabaseHelper.instance.insertCustomer(customer, type!);
    // customer_id = id.toString();

  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
