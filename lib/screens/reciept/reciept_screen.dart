import 'package:flutter/material.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/screens/home/components/sidemenu.dart';
import 'package:mypos/screens/widgets/timeago.dart';
import 'receiptdetails.dart';
import '../../utils/helper.dart';
import 'package:provider/provider.dart';

class RecieptScreen extends StatefulWidget {
  const RecieptScreen({Key? key}) : super(key: key);

  @override
  State<RecieptScreen> createState() => _RecieptScreenState();
}

class _RecieptScreenState extends State<RecieptScreen> {
  late List<Bill> _allBills;
  final TextEditingController _searchController = TextEditingController();
  List<Bill> searchedBills = [];
  @override
  void initState() {
    super.initState();
    _allBills = Provider.of<TicketController>(context, listen: false)
        .getBillsFromHive();
    _allBills.sort(((a, b) => a.addedAt!.compareTo(b.addedAt!)));
    _allBills.where((element) => element.isPaid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: const CustomAppBar(),
      drawer: const SideMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                    controller: _searchController,
                    onChanged: (val) {
                      setState(
                        () {
                          searchedBills = _allBills
                              .where((element) => element.items.any((element) =>
                                  element.item!.name
                                      .toLowerCase()
                                      .contains(val.toLowerCase())))
                              .toList();
                        },
                      );
                    },
                  ),
                ),
                const Icon(Icons.sort)
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
                itemCount: (_searchController.text.isEmpty)
                    ? _allBills.where((element) => element.isPaid!).length
                    : searchedBills.length,
                itemBuilder: (context, index) {
                  Bill bill;
                  if (_searchController.text.isNotEmpty) {
                    bill = searchedBills[index];
                  } else {
                    bill = _allBills
                        .where((element) => element.isPaid!)
                        .toList()[index];
                  }
                  return BillCard(
                    bill: bill,
                    index: index,
                  );
                }),
          ),
          //   Container(
          //     width: double.infinity,
          //     height: 30,
          //     alignment: Alignment.centerLeft,
          //     color: const Color(0xffE0E0E0),
          //     child: const Text('Tuesday, 29 June'),
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //   ),
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
            'Rs. ${calculateTotal(bill.items)}',
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
