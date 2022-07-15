import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/components/listile.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/screens/widgets/timeago.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';
import '../../utils/helper.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late List<Bill> _openTickets;
  bool isLoadedOnce = false;
  @override
  void initState() {
    super.initState();
    if (!isLoadedOnce) {
      _openTickets = Provider.of<TicketController>(context, listen: false)
          .getBillsFromHive()
          .where((element) => !element.isPaid!)
          .toList();
      setState(() {
        isLoadedOnce = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          'Open Ticket (${_openTickets.length})',
          style: kAppBarText,
        ),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: const [
          // TextButton(
          //   style: TextButton.styleFrom(
          //     primary: Color(0xff30B700),
          //   ),
          //   onPressed: () {},
          //   child: Text(
          //     'merge',
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   padding: const EdgeInsets.only(left: 18),
              //   child: Transform.scale(
              //     scale: 0.7,
              //     child: Transform.translate(
              //       offset: const Offset(0, 4),
              //       child: Checkbox(
              //         value: false,
              //         onChanged: (value) {},
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, top: 15, right: 15),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // showDialog(context, _controller);
                },
                icon: const Icon(Icons.sort),
                splashRadius: 20,
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: AnimatedList(
              initialItemCount: _openTickets.length,
              itemBuilder: (context, index, animation) {
                final openTicket = _openTickets[index];
                return FadeTransition(
                  opacity: animation,
                  child: Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          autoClose: true,
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Delete',
                          onPressed: (context) {
                            // _controller.dismisDelete(openTicket, index,
                            //     _builtOpenTicket(_controller, index, context));
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     duration: Duration(milliseconds: 600),
                            //     content: Text('Ticket deleted Sucessfully'),
                            //     backgroundColor: kDefaultGreen,
                            //   ),
                            // );
                          },
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: kBorderColor, width: 1),
                      )),
                      child: TileListBox(
                        // merge: Text('Merge'),
                        isChecked: false,
                        // merge: _controller.openTicketList[index].ismerged == true
                        //     ? const Padding(
                        //         padding: EdgeInsets.all(4.0),
                        //         child: Text('Merge'),
                        //       )
                        //     : null,
                        // isChecked: openTicket.isChecked!,
                        // chechBoxCallback: (val) {
                        //   _controller.changeSwitchValue(index);
                        // },
                        onTap: () {
                          context.goNamed(
                            'open-ticket-details',
                            params: {"tid": openTicket.id!},
                          );
                        },
                        created: TimeAgo.timeAgoSinceDate(openTicket.addedAt!),
                        taxTitle: '${openTicket.id}',
                        amount: 'Rs.${calculateTotal(openTicket.items)}',
                        iconData: Icons.person,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // void showDialog(BuildContext context, TicketProvider _controller) {
  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Container(
          margin: const EdgeInsets.only(right: 15.0, top: 90),
          child: Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 162,
                height: 220,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 10),
                        child: Text(
                          "Sort By",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Text('Radio OPtions here'),
                      // Column(
                      //   children: List.generate(
                      //     _controller.sortby.length,
                      //     (index) {
                      //       return AnimatedBuilder(
                      //         child: Text(_controller.sortby.toString()),
                      //         animation: _controller.selectedItem,
                      //         builder: (context, child) {
                      //           return Transform.scale(
                      //             scale: 0.9,
                      //             child: Text(
                      //               'Radio btn'
                      //             ),
                      //             // child: RadioListTile<SortBy>(
                      //             //   contentPadding: EdgeInsets.zero,
                      //             //   title: Text(
                      //             //     _controller.sortby[index].name,
                      //             //     style: const TextStyle(fontSize: 14),
                      //             //   ),
                      //             //   value: _controller.sortby[index],
                      //             //   groupValue: _controller.selectedItem.value,
                      //             //   onChanged: (value) {
                      //             //     _controller.selectedRadio(value!);
                      //             //     Navigator.pop(context);
                      //             //   },
                      //             // ),
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                    ]),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
