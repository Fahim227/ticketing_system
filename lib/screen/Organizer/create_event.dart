import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';

class CreateEvent extends StatelessWidget {
  int? userId;
  CreateEvent({required this.userId});

  Database? _database;
  DatabaseHelper? DBHelper;
  String? title = 'default';
  String? venue = 'default';
  String? size;
  String? seatType;
  double? prices;
  String? event_date = 'default';
  String? event_time = 'default';
  String? duration = 'default';
  int? is_available = 1;
  bool? is_booked;
  int? user_id = 2;
  int? total_available_reguler_seat = 2;
  int? total_available_vip_seat = 2;
  int? vip_seat_price = 2;
  int? reguler_seat_price = 2;
  int? total_vip_seat = 2;
  int? total_reguler_seat = 2;


  void _createDB() async {
    DBHelper = await DatabaseHelper.instance;
    _database = await DBHelper!.database;
    print(await _database!.getVersion());
  }

  void insertEvent() async {
    Event event = Event(user_id: user_id, title: title,
        venue: venue,
        event_date: event_date,
        event_time: event_time,
        duration: duration,
        total_available_reguler_seat: total_available_reguler_seat,
        total_available_vip_seat: total_available_vip_seat,
        vip_seat_price: vip_seat_price, reguler_seat_price: reguler_seat_price,
        total_vip_seat: total_vip_seat,
        total_reguler_seat: total_reguler_seat);

    int id = await DatabaseHelper.instance.createEvent(event);
    print('Event ID: $id');
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
