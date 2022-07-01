// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mypos/components/listile.dart';
import 'package:mypos/screens/widgets/timeago.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _controller = Provider.of<TicketProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          // 'Open Ticket (${_controller.openTicketList.length})',
          'Open Ticket 5',

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
              Container(
                padding: const EdgeInsets.only(left: 18),
                child: Transform.scale(
                  scale: 0.7,
                  child: Transform.translate(
                    offset: const Offset(0, 4),
                    child: Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
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
          // Expanded(
          //   child: AnimatedList(
          //     key: _controller.openTicketKey,
          //     initialItemCount: _controller.openTicketList.length,
          //     itemBuilder: (context, index, animation) {
          //       return FadeTransition(
          //         opacity: animation,
          //         child: _builtOpenTicket(_controller, index, context),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  // Slidable _builtOpenTicket(
  //     TicketProvider _controller, int index, BuildContext context) {
  //   final openTicket = _controller.openTicketList[index];
  //   return Slidable(
  //     endActionPane: ActionPane(
  //       extentRatio: 0.25,
  //       motion: const ScrollMotion(),
  //       children: [
  //         SlidableAction(
  //           autoClose: true,
  //           icon: Icons.delete,
  //           backgroundColor: Colors.red,
  //           foregroundColor: Colors.white,
  //           label: 'Delete',
  //           onPressed: (context) {
  //             _controller.dismisDelete(openTicket, index,
  //                 _builtOpenTicket(_controller, index, context));
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(
  //                 duration: Duration(milliseconds: 600),
  //                 content: Text('Ticket deleted Sucessfully'),
  //                 backgroundColor: kDefaultGreen,
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //     child: Container(
  //       decoration: const BoxDecoration(
  //           border: Border(
  //         bottom: BorderSide(color: kBorderColor, width: 1),
  //       )),
  //       child: TileListBox(
  //         merge: _controller.openTicketList[index].ismerged == true
  //             ? const Padding(
  //                 padding: EdgeInsets.all(4.0),
  //                 child: Text('Merge'),
  //               )
  //             : null,
  //         isChecked: openTicket.isChecked!,
  //         chechBoxCallback: (val) {
  //           _controller.changeSwitchValue(index);
  //         },
  //         onTap: () {
  //           // Navigator.push(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) => TicketDetail(index)),
  //           // );
  //         },
  //         created: TimeAgo.timeAgoSinceDate(openTicket.created!),
  //         taxTitle: '${openTicket.name}',
  //         amount: '${openTicket.amount}',
  //         iconData: Icons.person,
  //       ),
  //     ),
  //   );
  // }

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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 10),
                        child: Text(
                          "Sort By",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const Divider(
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

  // _buildItem(BuildContext context, TicketProvider _controller, index) {
  //   final openTicket = _controller.openTicketList[index];
  //   return TileListBox(
  //     merge: _controller.openTicketList[index].ismerged == true
  //         ? Padding(
  //             padding: const EdgeInsets.all(4.0),
  //             child: Text('Merge'),
  //           )
  //         : null,
  //     isChecked: openTicket.isChecked!,
  //     chechBoxCallback: (val) {
  //       _controller.changeSwitchValue(index);
  //     },
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => TicketDetail(index)),
  //       );
  //     },
  //     created: '${TimeAgo.timeAgoSinceDate(openTicket.created!)}',
  //     taxTitle: '${openTicket.name}',
  //     amount: '${openTicket.amount}',
  //     iconData: Icons.person,
  //   );
  // }
}
