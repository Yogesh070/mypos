import 'package:flutter/cupertino.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/model/ticket_item.dart';
import 'package:mypos/utils/boxes.dart';

class TicketController extends ChangeNotifier {
  List<Bill> bills = [];

  void addToBill(Bill bill) {
    bills.add(bill);
    notifyListeners();
    // final billBox = Boxes.getBills();
    // billBox.put(bill.id, bill);
  }

  List<Bill> getBills() {
    final billBox = Boxes.getBills();
    bills = billBox.values.toList();
    notifyListeners();
    return bills;
  }

  final GlobalKey<AnimatedListState> openTicketKey = GlobalKey();

//Ticket ko kam yeta
  final List<TicketItem> _ticketList = [];
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

  void clearTicket() {
    _ticketList.clear();
    notifyListeners();
  }

  String calculateTotal(List<TicketItem> ticketItems) {
    double total = 0;
    for (var element in ticketItems) {
      total = total + (element.item!.price * element.quantity);
    }
    return total.toString();
  }
}
