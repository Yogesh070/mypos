// import 'package:flutter/material.dart';
// import 'package:mypos/components/adds_on_tilte.dart';
// import 'package:mypos/controllers/ticket.dart';
// import 'package:mypos/utils/constant.dart';

// class AddOnsListBuilder extends StatelessWidget {
//   const AddOnsListBuilder({
//     Key? key,
//     required TicketProvider controller,
//   })  : _controller = controller,
//         super(key: key);

//   final TicketProvider _controller;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         final addsOns = _controller.addsOn[index];
//         return AddsOnTile(
//           name: addsOns.addonsName,
//           isChecked: addsOns.isChecked,
//           chechBoxCallback: (value) {
//             _controller.changeAddsOnValue(index);
//           },
//           onTap: () {
//             _controller.changeAddsOnValue(index);
//           },
//         );
//       },
//       separatorBuilder: (context, index) => divider,
//       itemCount: _controller.addsOn.length,
//     );
//   }
// }
