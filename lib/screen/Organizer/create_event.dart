import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/roundButton.dart';

class CreateEvent extends StatelessWidget {
  int? userId;
  CreateEvent({required this.userId});

  static final String id = '/createEvent';
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
  String? vipSeats = '';
  String? regulerSeats = '';
  int? reguler_seat_price = 2;
  int? total_vip_seat = 2;
  int? total_reguler_seat = 2;
  TextEditingController? titleController,venueContorller,dateController,timeController,durationController,regulerSeatController,regulerPriceController,vipSeatController,VIPSeatNumber,RegulerSeatNumber,vipPriceController;

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

    // int id = await DatabaseHelper.instance.createEvent(event);
    print('Event ID: $id');
  }


  @override
  Widget build(BuildContext context) {
    titleController = TextEditingController();
    venueContorller = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    regulerSeatController = TextEditingController();
    regulerPriceController = TextEditingController();
    vipSeatController = TextEditingController();
    vipPriceController = TextEditingController();
    durationController = TextEditingController();
    VIPSeatNumber = TextEditingController();
    RegulerSeatNumber = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Create An Event'),),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: titleController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  title = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter Title'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: venueContorller,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  venue = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter Venue'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: dateController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  event_date = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter event_date'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: timeController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  event_time = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter event_time'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: durationController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  duration = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter duration(in Hour)'),
              ),
              SizedBox(
                height: 10.0,
              ),
              // TextField(
              //   style: TextStyle(color: Colors.black),
              //   onChanged: (value) {
              //     total_available_reguler_seat = int.parse(value);
              //   },
              //   decoration: kInputDecorations.copyWith(hintText: 'Enter total_available_reguler_seat'),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // TextField(
              //   style: TextStyle(color: Colors.black),
              //   onChanged: (value) {
              //     total_available_vip_seat = int.parse(value);
              //   },
              //   decoration: kInputDecorations.copyWith(hintText: 'Enter total_available_vip_seat'),
              // ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: regulerSeatController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  total_reguler_seat = int.parse(value);
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter total_reguler_seat'),
              ),
              SizedBox(
                  height: 10.0,
              ),
              TextField(
                controller: regulerPriceController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  reguler_seat_price = int.parse(value);
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter reguler_seat_price'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: vipSeatController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  total_vip_seat = int.parse(value);

                },
                decoration:
                kInputDecorations.copyWith(hintText: 'Enter total_vip_seat'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: vipPriceController,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  vip_seat_price = int.parse(value);

                },
                decoration:
                kInputDecorations.copyWith(hintText: 'Enter vip_seat_price'),
              ),
              SizedBox(
                height: 20,
              ),

              TextField(
                controller: VIPSeatNumber,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  vipSeats = value;

                },
                decoration:
                kInputDecorations.copyWith(hintText: "Enter VIPSeatNumbers using ',' in between"),
              ),
              SizedBox(
                height: 20,
              ),

              TextField(
                controller: RegulerSeatNumber,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  regulerSeats = value;

                },
                decoration:
                kInputDecorations.copyWith(hintText: "Enter RegulerSeatNumbers using ',' in between"),
              ),

              RoundedButton(
                  title: 'Create Event',
                  color: Colors.lightBlue,
                  onPress: () async {
                    total_available_vip_seat = total_vip_seat;
                    total_available_reguler_seat = total_reguler_seat;

                    Event event = Event(user_id: user_id, title: title, venue: venue, event_date: event_date, event_time: event_time, duration: duration, total_available_reguler_seat: total_available_reguler_seat, total_available_vip_seat: total_available_vip_seat, vip_seat_price: vip_seat_price, reguler_seat_price: reguler_seat_price, total_vip_seat: total_vip_seat, total_reguler_seat: total_reguler_seat);
                    print(event.total_available_reguler_seat);
                    print(event.total_available_vip_seat);
                    event.is_approved = 0;
                    int event_id = await DatabaseHelper.instance.createEvent(event,vipSeats!,regulerSeats!);
                    print(event_id);
                    if(event_id > 0){
                      var fToast = FToast();
                      fToast.init(context);
                      fToast.showToast(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.greenAccent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.done),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text("Event Created"),
                            ],
                          ),),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: Duration(seconds: 2),
                      );
                    }
                    else{
                      var fToast = FToast();
                      fToast.init(context);
                      fToast.showToast(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.redAccent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.not_interested),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text("Failed To Create Event"),
                            ],
                          ),),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: Duration(seconds: 2),
                      );
                    }
                    titleController!.clear();
                    venueContorller!.clear();
                    dateController!.clear();
                    timeController!.clear();
                    regulerSeatController!.clear();
                    regulerPriceController!.clear();
                    vipSeatController!.clear();
                    vipPriceController!.clear();
                    durationController!.clear();
                  }),
            ]),
      ),
    );
  }
}
