// import 'package:flutter/material.dart';
// import 'package:mypos/components/primary_button.dart';
// import 'package:mypos/model/bill.dart';
// // import 'package:mypos/controllers/ticket.dart';
// // import 'package:mypos/screens/split/paymentmethod.dart';
// import 'package:mypos/screens/widgets/menu_items.dart';
// import 'package:mypos/utils/constant.dart';
// import 'package:provider/provider.dart';
// // import 'edit_item_screen.dart';

// class TicketDetail extends StatelessWidget {
//   // final int index;
//   // const TicketDetail(this.index, {Key? key}) : super(key: key);
//   final Bill openTicket;

//   const TicketDetail({Key? key, required this.openTicket}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // var _controller = Provider.of<TicketProvider>(context);
//     return Scaffold(
//       backgroundColor: const Color(0xffF4F4F4),
//       appBar: AppBar(
//         elevation: 0,
//         titleSpacing: 10,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios_new),
//         ),
//         title: Text(
//           // '${_controller.openTicketList[index].name}',
//           openTicket.id.toString(),
//           style: kAppBarText,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 5),
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(width: 0.2),
//                   ),
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     // showShipDialog(context, _controller);
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           // _controller.shippingItem.value.shippingName,
//                           'dd'
//                         ),
//                       ),
//                       const Icon(
//                         Icons.arrow_drop_down,
//                         size: 30,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Items Ordered',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     ListView.separated(
//                       physics: const ClampingScrollPhysics(),
//                       itemCount: _controller.itemsOrdered.length,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         final itemsOrdered = _controller.itemsOrdered[index];
//                         return MenuItemText(
//                           onDelete: (context) {
//                             _controller.dismisItemOrdered(itemsOrdered);
//                           },
//                           itemName: itemsOrdered.itemName ?? '',
//                           itemQuantity: itemsOrdered.itemQuantity,
//                           itemRate: itemsOrdered.itemRate,
//                           onTap: () {
//                             Provider.of<TicketProvider>(context, listen: false)
//                                 .toEditOrder = _controller.itemsOrdered[index];
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const EditItemScreen(),
//                               ),
//                             );
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) =>
//                             //         EditItemScreen(itemsOrdered),
//                             //   ),
//                             // );
//                           },
//                         );
//                       },
//                       separatorBuilder: (context, index) => sizeHeight(),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16.0),
//                       child: Divider(
//                         thickness: 1,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text(
//                           'Total',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           'Rs. 3000',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16.5),
//               Row(
//                 children: [
//                   Expanded(
//                     child: PrimaryButton(
//                       title: 'Save Order',
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       onPressed: () {},
//                     ),
//                   ),
//                   const VerticalDivider(
//                     width: 1,
//                   ),
//                   Expanded(
//                     child: PrimaryButton(
//                       title: 'Procced to Pay',
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const PaymentMethod(),
//                         ));
//                       },
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                     ),
//                   ),
//                   // PrimaryButton(
//                   //   title: 'Save Order',
//                   //   onPressed: () {},
//                   //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
//                   // ),

//                   // PrimaryButton(
//                   //   title: 'Procced to Pay',
//                   //   onPressed: () {},
//                   //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   SizedBox sizeHeight() {
//     return const SizedBox(
//       height: 10,
//     );
//   }

//   void showShipDialog(BuildContext context, TicketProvider _controller) {
//     showGeneralDialog(
//       barrierLabel: "Barrier",
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: const Duration(milliseconds: 300),
//       context: context,
//       pageBuilder: (_, __, ___) {
//         return Container(
//           margin: const EdgeInsets.only(right: 15.0, top: 110),
//           child: Align(
//             alignment: Alignment.topRight,
//             child: Material(
//               color: Colors.transparent,
//               child: Container(
//                 width: 154,
//                 height: 150,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(
//                     _controller.shipping.length,
//                     (index) {
//                       return AnimatedBuilder(
//                         child: Text(_controller.shipping.toString()),
//                         animation: _controller.shippingItem,
//                         builder: (context, child) {
//                           return Transform.scale(
//                             scale: 0.9,
//                             child: RadioListTile<Shipping>(
//                               contentPadding: EdgeInsets.zero,
//                               dense: true,
//                               title: Text(
//                                 _controller.shipping[index].shippingName,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                               value: _controller.shipping[index],
//                               groupValue: _controller.shippingItem.value,
//                               onChanged: (value) {
//                                 _controller.selectedShippingRadio(value!);
//                               },
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
