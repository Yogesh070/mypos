// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/model/ticket_item.dart';
import 'package:mypos/utils/boxes.dart';

class TicketController extends ChangeNotifier {
  List<Bill> bills = [];
  List<Bill> _openTickets = [];

  List<Bill> get openTickets => _openTickets;
  int openTicketCount = 0;

  void addToBill(Bill bill) {
    bills.add(bill);
    notifyListeners();
    addBillInHive(bill);
    clearTicket();
  }

  List<Bill> getBills() {
    final billBox = Boxes.getBills();
    bills = billBox.values.toList();
    notifyListeners();
    return bills;
  }

  void addBillInHive(Bill bill) async {
    print('Trying to add in hive');
    print(bill.toJson());
    final billBox = Boxes.getBills();
    await billBox.put(bill.id, bill);
  }

  List<Bill> getBillsFromHive() {
    final billBox = Boxes.getBills();
    return billBox.values.toList();
  }

  // void addToOpenTickets(Bill bill) {
  //   openTickets.add(bill);
  //   notifyListeners();
  //   addBillInHive(bill);
  // }

  // List<Bill> getOpenTickets() {
  //   final billBox = Boxes.getBills();
  //   openTickets = billBox.values.toList();
  //   notifyListeners();
  //   return openTickets;
  // }

  void deleteBillFromHive(String id) {
    final billBox = Boxes.getBills();

    billBox.delete(id);
  }

  final GlobalKey<AnimatedListState> openTicketKey = GlobalKey();

//Ticket ko kam yeta
  List<TicketItem> _ticketList = [];
  List<TicketItem> get ticketList => _ticketList;

  void addProductToCart(Item item) {
    for (TicketItem ticketItem in _ticketList) {
      if (ticketItem.item!.id == item.id) {
        ticketItem.increment();
        notifyListeners();
        return;
      }
    }
    _ticketList.add(TicketItem(item: item));
    notifyListeners();
    print(_ticketList);
  }

  void removeItemFromCart(String id) {
    _ticketList.removeWhere((ticket) => ticket.item!.id == id);
    notifyListeners();
  }

  void clearTicket() {
    print('clearing tickets');
    // _ticketList.clear();
    _ticketList = [];
    notifyListeners();
  }

  void updateOpenTicketCount() {
    openTicketCount = 0;
    final billBox = Boxes.getBills();
    for (var element in billBox.values) {
      if (!element.isPaid!) {
        openTicketCount++;
      }
    }
  }

  void incrementOpenTicketCount() {
    openTicketCount++;
    notifyListeners();
  }

  void deleteTicket(String id) {
    _openTickets.removeWhere((element) => element.id == id);
    deleteBillFromHive(id);
    openTicketCount--;
    notifyListeners();
  }

  void initOpenTicket() {
    _openTickets =
        getBillsFromHive().where((element) => !element.isPaid!).toList();
  }
}
