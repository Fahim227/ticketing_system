import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
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
  String? eventName;
  String? venue;
  String? size;
  String? seatType;
  double? prices;
  String? eventDate;
  String? eventTime;
  bool? is_available;
  bool? is_booked;


  void _createDB() async {
    DBHelper = await DatabaseHelper.instance;
    _database = await DBHelper!.database;
    print(await _database!.getVersion());
  }


  @override
  void initState() {
    super.initState();
    _createDB();

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
                eventName = value;
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
                size = value;
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
                seatType = value;
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
                prices = double.parse(value);
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
                eventDate = value;
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
                eventTime = value;
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
