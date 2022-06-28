// import 'package:flutter/material.dart';
// import 'package:mypos/components/adds_on_tilte.dart';
// import 'package:mypos/controller/ticket.dart';
// import 'package:mypos/utils/constant.dart';

// class DiscountListBuilder extends StatelessWidget {
//   const DiscountListBuilder({
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
//         final discount = _controller.discounts[index];
//         return AddsOnTile(
//           name: discount.discountName,
//           isChecked: discount.isDiscountChecked,
//           chechBoxCallback: (value) {
//             _controller.changeDiscountSwitchValue(index);
//           },
//           onTap: () {
//             _controller.changeDiscountSwitchValue(index);
//           },
//         );
//       },
//       separatorBuilder: (context, index) => divider,
//       itemCount: _controller.discounts.length,
//     );
//   }
// }
