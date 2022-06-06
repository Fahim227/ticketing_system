import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/model/ticket_table.dart';

class BookOrPurchaseTicket extends StatelessWidget {

  BookOrPurchaseTicket({required this.customer_id, required this.event});


  int? customer_id;
  Event event;
  String? action;
  String? seat_class;
  int? price;
  int? number_of_ticket=1;

  void bookATicket() async {
    action = 'book';
    price = seat_class!.toLowerCase() == 'vip' ? (event.vip_seat_price! * number_of_ticket!) : (event.reguler_seat_price! * number_of_ticket!);
    Ticket ticket = Ticket(event_id: event.id, seat_class: seat_class, price: price,  status: 'pending' );
    int booked_id = await DatabaseHelper.instance.insertTicket(ticket, action!, customer_id!);
    print(booked_id);
  }
  void purchaseATicket() async {
    action = 'purchase';
    price = seat_class!.toLowerCase() == 'vip' ? (event.vip_seat_price! * number_of_ticket!) : (event.reguler_seat_price! * number_of_ticket!);
    Ticket ticket = Ticket(event_id: event.id, seat_class: seat_class, price: price,  status: 'Payment Complete' );
    int purchase_id = await DatabaseHelper.instance.insertTicket(ticket, action!, customer_id!);
    print(purchase_id);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
