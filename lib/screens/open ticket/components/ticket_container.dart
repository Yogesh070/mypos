import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';
import '../../../utils/helper.dart';

class TicketContainer extends StatefulWidget {
  const TicketContainer({Key? key}) : super(key: key);

  @override
  State<TicketContainer> createState() => _TicketContainerState();
}

class _TicketContainerState extends State<TicketContainer> {
  @override
  void initState() {
    super.initState();
    Provider.of<TicketController>(context, listen: false)
        .updateOpenTicketCount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 78,
      decoration: BoxDecoration(
        color: kDefaultGreen,
        borderRadius: BorderRadius.circular(5),
      ),
      // padding: EdgeInsets.all(20),
      child: Consumer<TicketController>(
        builder: (context, ticketProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.goNamed('open-ticket');
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Open Tickets',
                        style: kSemiLargeText,
                      ),
                      Text(
                        ticketProvider.openTicketCount.toString(),
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
                      left:
                          BorderSide(width: 1, color: kDefaultBackgroundColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Amount',
                        style: kSemiLargeText,
                      ),
                      Text(
                        ticketProvider.ticketList.isNotEmpty
                            ? calculateTotal(ticketProvider.ticketList)
                            : '0.0',
                        style: kSemiLargeText,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
