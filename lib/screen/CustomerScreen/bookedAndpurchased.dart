import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/ticket_table.dart';


class AllPurchasedAndBookedTickets extends StatefulWidget {
  // const AllPurchasedAndBookedTickets({Key? key}) : super(key: key);
  AllPurchasedAndBookedTickets({required this.event_id});
  int? event_id;
  @override
  State<AllPurchasedAndBookedTickets> createState() => _AllPurchasedAndBookedTicketsState();
}

class _AllPurchasedAndBookedTicketsState extends State<AllPurchasedAndBookedTickets> {

  List<Ticket>? allTickets;

  void getAllTickets() async {
    allTickets = await DatabaseHelper.instance.getBookedAndPurchashedTickets(widget.event_id!);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
