// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/screens/widgets/timeago.dart';
import 'receiptdetails.dart';

import 'package:provider/provider.dart';

class RecieptScreen extends StatelessWidget {
  const RecieptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Receipt Added");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff30B700),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Icon(Icons.sort)
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  color: const Color(0xffE0E0E0),
                  child: const Text('Tuesday, 29 June'),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      Provider.of<TicketController>(context, listen: false)
                          .bills
                          .map(
                            (bill) => BillCard(
                              index: Provider.of<TicketController>(context,
                                          listen: false)
                                      .bills
                                      .indexOf(bill) +
                                  1,
                              bill: bill,
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BillCard extends StatelessWidget {
  final int index;
  final Bill bill;

  const BillCard({Key? key, this.index = 1, required this.bill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          title: Text(
            '#100-00$index',
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
          ),
          subtitle: Text(
            TimeAgo.timeAgoSinceDate(bill.addedAt!),
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
          trailing: Text(
            Provider.of<TicketController>(context).calculateTotal(bill.items),
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReceiptDetails(
                  bill: bill,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
