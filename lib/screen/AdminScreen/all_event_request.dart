import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';

class AllEventRequest extends StatefulWidget {
  const AllEventRequest({Key? key}) : super(key: key);

  @override
  State<AllEventRequest> createState() => _AllEventRequestState();
}

class _AllEventRequestState extends State<AllEventRequest> {

  List<Event>? AllUnapprovedEvents;

  void approveEvent() async {
    Event event = await DatabaseHelper.instance.getEventBaseOnPK(6);
    event.is_approved = 1;
    int id = await DatabaseHelper.instance.approveEvent(6, event);
    print('Updated ID: $id');
  }

  void getAllEventRequest() async {
    List<Event> events = await DatabaseHelper.instance.getEventsThoseNotApproved();
    AllUnapprovedEvents = events;
  }

  @override
  void initState() {
    super.initState();
    getAllEventRequest();

  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
