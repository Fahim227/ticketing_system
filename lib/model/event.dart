import 'package:flutter/material.dart';



class EventTableFields{
  static final String? tableName = 'Event';
  static final String? id = '_id';
  static final String? title = 'title';
  static final String? venue = 'venue';
  static final String? event_date = 'event_date';
  static final String? event_time = 'event_time';
  static final String? duration = 'duration';
  static final String? total_available_seat = 'total_available_seat';
  static final String? user_id = 'user_id';
  static final String? total_seat = 'total_seat';
}


class Event {
  int? id;
  int? user_id;
  String? title;
  String? venue;
  String? event_date;
  String? event_time;
  String? duration;
  String? total_available_seat;
  String? total_seat;


  Event({this.id, required this.user_id, required this.title,
    required this.venue,
    required this.event_date,
    required this.event_time,
    required this.duration,
    required this.total_available_seat,
    required this.total_seat});


  factory Event.fromMap(Map<String, dynamic> json)=>
      Event(
          id: json[EventTableFields.id],
          title: json[EventTableFields.title],
          venue: json[EventTableFields.venue],
          event_date: json[EventTableFields.event_date],
          event_time: json[EventTableFields.event_time],
          duration: json[EventTableFields.duration],
          total_available_seat: json[EventTableFields.total_available_seat],
          total_seat: json[EventTableFields.total_seat],
          user_id: json[EventTableFields.user_id]
      );

  Map<String, dynamic> toMap() {
    return {
      EventTableFields.title!: title,
      EventTableFields.venue!: venue,
      EventTableFields.event_date!: event_date,
      EventTableFields.event_time!: event_time,
      EventTableFields.duration!: duration,
      EventTableFields.total_available_seat!: total_available_seat,
      EventTableFields.total_seat!: total_seat
    };
  }
}