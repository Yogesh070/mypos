// // ignore_for_file: unnecessary_string_interpolations

// import 'package:flutter/material.dart';
// import 'package:mypos/controller/ticket.dart';
// import 'package:mypos/screen/widgets/timeago.dart';
// import 'receiptdetails.dart';

// import 'package:provider/provider.dart';

// class RecieptScreen extends StatelessWidget {
//   const RecieptScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var _reciept = Provider.of<TicketProvider>(context);
//     return Scaffold(
//       backgroundColor: const Color(0xffF4F4F4),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           debugPrint("Receipt Added");
//         },
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         backgroundColor: const Color(0xff30B700),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//             child: Row(
//               children: const [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       suffixIcon: Icon(Icons.search),
//                     ),
//                   ),
//                 ),
//                 Icon(Icons.sort)
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: ListView(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 30,
//                   alignment: Alignment.centerLeft,
//                   color: const Color(0xffE0E0E0),
//                   child: const Text('Tuesday, 29 June'),
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(
//                     3,
//                     (index) => Cus(
//                       index: index + 1,
//                       date: _reciept.openTicketList[index].created!,
//                       time: TimeAgo.timeAgoSinceDate(
//                           _reciept.openTicketList[index].created!),
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => ReceiptDetails(
//                             index: index,
//                           ),
//                         ));
//                       },
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 16),
//                   width: double.infinity,
//                   height: 30,
//                   alignment: Alignment.centerLeft,
//                   color: const Color(0xffE0E0E0),
//                   child: const Text('Monday, 21 June'),
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(
//                     3,
//                     (index) => Cus(
//                       index: index + 1,
//                       date: _reciept.openTicketList[index].created!,
//                       time:
//                           '${TimeAgo.timeAgoSinceDate(_reciept.openTicketList[index].created!)}',
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => ReceiptDetails(
//                             index: index,
//                           ),
//                         ));
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Cus extends StatelessWidget {
//   const Cus({Key? key, required this.index, this.time, this.date, this.onTap})
//       : super(key: key);
//   final int index;
//   final String? time;
//   final DateTime? date;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ListTile(
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//           title: Text(
//             '#100-00$index',
//             style: const TextStyle(
//                 fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
//           ),
//           subtitle: Text(
//             time != null ? '$time' : '1:10 PM',
//             style: const TextStyle(fontSize: 12, color: Colors.black),
//           ),
//           trailing: const Text(
//             'Rs.1490',
//             style: TextStyle(
//                 fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
//           ),
//           onTap: onTap,
//         ),
//       ],
//     );
//   }
// }
