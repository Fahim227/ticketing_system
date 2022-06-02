
import 'package:flutter/material.dart';



class TicketTableFields{
  static final String? id = '_id';
  static final String? eventName = 'event_name';
  static final String? venue = 'venue';
  static final String? size = 'size';
  static final String? seatType = 'seat_type';
  static final String? prices = 'price';
  static final String? eventDate = 'event_date';
  static final String? eventTime = 'event_time';
  static final String? is_available = 'is_available';
  static final String? is_booked = 'is_booked';
}



class TicketTable {
  int? id;
  String? eventName;
  String? venue;
  String? size;
  String? seatType;
  double? prices;
  DateTime? eventDate;
  DateTime? eventTime;
  bool? is_available;
  bool? is_booked;


  TicketTable({
      this.id,
      required this.eventName,
      required this.venue,
      required this.size,
      required this.seatType,
      required this.prices,
      required this.eventDate,
      required this.eventTime,
      required this.is_available,
      required this.is_booked }
      );

  factory TicketTable.fromMap(Map<String, dynamic> json) =>
       TicketTable(
          id : json[TicketTableFields.id!],
          eventName :json[TicketTableFields.eventName],
          venue :json[TicketTableFields.venue],
          size :json[TicketTableFields.size],
          seatType :json[TicketTableFields.seatType],
          prices :json[TicketTableFields.prices],
          eventDate :json[TicketTableFields.eventDate],
          eventTime :json[TicketTableFields.eventTime],
          is_available :json[TicketTableFields.is_available],
          is_booked : json[TicketTableFields.is_booked]
      );

  Map<String, dynamic> toMap() {
    return {
      TicketTableFields.id!: id,
      TicketTableFields.eventName!: eventName,
      TicketTableFields.venue!: venue,
      TicketTableFields.size!: size,
      TicketTableFields.seatType!: seatType,
      TicketTableFields.prices!: prices,
      TicketTableFields.eventDate!: eventDate,
      TicketTableFields.eventTime!: eventTime,
      TicketTableFields.is_available!: is_available,
      TicketTableFields.is_booked!: is_booked,
    };
  }
}