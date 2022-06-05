
import 'package:flutter/material.dart';



class TicketTableFields{
  static final String? tableName = 'Ticket';
  static final String? id = '_id';
  static final String? event_id = 'event_id';
  static final String? seat_class = 'seat_class';
  static final String? price = 'price';
  static final String? serial_number = 'serial_number';
  static final String? seat_number = 'seat_number';
  static final String? status = 'status';
}



class Ticket {
  int? id;
  int? event_id;
  String? seat_class;
  int? price;
  String? serial_number;
  String? seat_number;
  String? status;


  Ticket({this.id,
      required this.event_id,
      required this.seat_class,
      required this.price,
      required this.serial_number,
      required this.seat_number,
      required this.status});

  factory Ticket.fromMap(Map<String, dynamic> json) =>
      Ticket(
          id : json[TicketTableFields.id!],
        event_id: json[TicketTableFields.event_id],
        seat_class: json[TicketTableFields.seat_class],
        price: json[TicketTableFields.price],
        serial_number: json[TicketTableFields.serial_number],
        seat_number: json[TicketTableFields.seat_number],
        status: json[TicketTableFields.status],
      );

  Map<String, dynamic> toMap() {
    return {
      TicketTableFields.id! :id,
      TicketTableFields.event_id! : event_id,
      TicketTableFields.seat_class! :seat_class,
      TicketTableFields.price! :price,
      TicketTableFields.serial_number! :serial_number,
      TicketTableFields.seat_class! :seat_class,
      TicketTableFields.status! :status,
    };
  }
}