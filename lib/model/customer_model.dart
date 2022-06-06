
import 'package:flutter/material.dart';



class CustomerFields{
  static final String? tableName = 'CustomerTable';
  static final String? id = '_id';
  static final String? name = 'name';
  static final String? phone = 'phone';
  static final String? email = 'email';
  static final String? customer_type_id = 'customer_type_id';
}



class Customer {
  int? id;
  String? name;
  String? phone;
  String? email;
  int? customer_type_id;


  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.customer_type_id,
  });

  factory Customer.fromMap(Map<String, dynamic> json) =>
      Customer(
        id: json[CustomerFields.id],
        name: json[CustomerFields.name],
        phone: json[CustomerFields.phone],
        email: json[CustomerFields.email],
          customer_type_id:json[CustomerFields.customer_type_id]
      );

  Map<String, dynamic> toMap() {
    return {
      CustomerFields.id! : id,
      CustomerFields.name! : name,
      CustomerFields.phone!: phone,
      CustomerFields.email!: email,
      CustomerFields.customer_type_id!: customer_type_id,
    };
  }
}