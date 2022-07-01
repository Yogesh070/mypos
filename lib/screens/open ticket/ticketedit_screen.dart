import 'package:mypos/controllers/customer_controller.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/bill.dart';
// import 'package:mypos/screen/item/edit_qty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mypos/components/primary_button.dart';
import 'package:mypos/model/ticket_item.dart';
import 'package:mypos/screens/widgets/menu_items.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TicketEditScreen extends StatefulWidget {
  const TicketEditScreen({Key? key}) : super(key: key);

  @override
  State<TicketEditScreen> createState() => _TicketEditScreenState();
}

class _TicketEditScreenState extends State<TicketEditScreen> {
  late final List<TicketItem> ticketList;
  // @override
  // void initState() {
  //   ticketList =
  //       Provider.of<TicketController>(context, listen: false).ticketList;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Ticket',
              style: kAppBarText,
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
                  child: Text(
                    '${Provider.of<TicketController>(context).ticketList.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  top: 8,
                  left: 8,
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<TicketController>(context, listen: false)
                  .clearTicket();
              //  Provider.of<TicketController>(context, listen: false).total = 0;
            },
            style: TextButton.styleFrom(
              primary: const Color(0xff30B700),
            ),
            child: const Text('Clear Ticket'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Items Ordered',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            AnimatedList(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // key:  Provider.of<TicketController>(context, listen: false).itemKey,
              initialItemCount:
                  Provider.of<TicketController>(context, listen: false)
                      .ticketList
                      .length,
              itemBuilder: (context, index, animation) {
                TicketItem item =
                    Provider.of<TicketController>(context, listen: false)
                        .ticketList[index];
                return FadeTransition(
                  opacity: animation,
                  // child: _builtAddItemList( Provider.of<TicketController>(context, listen: false), index, context),
                  child: MenuItemText(
                    itemName: item.item!.name,
                    itemQuantity: item.quantity,
                    itemRate: item.item!.price,
                  ),
                );
              },
            ),
            // ...List.generate(items.ticketList.length, (index) {
            //   final ticket = items.ticketList[index];
            //   return MenuItemText(
            //       onEdit: (context) {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => EditQuantityScreen(
            //                 ticektItem: ticket,
            //                 index: index,
            //               ),
            //             ));
            //       },
            //       onDelete: (context) {
            //         items.removeAtIndex(ticket);
            //       },
            //       itemName: '${ticket.item!.name}',
            //       itemQuantity: '${ticket.quantity}',
            //       itemRate: '${ticket.item!.price}');
            // }),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  Provider.of<TicketController>(context, listen: false)
                          .ticketList
                          .isEmpty
                      ? 'Rs. 0.0'
                      : 'Rs. ${Provider.of<TicketController>(context, listen: false).calculateTotal(Provider.of<TicketController>(context, listen: false).ticketList)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16.5),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    title: 'Save Order',
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {
                      Bill toAddBill = Bill(
                        addedAt: DateTime.now(),
                        id: const Uuid().v1(),
                        items: Provider.of<TicketController>(context,
                                listen: false)
                            .ticketList,
                      );

                      if (Provider.of<CustomerController>(context,
                                  listen: false)
                              .selectedCustomerForTicket !=
                          null) {
                        toAddBill.customer = Provider.of<CustomerController>(
                                context,
                                listen: false)
                            .selectedCustomerForTicket!;
                      }
                      if (Provider.of<TicketController>(context, listen: false)
                          .ticketList
                          .isNotEmpty) {
                        Provider.of<TicketController>(context, listen: false)
                            .addToBill(toAddBill);

                        print(toAddBill.toJson());

                        // print( Provider.of<TicketController>(context, listen: false).ticketList.map((e) => e.item!.name));

                        print(Provider.of<TicketController>(context,
                                listen: false)
                            .bills);
                        if (Provider.of<CustomerController>(context,
                                    listen: false)
                                .selectedCustomerForTicket !=
                            null) {
                          Provider.of<CustomerController>(context,
                                  listen: false)
                              .removeCustomerFromTicket();
                        }

                        Provider.of<TicketController>(context, listen: false)
                            .clearTicket();

                        //  Provider.of<TicketController>(context, listen: false).total = 0;
                        // Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                ),
                Expanded(
                  child: PrimaryButton(
                    title: 'Procced to Pay',
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const PaymentMethod(),
                      // ));
                    },
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                // PrimaryButton(
                //   title: 'Save Order',
                //   onPressed: () {},
                //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                // ),

                // PrimaryButton(
                //   title: 'Procced to Pay',
                //   onPressed: () {},
                //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//   _builtAddItemList(
//       TicketController  Provider.of<TicketController>(context, listen: false), int index, BuildContext context) {
//     final ticket =  Provider.of<TicketController>(context, listen: false).ticketList[index];
//     return MenuItemText(
//       onEdit: (context) {
//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) => EditQuantityScreen(
//         //         ticektItem: ticket,
//         //       ),
//         //     ));
//       },
//       onDelete: (context) {
//         //  Provider.of<TicketController>(context, listen: false).removeAtIndex(
//         //     ticket, index, _builtAddItemList( Provider.of<TicketController>(context, listen: false), index, context));
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             duration: Duration(milliseconds: 600),
//             content: Text('Ticket deleted Sucessfully'),
//             backgroundColor: kDefaultGreen,
//           ),
//         );
//       },
//       itemName: ticket.item!.name,
//       itemQuantity: '${ticket.quantity}',
//       itemRate: '${ticket.item!.price}',
//     );
//   }
}
