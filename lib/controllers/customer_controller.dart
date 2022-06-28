// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:convert';
import 'package:mypos/model/customer.dart';
import 'package:mypos/utils/boxes.dart';
import 'package:mypos/utils/constant.dart';
import 'package:mypos/utils/helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomerController extends ChangeNotifier {
  UnmodifiableListView<Customer> get allCustomers =>
      UnmodifiableListView(_customer);

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.buzz-test.tk/api/v1',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );
  List<Customer> _customer = [];
  void getAllCustomers() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString('business_id');
    String token = _prefs.getString('u_token')!;
    try {
      var res = await dio.get(
        '/business/$id/customers',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print(res.data);
      _customer = List<Customer>.from(
          res.data['data']['customers'].map((e) => Customer.fromJson(e)));
      notifyListeners();
      print(_customer);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> addCustomer(
      Customer customer, BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessID = _prefs.getString('business_id')!;
    // final customerBox = Boxes.getCustomer();
    // customerBox.add(customer);
    // addCustomerInHive(customer);
    try {
      http.Response res = await http.post(
        Uri.parse(
            'https://api.buzz-test.tk/api/v1/business/$businessID/customers'),
        body: jsonEncode(customer.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);

      if (res.statusCode == 200) {
        _customer
            .add(Customer.fromJson(jsonDecode(res.body)['data']['customer']));
        notifyListeners();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Customer added Sucessfully'),
            backgroundColor: kDefaultGreen,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorIn(res, 'email')!),
            backgroundColor: Colors.red,
          ),
        );
      }

      return res;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<Customer> getSingleCustomer(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String businessID = _prefs.getString('business_id')!;
    try {
      http.Response res = await http.get(
        Uri.parse('https://api.buzz-test.tk/api/v1/business/$id/customers'),
        headers: {
          "businessId": "Bearer $businessID",
        },
      );

      return Customer.fromJson(jsonDecode(res.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateCustomer(Customer customer) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessID = _prefs.getString('business_id')!;
    print(customer.id);
    try {
      http.Response res = await http.put(
        Uri.parse(
            'https://api.buzz-test.tk/api/v1/business/$businessID/customers/${customer.id}'),
        body: jsonEncode(customer.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        // _customer.indexOf((element) => element.id == customer.id);
        _customer[
                _customer.indexWhere((element) => element.id == customer.id)] =
            Customer.fromJson(jsonDecode(res.body)['data']['customer']);
        notifyListeners();
      }

      // notifyListeners();
      // addAddonInHive(customer);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void deleteCustomer(String id) async {
    print('deleting customer with id' + id);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessId = _prefs.getString('business_id')!;
    print('/business/$businessId/customer/$id');
    try {
      var res = await dio.delete(
        '/business/$businessId/customers/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (res.statusCode == 200) {
        _customer.removeWhere((element) => element.id == id);
        notifyListeners();
      }
      print(res.data);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void addCustomerInHive(Customer customer) {
    final box = Boxes.getCustomer();
    // box.put(customer.id, customer);
    box.add(customer);
  }

  // void deleteCustomerInHive(String id) {
  //   final box = Boxes.getCustomer();
  //   box.delete(id);
  // }

  Customer? _selectedCustomer;

  Customer? get selectedCustomerForTicket => _selectedCustomer;

  void setCustomerInTicket(Customer customer) {
    _selectedCustomer = customer;
    print(customer.name + "added to ticket");
    notifyListeners();
  }

  void removeCustomerFromTicket() {
    print('removed customer form ticket' + _selectedCustomer!.name);
    _selectedCustomer = null;
    notifyListeners();
  }
}
