import 'package:flutter/material.dart';



class EventTableFields{
  static final String? tableName = 'Event';
  static final String? id = '_id';
  static final String? title = 'title';
  static final String? venue = 'venue';
  static final String? event_date = 'event_date';
  static final String? event_time = 'event_time';
  static final String? duration = 'duration';
  static final String? total_available_vip_seat = 'total_available_vip_seat';
  static final String? total_available_reguler_seat = 'total_available_reguler_seat';
  static final String? total_reguler_seat = 'total_reguler_seat';
  static final String? total_vip_seat = 'total_vip_seat';
  static final String? user_id = 'user_id';
  static final String? total_seat = 'total_seat';
  static final String? total_available_seat = 'total_available_seat';
  static final String? vip_seat_price = 'vip_seat_price';
  static final String? reguler_seat_price = 'reguler_seat_price';
  static final String? is_approved = 'is_approved';
}
class Event {
  int? id;
  int? user_id;
  String? title;
  String? venue;
  String? event_date;
  String? event_time;
  String? duration;
  int? total_available_vip_seat;
  int? total_available_reguler_seat;
  int? total_seat;
  int? total_reguler_seat;
  int? total_vip_seat;
  int? is_approved;
  int? vip_seat_price;
  int? reguler_seat_price;


  Event({this.id, required this.user_id, required this.title,
    required this.venue,
    required this.event_date,
    required this.event_time,
    required this.duration,
    required this.total_available_reguler_seat,
    required this.total_available_vip_seat,
    required this.vip_seat_price,
    required this.reguler_seat_price,
    required this.total_vip_seat,
    required this.total_reguler_seat,
    this.is_approved
  });


  factory Event.fromMap(Map<String, dynamic> json)=>
      Event(
          id: json[EventTableFields.id],
          title: json[EventTableFields.title],
          venue: json[EventTableFields.venue],
          event_date: json[EventTableFields.event_date],
          event_time: json[EventTableFields.event_time],
          duration: json[EventTableFields.duration],
        total_available_reguler_seat: json[EventTableFields.total_available_reguler_seat],
        total_available_vip_seat: json[EventTableFields.total_available_vip_seat],
        total_reguler_seat: json[EventTableFields.total_reguler_seat],
        total_vip_seat: json[EventTableFields.total_vip_seat],
          user_id: json[EventTableFields.user_id],
          vip_seat_price: json[EventTableFields.vip_seat_price],
          reguler_seat_price: json[EventTableFields.reguler_seat_price],
          is_approved: json[EventTableFields.is_approved]
      );

  Map<String, dynamic> toMap() {
    return {
      EventTableFields.title!: title,
      EventTableFields.venue!: venue,
      EventTableFields.event_date!: event_date,
      EventTableFields.event_time!: event_time,
      EventTableFields.duration!: duration,
      EventTableFields.vip_seat_price!: vip_seat_price,
      EventTableFields.reguler_seat_price!: reguler_seat_price,
      EventTableFields.total_reguler_seat! : total_reguler_seat,
      EventTableFields.total_vip_seat! : total_vip_seat,
      EventTableFields.total_available_reguler_seat! : total_available_reguler_seat,
      EventTableFields.total_available_vip_seat! : total_available_vip_seat,
      EventTableFields.user_id! : user_id,
      EventTableFields.is_approved!: is_approved,
    };
  }
}