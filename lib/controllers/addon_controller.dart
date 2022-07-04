// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:mypos/model/addon.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mypos/utils/boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

class AddonController extends ChangeNotifier {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.buzz-test.tk/api/v1',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );
  List<Addon> _addon = [];
  List<Addon> get allAddon {
    // getAllAddons();
    return _addon;
  }

  Future<List<Addon>> getAllAddons() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString('business_id');

    try {
      var res = await dio.get(
        '/business/$id/addons',
        options: Options(
          headers: {
            "businessId": "Bearer $id",
          },
        ),
      );
      print(res.data);
      _addon = List<Addon>.from(res.data['data'].map((e) => Addon.fromJson(e)));
      notifyListeners();
      return _addon;
    } on DioError catch (e) {
      Box<Addon> addonBox = Boxes.getAddon();
      _addon = addonBox.values.toList();
      notifyListeners();
      throw Exception(e);
    }
  }

  Box<Addon> addonBox = Boxes.getAddon();
  Future<void> addAddon(Addon addon) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // await Hive.openBox<Addon>('addon');

    String token = _prefs.getString('u_token')!;
    String id = _prefs.getString('business_id')!;

    try {
      http.Response res = await http.post(
        Uri.parse('https://api.buzz-test.tk/api/v1/business/$id/addons'),
        body: jsonEncode(addon.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );

      if (res.statusCode == 200) {
        Addon toPushAddon = Addon.fromJson(jsonDecode(res.body)['data']);
        // toPushAddon.isSynced = true;
        // addAddonInHive(toPushAddon, toPushAddon.id);
        // _addon = addonBox.values.toList();
        _addon.add(toPushAddon);
        notifyListeners();
      }
    } on SocketException catch (e) {
      throw Exception(e);
      // Addon toPushAddon = Addon(
      //   id: '66',
      //   maxAvailable: addon.maxAvailable,
      //   name: addon.name,
      //   price: addon.price,
      //   description: addon.description,
      //   isSynced: false,
      // );
      // addAddonInHive(toPushAddon, toPushAddon.id);

      // _addon = addonBox.values.toList();
      // notifyListeners();
    }
  }

  var uuid = const Uuid();

  void addAddonOnOffline(Addon addon) {
    Addon toPushAddon = Addon(
      id: uuid.v1(),
      maxAvailable: addon.maxAvailable,
      name: addon.name,
      price: addon.price,
      description: addon.description,
      isSynced: false,
    );
    addAddonInHive(toPushAddon, toPushAddon.id);

    _addon = addonBox.values.toList();
    notifyListeners();
  }

  void syncAddon() {
    for (var addon in addonBox.values) {
      if (!addon.isSynced!) {
        addAddon(addon).then((value) => addonBox.delete(addon.id));
      }
    }
  }

  void updateAddon(Addon addon) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessID = _prefs.getString('business_id')!;
    print(addon.id);
    try {
      http.Response res = await http.put(
        Uri.parse(
            'https://api.buzz-test.tk/api/v1/business/$businessID/addons/${addon.id}'),
        body: jsonEncode(addon.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        _addon[_addon.indexWhere((element) => element.id == addon.id)] =
            Addon.fromJson(jsonDecode(res.body)['data']);
        notifyListeners();
      }
      // addAddonInHive(addon);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void deleteAddon(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessId = _prefs.getString('business_id')!;
    try {
      Response res = await dio.delete(
        '/business/$businessId/addons/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "id": id,
            "businessId": businessId,
          },
        ),
      );
      print(res.data);

      if (res.statusCode == 200) {
        _addon.removeWhere((element) => element.id == id);
        // deleteAddonInHive(id);
        notifyListeners();
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  final box = Boxes.getAddon();
  void addAddonInHive(Addon addon, String id) async {
    box.put(id, addon);
  }

  void updateAddonInHive(Addon addon, String id) {
    box.put(id, addon);
  }

  void deleteAddonInHive(String id) {
    box.delete(id);
  }
}
