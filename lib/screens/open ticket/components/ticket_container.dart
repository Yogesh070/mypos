// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/screens/open%20ticket/tickets_screen.dart';
// import 'package:mypos/controllers/ticket.dart';
// import 'package:mypos/screen/openticket/tickets_screen.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class TicketContainer extends StatefulWidget {
  const TicketContainer({Key? key}) : super(key: key);

  @override
  State<TicketContainer> createState() => _TicketContainerState();
}

class _TicketContainerState extends State<TicketContainer> {
  late List<Bill> _openTickets;
  @override
  void initState() {
    super.initState();
    _openTickets = Provider.of<TicketController>(context, listen: false)
        .getBillsFromHive()
        .where((element) => !element.isPaid!)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // var _controller = Provider.of<TicketProvider>(context);
    var _itemCon = Provider.of<TicketController>(context);
    return Container(
      // height: 78,
      decoration: BoxDecoration(
        color: kDefaultGreen,
        borderRadius: BorderRadius.circular(5),
      ),
      // padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // context.go('/ticket');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicketsScreen(),
                  ),
                );
              },
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Open Tickets',
                    style: kSemiLargeText,
                  ),
                  Text(
                    _openTickets.length.toString(),
                    // 'Ticket lenght in int',
                    style: kSemiLargeText,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: kDefaultBackgroundColor),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Amount',
                    style: kSemiLargeText,
                  ),
                  Text(
                    _itemCon.ticketList.isNotEmpty
                        ? _itemCon.calculateTotal(_itemCon.ticketList)
                        : '0.0',
                    style: kSemiLargeText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
