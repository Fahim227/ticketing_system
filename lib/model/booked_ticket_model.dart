


class BookedTicketTableFields{
  static final String? tableName = 'Booked_Ticket';
  static final String? id = '_id';
  static final String? customer_id = 'customer_id';
  static final String? ticket_id = 'ticket_id';
  static final String? event_id = 'event_id';
  static final String? finalDateToPucrchase = 'finalDateToPucrchase';
}



class BookedTicketTable {
  int? id;
  int? customer_id;
  int? ticket_id;
  int? event_id;
  String? finalDateToPucrchase;


  BookedTicketTable({
    this.id,
    required this.customer_id,
    required this.ticket_id,
    required this.event_id,
    required this.finalDateToPucrchase,
  } );

  factory BookedTicketTable.fromMap(Map<String, dynamic> json) =>
      BookedTicketTable(
        id: json[BookedTicketTableFields.id],
        customer_id: json[BookedTicketTableFields.customer_id],
        ticket_id: json[BookedTicketTableFields.ticket_id],
        event_id: json[BookedTicketTableFields.event_id],
        finalDateToPucrchase: json[BookedTicketTableFields.finalDateToPucrchase],

      );

  Map<String, dynamic> toMap() {
    return {
      BookedTicketTableFields.id! : id,
      BookedTicketTableFields.customer_id! : customer_id,
      BookedTicketTableFields.ticket_id! : ticket_id,
      BookedTicketTableFields.event_id! : event_id,
      BookedTicketTableFields.finalDateToPucrchase! : finalDateToPucrchase,
    };
  }
}