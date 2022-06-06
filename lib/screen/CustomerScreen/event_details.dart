import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';

class EventDetails extends StatelessWidget {

  EventDetails({required this.customer_id,required this.event});

  int? customer_id;
  Event event;
  String? action;

  // go to book or purchase ticket page
  // got to see all tickets those booked or purchased.
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
