import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/screen/CustomerScreen/event_details.dart';


class AllEvents extends StatelessWidget {

  AllEvents({required this.customer_id});

  int? customer_id;

  List<Event>? events;

  void getEventsThoseAreApproved() async {
    List<Event> events = await DatabaseHelper.instance.getEventsThoseApproved();
    print(events.length);
  }


  // Show All Events
  // goto each event details
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Events'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(
              width: double.infinity,
              child: FutureBuilder<List<Event>>(
                  future: DatabaseHelper.instance.getEventsThoseApproved(),
                  builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    print(snapshot.data);
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int idx){
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute<void>(
                                // Action 0 => update, Action 1 => save
                                builder: (BuildContext context) =>  EventDetails(customer_id: customer_id, event: snapshot.data![idx]),
                              ),);
                            },
                            // onLongPress: () async {
                            //   int res = await DatabaseHelper.instance.deleteEvent(snapshot.data![idx].id!);
                            //   print(res);
                            //
                            // },
                            title: Text(snapshot.data![idx].title == null ? 'Null': snapshot.data![idx].title!),
                            subtitle:  Text(snapshot.data![idx].venue == null ? 'Null': 'Venue: '+snapshot.data![idx].venue!),

                          ),
                        );
                      },
                      // children: [
                      // Center(
                      // child: ListTile(
                      // title: Text(snapshot.data['title']),
                      // ),
                      // );
                      //   ]
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
