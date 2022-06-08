

class SeatNumberFields{
  static final String? id = '_id';
  static final String? tableName = 'SeatNumber';
  static final String? event_id = 'event_id';
  static final String? seat_class = 'seat_class';
  static final String? seat_number = 'seat_number';
  static final String? status = 'status';
}



class SeatTable {
  int? id;
  int? event_id;
  String? seat_class;
  String? seat_number ;
  int? status;


  SeatTable({this.id,
    required this.event_id,
    required this.seat_class,
    required this.seat_number,
    required this.status,
  });

  factory SeatTable.fromMap(Map<String, dynamic> json) =>
      SeatTable(
        id: json[SeatNumberFields.id],
        event_id: json[SeatNumberFields.event_id],
        seat_class: json[SeatNumberFields.seat_class],
        seat_number: json[SeatNumberFields.seat_number],
        status: json[SeatNumberFields.status],
      );

  Map<String, dynamic> toMap() {
    return {
      SeatNumberFields.id! : id,
      SeatNumberFields.seat_class! : seat_class,
      SeatNumberFields.seat_number! : seat_number,
      SeatNumberFields.event_id! : event_id,
      SeatNumberFields.status! : status,
    };
  }
}