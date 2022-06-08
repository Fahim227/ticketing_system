import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/ticket_table.dart';



class ListOfNotAvailableTickets extends StatelessWidget {

  ListOfNotAvailableTickets({required this.event_id});

  int? event_id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Not Available Tickets'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(
              width: double.infinity,
              child: FutureBuilder<List<Ticket>>(
                  future: DatabaseHelper.instance.getBookedAndPurchashedTickets(event_id!),
                  builder: (BuildContext context, AsyncSnapshot<List<Ticket>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    print(snapshot.data);
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int idx){
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data![idx].seat_number == null ? 'Null': 'Seat Numbers: '+snapshot.data![idx].seat_number!),
                            subtitle:  Text(snapshot.data![idx].seat_class == null ? 'Null': 'Seat Class: '+snapshot.data![idx].seat_class!),

                          ),
                        );
                      },
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
