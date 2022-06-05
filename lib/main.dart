import 'package:flutter/material.dart';
import 'package:ticketing_system/screen/home.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: Home.homeScreen!,
      routes: {
        Home.homeScreen! :(context) => Home(),
      },
    )
  );
}
