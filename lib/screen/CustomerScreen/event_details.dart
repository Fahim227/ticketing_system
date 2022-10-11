import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/roundButton.dart';
import 'package:ticketing_system/screen/CustomerScreen/book_or_purchase_ticket.dart';
import 'package:ticketing_system/screen/CustomerScreen/list_of_not_available_tickets.dart';

class EventDetails extends StatelessWidget {

  EventDetails({required this.customer_id,required this.event});

  int? customer_id;
  Event event;
  String? action;

  // go to book or purchase ticket page
  // got to see all tickets those booked or purchased.



  @override
  Widget build(BuildContext context) {
    print(event.total_available_reguler_seat);
    return Scaffold(
      appBar: AppBar(title: Text('EventDetails'),),
      body: Column(
        children: [
         Expanded(
           child: Card(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Title: ',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.title!,style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Venue',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.venue!,style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Duration',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.duration!+' Hour',style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Date: ',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.event_date!,style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Time: ',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.event_time!,style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Total Reguler Seat: ',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.total_reguler_seat!.toString(),style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Available Reguler Seat Price: ',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.total_available_reguler_seat!.toString(),style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event Available VIP Seat: ',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.total_available_vip_seat!.toString(),style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Event VIP Seat Price: ',style: textStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                     Text(event.vip_seat_price!.toString(),style: textStyle,),
                   ],
                 ),
                 SizedBox(height: 10.0,),

               ],
             ),
           ),
         ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: RoundedButton(
                  title: 'Get Ticket',
                  color: Colors.lightBlue,
                  onPress: () async {

                    Navigator.push(context, MaterialPageRoute<void>(
                      // Action 0 => update, Action 1 => save
                        builder: (BuildContext context) =>  BookOrPurchaseTicket(customer_id: customer_id,event: event,)
                    ),
                    );
                  }
              ),
            ),
            Expanded(child: RoundedButton(
                title: 'Not Available Tickets',
                color: Colors.lightBlue,
                onPress: () async {
                  Navigator.push(context, MaterialPageRoute<void>(
                    // Action 0 => update, Action 1 => save
                      builder: (BuildContext context) =>  ListOfNotAvailableTickets(event_id:event.id)
                  ),
                  );
                }
            ),)
          ],
        )
        ],
      ),
    );
  }
}
