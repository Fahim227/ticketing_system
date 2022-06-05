
import 'package:flutter/material.dart';



class SoldTicketFields{
  static final String? tableName = 'Sold_Ticket';
  static final String? id = '_id';
  static final String? customer_id = 'customer_id';
  static final String? ticket_id = 'ticket_id';
  static final String? event_id = 'event_id';
  static final String? total_price = 'total_price';
  static final String? date = 'date';
}



class SoldTicket {
  int? id;
  int? customer_id;
  int? ticket_id;
  int? event_id;
  int? total_price;
  String? date;


  SoldTicket({this.id,
      required this.customer_id,
      required this.ticket_id,
      required this.event_id,
      required this.total_price,
      required this.date});

  factory SoldTicket.fromMap(Map<String, dynamic> json) =>
      SoldTicket(
        id: json[SoldTicketFields.id],
        customer_id: json[SoldTicketFields.customer_id],
        ticket_id: json[SoldTicketFields.ticket_id],
        event_id: json[SoldTicketFields.event_id],
        total_price: json[SoldTicketFields.total_price],
        date: json[SoldTicketFields.date],
      );

  Map<String, dynamic> toMap() {
    return {
      SoldTicketFields.id! : id,
      SoldTicketFields.customer_id! : customer_id,
      SoldTicketFields.ticket_id! : ticket_id,
      SoldTicketFields.event_id! : event_id,
      SoldTicketFields.total_price! : total_price,
      SoldTicketFields.date! : date,
    };
  }
}