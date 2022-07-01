// import 'package:buzzpos/controller/customer_controller.dart';
// import 'package:buzzpos/controller/ticket.dart';
// import 'package:buzzpos/model/bill.dart';
// import 'package:buzzpos/screen/item/edit_qty_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:buzzpos/components/primary_button.dart';
// import 'package:buzzpos/controller/items_controller.dart';
// import 'package:buzzpos/screen/split/paymentmethod.dart';
// import 'package:buzzpos/screen/widgets/menu_items.dart';
// import 'package:buzzpos/utils/constant.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

// // ignore: must_be_immutable
// class TicketEditScreen extends StatefulWidget {
//   const TicketEditScreen({Key? key}) : super(key: key);

//   @override
//   State<TicketEditScreen> createState() => _TicketEditScreenState();
// }

// class _TicketEditScreenState extends State<TicketEditScreen> {
//   late final List<TicektItem> ticketList;
//   @override
//   void initState() {
//     ticketList =
//         Provider.of<ItemsController>(context, listen: false).ticketList;
//     print(ticketList);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var itemsCon = Provider.of<ItemsController>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             const Text(
//               'Ticket',
//               style: kAppBarText,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Stack(
//               children: [
//                 SvgPicture.asset(
//                   'assets/images/Ticket White.svg',
//                   color: Colors.black,
//                   height: 36,
//                   width: 27,
//                 ),
//                 Positioned(
//                   child: Text(
//                     '${Provider.of<ItemsController>(context).ticketList.length}',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   top: 8,
//                   left: 8,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         elevation: 0,
//         titleSpacing: 10,
//         leading: GestureDetector(
//           child: const Icon(Icons.arrow_back_ios_new),
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               itemsCon.clearAllItems();
//               itemsCon.total = 0;
//             },
//             style: TextButton.styleFrom(
//               primary: const Color(0xff30B700),
//             ),
//             child: const Text('Clear Ticket'),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Items Ordered',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 16),
//             AnimatedList(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               key: itemsCon.itemKey,
//               initialItemCount: itemsCon.ticketList.length,
//               itemBuilder: (context, index, animation) {
//                 return FadeTransition(
//                   opacity: animation,
//                   child: _builtAddItemList(itemsCon, index, context),
//                 );
//               },
//             ),
//             // ...List.generate(items.ticketList.length, (index) {
//             //   final ticket = items.ticketList[index];
//             //   return MenuItemText(
//             //       onEdit: (context) {
//             //         Navigator.push(
//             //             context,
//             //             MaterialPageRoute(
//             //               builder: (context) => EditQuantityScreen(
//             //                 ticektItem: ticket,
//             //                 index: index,
//             //               ),
//             //             ));
//             //       },
//             //       onDelete: (context) {
//             //         items.removeAtIndex(ticket);
//             //       },
//             //       itemName: '${ticket.item!.name}',
//             //       itemQuantity: '${ticket.quantity}',
//             //       itemRate: '${ticket.item!.price}');
//             // }),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Divider(
//                 thickness: 1,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Total',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Text(
//                   itemsCon.ticketList.isEmpty
//                       ? 'Rs. 0.0'
//                       : 'Rs. ${itemsCon.total}',
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16.5),
//             Row(
//               children: [
//                 Expanded(
//                   child: PrimaryButton(
//                     title: 'Save Order',
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     onPressed: () {
//                       Bill toAddBill = Bill(
//                         addedAt: DateTime.now(),
//                         id: const Uuid().v1(),
//                         items: ticketList,
//                       );

//                       if (Provider.of<CustomerController>(context,
//                                   listen: false)
//                               .selectedCustomerForTicket !=
//                           null) {
//                         toAddBill.customer = Provider.of<CustomerController>(
//                                 context,
//                                 listen: false)
//                             .selectedCustomerForTicket!;
//                       }
//                       if (ticketList.isNotEmpty) {
//                         Provider.of<TicketProvider>(context, listen: false)
//                             .addToBill(toAddBill);

//                         // print(itemsCon.ticketList.map((e) => e.item!.name));

//                         // print(Provider.of<TicketProvider>(context, listen: false)
//                         //     .bills);
//                         if (Provider.of<CustomerController>(context,
//                                     listen: false)
//                                 .selectedCustomerForTicket !=
//                             null) {
//                           Provider.of<CustomerController>(context,
//                                   listen: false)
//                               .removeCustomerFromTicket();
//                         }

//                         // itemsCon.clearAllItems();

//                         // itemsCon.total = 0;
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                 ),
//                 const VerticalDivider(
//                   width: 1,
//                 ),
//                 Expanded(
//                   child: PrimaryButton(
//                     title: 'Procced to Pay',
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const PaymentMethod(),
//                       ));
//                     },
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                   ),
//                 ),
//                 // PrimaryButton(
//                 //   title: 'Save Order',
//                 //   onPressed: () {},
//                 //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
//                 // ),

//                 // PrimaryButton(
//                 //   title: 'Procced to Pay',
//                 //   onPressed: () {},
//                 //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _builtAddItemList(ItemsController itemsCon, int index, BuildContext context) {
//     final ticket = itemsCon.ticketList[index];
//     return MenuItemText(
//       onEdit: (context) {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EditQuantityScreen(
//                 ticektItem: ticket,
//               ),
//             ));
//       },
//       onDelete: (context) {
//         itemsCon.removeAtIndex(
//             ticket, index, _builtAddItemList(itemsCon, index, context));
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
// }
