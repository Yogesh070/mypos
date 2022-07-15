import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mypos/model/ticket_item.dart';

String? errorIn(http.Response? r, String fieldName) {
  if (r != null) return jsonDecode(r.body)['data'][fieldName];
  return null;
}

final Connectivity _connectivity = Connectivity();
Future<bool> checkConnectivity() async {
  late ConnectivityResult result;
  try {
    result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  } on PlatformException catch (e) {
    throw Exception(e);
  }
}

String calculateTotal(List<TicketItem> ticketItems) {
  double total = 0;
  for (var element in ticketItems) {
    total = total + (element.item!.price * element.quantity);
  }
  return total.toString();
}
