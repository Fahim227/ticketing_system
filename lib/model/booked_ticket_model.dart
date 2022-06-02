// bookedTicketTable:
// id (PK)
// user_id (Fk)
// ticket_id (FK)
// finalPurchedDate



import 'package:flutter/material.dart';



class BookedTicketTableFields{
  static final String? id = '_id';
  static final String? user_id = 'user_id';
  static final String? ticket_id = 'ticket_id';
  static final String? finalDateToPucrchase = 'finalDateToPucrchase';
}



class BookedTicketTable {
  int? id;
  int? user_id;
  int? ticket_id;
  String? finalDateToPucrchase;


  BookedTicketTable({
    this.id,
    required this.user_id,
    required this.ticket_id,
    required this.finalDateToPucrchase,
  } );

  factory BookedTicketTable.fromMap(Map<String, dynamic> json) =>
      BookedTicketTable(
        id: json[BookedTicketTableFields.id],
        user_id: json[BookedTicketTableFields.user_id],
        ticket_id: json[BookedTicketTableFields.ticket_id],
        finalDateToPucrchase: json[BookedTicketTableFields.finalDateToPucrchase],

      );

  Map<String, dynamic> toMap() {
    return {
      BookedTicketTableFields.id! : id,
      BookedTicketTableFields.user_id! : user_id,
      BookedTicketTableFields.ticket_id! : ticket_id,
      BookedTicketTableFields.finalDateToPucrchase! : finalDateToPucrchase,
    };
  }
}