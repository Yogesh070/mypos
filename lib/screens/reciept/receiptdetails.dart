import 'package:flutter/material.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class ReceiptDetails extends StatelessWidget {
  final Bill bill;

  const ReceiptDetails({Key? key, required this.bill}) : super(key: key);

  String calculateGrandTotal() {
    double total = 0;
    for (var element in bill.items) {
      total = total + (element.item!.price * element.quantity);
    }
    return (total + 0.13 * total).toString();
  }

  @override
  Widget build(BuildContext context) {
    // var bill = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('#100-00'),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: const [
          RecieptMenuItems(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        children: [
          const Text(
            "Customer",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bill.customer?.name ?? 'No Customer',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                ),
              ),
              const Text(
                'Dine in',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(
                'Table no.',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          divider,
          const SizedBox(height: 16),
          const Text(
            "Items Ordered",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Column(
              children: bill.items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                item.item!.name,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'x ${item.quantity}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            '${item.item!.price}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()),
          const SizedBox(height: 16),
          divider,
          CustomRow(
            label: 'Total',
            trailing:
                'Rs. ${Provider.of<TicketController>(context).calculateTotal(bill.items)}',
          ),
          const CustomRow(
            label: 'Discount',
            trailing: '-',
          ),
          const CustomRow(
            label: 'Vat',
            trailing: '13%',
          ),
          const CustomRow(
            label: 'Service Charge',
            trailing: '10%',
          ),
          CustomRow(
            label: 'Grand Total',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            trailing: 'Rs ${calculateGrandTotal()}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: divider,
          ),
          const CustomRow(
            label: 'Cashier',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const CustomRow(
            label: 'Asim Poudel',
            trailing: 'Payment Mode: Cash',
          ),
          const CustomRow(
            label: 'Counter: POS12',
            trailing: 'Date: 21/06/2021',
          ),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key? key,
    required this.label,
    this.trailing,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);
  final String label;
  final String? trailing;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
          trailing != null
              ? Text(
                  '$trailing',
                  style: TextStyle(
                      fontSize: fontSize ?? 14,
                      fontWeight: fontWeight ?? FontWeight.w400),
                )
              : const Text(''),
        ],
      ),
    );
  }
}

class RecieptMenuItems extends StatelessWidget {
  const RecieptMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: GestureDetector(
            child: const Text(
              'Refund',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text(
            'Send receipt',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  onSelected(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        debugPrint('Refund pressed');
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const RefundScreen(),
        //   ),
        // );
        break;
      case 1:
        debugPrint('Send receipt pressed');
        break;
    }
  }
}
