import 'package:flutter/material.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/model/ticket_table.dart';
import 'package:ticketing_system/roundButton.dart';

class BookOrPurchaseTicket extends StatefulWidget {

  BookOrPurchaseTicket({required this.customer_id, required this.event});


  int? customer_id;
  Event event;

  @override
  State<BookOrPurchaseTicket> createState() => _BookOrPurchaseTicketState();
}

class _BookOrPurchaseTicketState extends State<BookOrPurchaseTicket> {
  String? action;

  String? seat_class='Reguler';

  int? price;

  int? number_of_ticket=1;
  bool? isAvailable = false;

  String? dropDownValue;
  String? seat_number_from;
  String? seat_number_to;
  var items = ['Reguler','VIP'];
  var methods = ['Purchase Ticket','Book Ticket'];
  var seats = ['1','2','3','4','5','6','7','8','9','10'];

  void bookATicket() async {
    action = 'book';
    price = seat_class!.toLowerCase() == 'vip' ? (widget.event.vip_seat_price! * number_of_ticket!) : (widget.event.reguler_seat_price! * number_of_ticket!);
    Ticket ticket = Ticket(event_id: widget.event.id, seat_class: seat_class, price: price,  status: 'pending' );
    int booked_id = await DatabaseHelper.instance.insertTicket(ticket, action!, widget.customer_id!);
    print(booked_id);
  }

  void purchaseATicket() async {
    action = 'purchase';
    price = seat_class!.toLowerCase() == 'vip' ? (widget.event.vip_seat_price! * number_of_ticket!) : (widget.event.reguler_seat_price! * number_of_ticket!);
    Ticket ticket = Ticket(event_id: widget.event.id, seat_class: seat_class, price: price,  status: 'Payment Complete' );
    int purchase_id = await DatabaseHelper.instance.insertTicket(ticket, action!, widget.customer_id!);
    print(purchase_id);
  }

  void checkForAvailable() async {
    isAvailable = await DatabaseHelper.instance.isAvailableSeatClass(seat_class!, widget.event.id!, number_of_ticket!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get a Ticket'),),
      body: Column(
        children: [
          Text('Available VIP Seats: '+widget.event.total_available_vip_seat.toString()+'/'+widget.event.total_vip_seat.toString()),
          Text('Available Reguler Seats: '+widget.event.total_available_reguler_seat.toString()+'/'+widget.event.total_reguler_seat.toString()),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField(
            // Initial Value
            //value: dropDownValue,
            hint: Text('Choose a Seat Class'),
            icon: const Icon(Icons.keyboard_arrow_down),

            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onSaved: (String? value) {
              setState(() {
                seat_class = value;
              });
            },
            onChanged: (String? newValue) {
              setState(() {
                seat_class = newValue!;
                print(seat_class);
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField(
            hint: Text('Choose Number of Tickets'),
            icon: const Icon(Icons.keyboard_arrow_down),

            items: seats.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onSaved: (String? value) {
              setState(() {
                number_of_ticket = int.parse(value!);
              });
            },
            onChanged: (String? newValue) {
              setState(() {
                number_of_ticket = int.parse(newValue!);
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField(
            hint: Text('Choose The Method'),
            icon: const Icon(Icons.keyboard_arrow_down),

            items: methods.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onSaved: (String? value) {
              setState(() {
                action = value!;
              });
            },
            onChanged: (String? newValue) {
              setState(() {
                action = newValue!;
              });
            },
          ),

          SizedBox(
            height: 10.0,
          ),
          // isAvailable == false? Center(child: Text('Not Available...')) :
          TextField(
            style: TextStyle(color: Colors.black),
            onChanged: (value) {
              seat_number_from = value;
            },
            decoration: kInputDecorations.copyWith(hintText: 'Enter SeatNumber From'),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            style: TextStyle(color: Colors.black),
            onChanged: (value) {
              seat_number_to = value;
            },
            decoration: kInputDecorations.copyWith(hintText: 'Enter SeatNumber To'),
          ),
          SizedBox(
            height: 10.0,
          ),
          RoundedButton(
              title: 'Book/Purchase',
              color: Colors.lightBlue,
              onPress: () async {
                int price = seat_class!.toLowerCase() == 'vip' ? (widget.event.vip_seat_price! * number_of_ticket!) : (widget.event.reguler_seat_price! * number_of_ticket!);
                String seat_number = seat_number_from! + ' to ' + seat_number_to!;
                Ticket ticket = Ticket(event_id: widget.event.id, seat_class: seat_class, price: price,seat_number: seat_number, status: action!.toLowerCase() == 'book' ? 'Payment Pending':'Payment Complete',number_of_tickets: number_of_ticket!);
                int res = await DatabaseHelper.instance.insertTicket(ticket, action!, widget.customer_id!);
                print(res);
              }),

        ],
      ),
    );
  }
}
