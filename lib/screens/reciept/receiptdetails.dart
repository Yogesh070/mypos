// import 'package:flutter/material.dart';
// // import 'package:mypos/controller/ticket.dart';
// import 'refundscreen.dart';
// import 'package:mypos/utils/constant.dart';
// import 'package:provider/provider.dart';

// class ReceiptDetails extends StatelessWidget {
//   const ReceiptDetails({Key? key, required this.index}) : super(key: key);
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     // var _reciept = Provider.of<TicketProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('#100-00${index + 1}'),
//         leading: GestureDetector(
//           child: const Icon(Icons.arrow_back_ios_new),
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: const [
//           RecieptMenuItems(),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
//         children: [
//           const Text(
//             "Customer",
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${_reciept.openTicketList[index].name}',
//                 style: const TextStyle(
//                   decoration: TextDecoration.underline,
//                   fontSize: 14,
//                 ),
//               ),
//               const Text(
//                 'Dine in',
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//               Text(
//                 'Table no.${index + 1}',
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           divider,
//           const SizedBox(height: 16),
//           const Text(
//             "Items Ordered",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Column(
//             children: List.generate(
//               _reciept.itemsOrdered.length,
//               (index) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           '${_reciept.itemsOrdered[index].itemName}',
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'x ${_reciept.itemsOrdered[index].itemQuantity}',
//                           style: const TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       '${_reciept.itemsOrdered[index].itemRate}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           divider,
//           const CustomRow(
//             label: 'Total',
//             trailing: 'Rs 3000',
//           ),
//           const CustomRow(
//             label: 'Discount',
//             trailing: '-',
//           ),
//           const CustomRow(
//             label: 'Vat',
//             trailing: '13%',
//           ),
//           const CustomRow(
//             label: 'Service Charge',
//             trailing: '10%',
//           ),
//           const CustomRow(
//             label: 'Grand Total',
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             trailing: 'Rs 1832.7',
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 16),
//             child: divider,
//           ),
//           const CustomRow(
//             label: 'Cashier',
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//           const CustomRow(
//             label: 'Asim Poudel',
//             trailing: 'Payment Mode: Cash',
//           ),
//           const CustomRow(
//             label: 'Counter: POS12',
//             trailing: 'Date: 21/06/2021',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomRow extends StatelessWidget {
//   const CustomRow({
//     Key? key,
//     required this.label,
//     this.trailing,
//     this.fontSize,
//     this.fontWeight,
//   }) : super(key: key);
//   final String label;
//   final String? trailing;
//   final double? fontSize;
//   final FontWeight? fontWeight;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//                 fontSize: fontSize ?? 14,
//                 fontWeight: fontWeight ?? FontWeight.w400),
//           ),
//           trailing != null
//               ? Text(
//                   '$trailing',
//                   style: TextStyle(
//                       fontSize: fontSize ?? 14,
//                       fontWeight: fontWeight ?? FontWeight.w400),
//                 )
//               : const Text(''),
//         ],
//       ),
//     );
//   }
// }

// class RecieptMenuItems extends StatelessWidget {
//   const RecieptMenuItems({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       onSelected: (item) => onSelected(context, item),
//       itemBuilder: (context) => [
//         PopupMenuItem<int>(
//           value: 0,
//           child: GestureDetector(
//             child: const Text(
//               'Refund',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         const PopupMenuItem<int>(
//           value: 1,
//           child: Text(
//             'Send receipt',
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }

//   onSelected(BuildContext context, Object? item) {
//     switch (item) {
//       case 0:
//         debugPrint('Refund pressed');
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => const RefundScreen(),
//           ),
//         );
//         break;
//       case 1:
//         debugPrint('Send receipt pressed');
//         break;
//     }
//   }
// }
