import 'package:flutter/material.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/model/seats_table.dart';
import 'package:ticketing_system/model/ticket_table.dart';
import 'package:ticketing_system/roundButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unique_list/unique_list.dart';
class BookOrPurchaseTicket extends StatefulWidget {

  BookOrPurchaseTicket({required this.customer_id, required this.event});


  int? customer_id;
  Event event;

  @override
  State<BookOrPurchaseTicket> createState() => _BookOrPurchaseTicketState();
}

class _BookOrPurchaseTicketState extends State<BookOrPurchaseTicket> {
  String? action;

  String? seat_class='reguler';

  int? price;

  int? number_of_ticket=1;
  bool? isAvailable = false;

  String? dropDownValue;
  String? seat_number_from;
  String? seat_number_to;
  String? seatN;
  String? seatNum;
  var items = ['Reguler','VIP'];
  var methods = ['Purchase Ticket','Book Ticket'];
  var seats = ['1','2','3','4','5','6','7','8','9','10'];
  List<String>? vipSeats= UniqueList<String>();
  List<String>? regulerSeats= UniqueList<String>();

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

  void getAvailableSeats() async {
    List<SeatTable> vip = await DatabaseHelper.instance.getVIPAvailableSeats(widget.event.id!);
    List<SeatTable> reguler = await DatabaseHelper.instance.getRegulerAvailableSeats(widget.event.id!);
    List<String> re = [];
    List<String> vi = [];
    for (SeatTable v in vip){
      vipSeats!.add(v.seat_number!);
    }
    for (SeatTable r in reguler){
      regulerSeats!.add(r.seat_number!);
    }


    setState((){});

  }

  void checkForAvailable() async {
    isAvailable = await DatabaseHelper.instance.isAvailableSeatClass(seat_class!, widget.event.id!, number_of_ticket!);
  }

  @override
  void initState() {
    super.initState();
    getAvailableSeats();
    print(vipSeats);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Get a Ticket'),),
      body: SingleChildScrollView(
        child: Column(
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
            // SizedBox(
            //   height: 10.0,
            // ),
            // DropdownButtonFormField(
            //   // Initial Value
            //   //value: dropDownValue,
            //   hint: Text('Choose a Seat Class'),
            //   icon: const Icon(Icons.keyboard_arrow_down),
            //
            //   items: vipSeats!.map((String items) {
            //     return DropdownMenuItem(
            //       value: items,
            //       child: Text(items),
            //     );
            //   }).toList(),
            //   onSaved: (String? value) {
            //     setState(() {
            //       seatNum = value;
            //     });
            //   },
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       seatNum = newValue!;
            //       print(seatNum);
            //     });
            //   },
            // ),
            SizedBox(
              height: 10.0,
            ),
            seat_class!.toLowerCase() == 'reguler' ? DropdownButtonFormField(
              // Initial Value
              //value: dropDownValue,
              hint: Text('Choose a Seat Number'),
              icon: const Icon(Icons.keyboard_arrow_down),

              items: regulerSeats!.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList() ,
              //       :
              // vipSeats!.map((String items) {
              //   return DropdownMenuItem(
              //   value: items,
              //   child: Text(items),
              //   );
              //   }).toList(),
              onSaved: (String? value) {
                setState(() {
                  seatN = value;
                });
              },
              onChanged: (String? newValue) {
                setState(() {
                  seatN = newValue!;
                  print(seatN);
                });
              },
            ) : SizedBox(height: 1.0,),
            seat_class!.toLowerCase() == 'vip' ? DropdownButtonFormField(
              // Initial Value
              //value: dropDownValue,
              hint: Text('Choose a Seat Number'),
              icon: const Icon(Icons.keyboard_arrow_down),

              items: vipSeats!.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList() ,
              //       :
              // vipSeats!.map((String items) {
              //   return DropdownMenuItem(
              //   value: items,
              //   child: Text(items),
              //   );
              //   }).toList(),
              onSaved: (String? value) {
                setState(() {
                  seatN = value;
                });
              },
              onChanged: (String? newValue) {
                setState(() {
                  seatN = newValue!;
                  print(seatN);
                });
              },
            ) : SizedBox(height: 1.0,),


            SizedBox(
              height: 10.0,
            ),
            // DropdownButtonFormField(
            //   // Initial Value
            //   //value: dropDownValue,
            //   hint: Text('Avaialable Reguler Seats'),
            //   icon: const Icon(Icons.keyboard_arrow_down),
            //
            //   items: regulerSeats.map((String items) {
            //     return DropdownMenuItem(
            //       value: items,
            //       child: Text(items),
            //     );
            //   }).toList(),
            //   onSaved: (String? value) {
            //     setState(() {
            //       seatN = value;
            //     });
            //   },
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       seatN = newValue!;
            //       // print(seat_class);
            //     });
            //   },
            // ),
            SizedBox(
              height: 10.0,
            ),
            // DropdownButtonFormField(
            //   hint: Text('Choose Number of Tickets'),
            //   icon: const Icon(Icons.keyboard_arrow_down),
            //
            //   items: seats.map((String items) {
            //     return DropdownMenuItem(
            //       value: items,
            //       child: Text(items),
            //     );
            //   }).toList(),
            //   onSaved: (String? value) {
            //     setState(() {
            //       number_of_ticket = int.parse(value!);
            //     });
            //   },
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       number_of_ticket = int.parse(newValue!);
            //     });
            //   },
            // ),
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
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
                title: 'Book/Purchase',
                color: Colors.lightBlue,
                onPress: () async {
                  int price = seat_class!.toLowerCase() == 'vip' ? (widget.event.vip_seat_price! * number_of_ticket!) : (widget.event.reguler_seat_price! * number_of_ticket!);
                  // String seat_number = seat_number_from! + ' to ' + seat_number_to!;
                  Ticket ticket = Ticket(event_id: widget.event.id, seat_class: seat_class, price: price,seat_number: seatN, status: action!.toLowerCase() == 'book' ? 'Payment Pending':'Payment Complete',number_of_tickets: number_of_ticket!);
                  int res = await DatabaseHelper.instance.insertTicket(ticket, action!, widget.customer_id!);
                  print('Checking Response: '+res.toString());
                  if (res <= 0){
                    var fToast = FToast();
                    fToast.init(context);
                    fToast.showToast(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.red,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.not_interested),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text("Tickets Seats are not Available"),
                          ],
                        ),),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: Duration(seconds: 2),
                    );
                  }
                  else{
                    var fToast = FToast();
                    fToast.init(context);
                    fToast.showToast(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.green,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.done),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text("Tickets ${action}ed"),
                          ],
                        ),),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: Duration(seconds: 2),
                    );
                  }
                  print(res);
                }),

          ],
        ),
      ),
    );
  }
}
