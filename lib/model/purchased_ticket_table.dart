
import 'package:flutter/material.dart';



class PurchasedTicketTableFields{
  static final String? id = '_id';
  static final String? user_id = 'user_id';
  static final String? ticket_id = 'ticket_id';
}



class PurchasedTicketTable {
  int? id;
  int? user_id;
  int? ticket_id;


  PurchasedTicketTable({
    this.id,
    required this.user_id,
    required this.ticket_id,
  } );

  factory PurchasedTicketTable.fromMap(Map<String, dynamic> json) =>
      PurchasedTicketTable(
        id: json[PurchasedTicketTableFields.id],
        user_id: json[PurchasedTicketTableFields.user_id],
        ticket_id: json[PurchasedTicketTableFields.ticket_id],

      );

  Map<String, dynamic> toMap() {
    return {
      PurchasedTicketTableFields.id! : id,
      PurchasedTicketTableFields.user_id! : user_id,
      PurchasedTicketTableFields.ticket_id! : ticket_id,
    };
  }
}