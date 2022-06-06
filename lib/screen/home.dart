import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/model/ticket_table.dart';
import 'package:ticketing_system/roundButton.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static final String? homeScreen = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
  int? is_approved = 0;
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
        total_reguler_seat: total_reguler_seat,
      is_approved: is_approved,
    );

    int id = await DatabaseHelper.instance.createEvent(event);
    print('Event ID: $id');
  }

  void approveEvent() async {
    Event event = await DatabaseHelper.instance.getEventBaseOnPK(6);
    event.is_approved = 1;
    int id = await DatabaseHelper.instance.approveEvent(6, event);
    print('Updated ID: $id');
  }
  void getBookedAndPurchashedTickets() async {
    List<Ticket> all = await DatabaseHelper.instance.getBookedAndPurchashedTickets(1);
    print(all.length);
  }

  @override
  void initState() {
    super.initState();
    _createDB();
    // approveEvent();
    //insertEvent();
    // _createDB();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Log in',),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                //eventName = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Event Name'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                venue = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Venue'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                //size = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter size'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                //seatType = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter SeatType'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                //prices = double.parse(value);
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter prices'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                //eventDate = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Event Date'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                //eventTime = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Event Time'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.lightBlue,
              onPress: () async {
                setState((){
              },
            );
              } )
          ],
        ),
      ),
    );
  }
}
