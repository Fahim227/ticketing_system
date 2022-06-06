import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';


class AllEvents extends StatelessWidget {

  List<Event>? events;

  void getEventsThoseAreApproved() async {
    List<Event> events = await DatabaseHelper.instance.getEventsThoseApproved();
    print(events.length);
  }


  // Show All Events
  // goto each event details
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
