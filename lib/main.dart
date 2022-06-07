import 'package:flutter/material.dart';
import 'package:ticketing_system/screen/AdminScreen/all_event_request.dart';
import 'package:ticketing_system/screen/Organizer/create_event.dart';
import 'package:ticketing_system/screen/Organizer/login_page.dart';
import 'package:ticketing_system/screen/home.dart';
import 'package:ticketing_system/screen/select_user.dart';
import 'package:ticketing_system/screen/user_register.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: SelectUserType.id,
      routes: {
        Home.homeScreen! :(context) => Home(),
        SelectUserType.id! :(context) => SelectUserType(),
       // LoginAsAdminOrOrganizer.loginAsAdminOrOrganizerScreen! :(context) => LoginAsAdminOrOrganizer(),
        //RegisterUser.id: (context) => RegisterUser(),
        CreateEvent.id: (context) => CreateEvent(userId: 1,),
        AllEventRequest.id: (context) => AllEventRequest(),
      },
    )
  );
}
