// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/controllers/product_controller.dart';
import 'package:mypos/screens/payment/cash_payment.dart';

import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';
// import 'cash_payment.dart';
// import 'completeaction.dart';

class PaymentMethod extends StatelessWidget {
  final String totalAmount;

  const PaymentMethod({Key? key, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: const Text(
          'Payment Method',
          style: kAppBarText,
        ),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            heightFactor: 2.5,
            child: CustomColumn(
              rate: 'Rs. $totalAmount',
              title: 'Total Amount',
            ),
          ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            children: [
              ListTilePayment(
                title: 'Cash',
                image: 'assets/images/money.png',
                onTap: () {
                  context.goNamed('cash');
                },
              ),
              const Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
              const SizedBox(height: 15),
              ListTilePayment(
                title: 'Card',
                image: 'assets/images/credit-cards.png',
                onTap: () {},
              ),
              const Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
              const SizedBox(height: 15),
              ListTilePayment(
                title: 'Online',
                image: 'assets/images/online-payment.png',
                onTap: () {},
              ),
              const Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
              const SizedBox(height: 15),
              ListTilePayment(
                title: 'Credit',
                image: 'assets/images/credit.png',
                onTap: () {},
              ),
              const Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
            ],
          )
              // // children: [
              // //   ListTile(
              // //     contentPadding: EdgeInsets.zero,
              // //     leading: Image.asset(
              // //       'assets/images/moneyy.png',
              // //       width: 19,
              // //     ),
              // //     minLeadingWidth: 15,
              // //     title: const Text(
              // //       'Cash',
              // //       style: TextStyle(fontSize: 18),
              // //     ),
              // //     onTap: () {
              // //       Navigator.push(
              // //         context,
              // //         MaterialPageRoute(
              // //           builder: (context) => CashPayment(),
              // //         ),
              // //       );
              // //     },
              // //   ),
              // //   Divider(
              // //     thickness: 1,
              // //     indent: 20,
              // //     endIndent: 40,
              // //   ),
              // //   ListTile(
              // //     leading: CircleAvatar(
              // //       backgroundImage: AssetImage("assets/images/credit.jpg"),
              // //     ),
              // //     title: Text('Card'),
              // //     onTap: () {},
              // //   ),
              // //   Divider(
              // //     thickness: 1,
              // //     indent: 60,
              // //     endIndent: 40,
              // //   ),
              // //   ListTile(
              // //     leading: CircleAvatar(
              // //       backgroundImage: AssetImage("assets/images/mobile.png"),
              // //     ),
              // //     onTap: () {},
              // //     title: Text('Online'),
              // //   ),
              // //   Divider(
              // //     thickness: 1,
              // //     indent: 60,
              // //     endIndent: 40,
              // //   ),
              // //   ListTile(
              // //     leading: CircleAvatar(
              // //       backgroundImage: AssetImage("assets/images/star.png"),
              // //     ),
              // //     onTap: () {},
              // //     title: Text('Credt'),
              // //   ),
              // //   const Divider(
              // //     thickness: 1,
              // //     indent: 60,
              // //     endIndent: 40,
              // //   ),
              // ],
              ),
        ],
      ),
    );
  }
}

class ListTilePayment extends StatelessWidget {
  const ListTilePayment(
      {Key? key, required this.image, this.onTap, required this.title})
      : super(key: key);
  final String title;
  final String image;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          image,
          width: 19,
        ),
        minLeadingWidth: 15,
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        onTap: onTap);
  }
}

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    Key? key,
    required this.rate,
    required this.title,
  }) : super(key: key);

  final String rate;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          rate,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
