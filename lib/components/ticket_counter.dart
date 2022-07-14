import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/utils/addtocartanimation/add_to_cart_icon.dart';
import 'package:provider/provider.dart';

class TicketCounter extends StatelessWidget {
  const TicketCounter({
    Key? key,
    this.gkItem,
  }) : super(key: key);

  final GlobalKey<CartIconKey>? gkItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Ticket',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          width: 5,
        ),
        Stack(
          children: [
            SvgPicture.asset(
              'assets/images/Ticket White.svg',
              color: Colors.black,
              height: 36,
              width: 27,
            ),
            Positioned(
              key: gkItem,
              child: Builder(
                builder: (context) {
                  int totalTicketCount = 0;
                  for (var ticketItem
                      in Provider.of<TicketController>(context).ticketList) {
                    totalTicketCount = totalTicketCount + ticketItem.quantity;
                  }
                  return Text(
                    '$totalTicketCount',
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
              top: 8,
              left: 8,
            ),
          ],
        ),
      ],
    );
  }
}
