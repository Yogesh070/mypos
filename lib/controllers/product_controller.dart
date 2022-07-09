// ignore_for_file: avoid_print

import 'dart:io';

import 'package:mypos/model/item.dart';
import 'package:dio/dio.dart';
import 'package:mypos/utils/boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

class ProductController extends ChangeNotifier {
  List<Item> _product = [];
  List<Item> get allItem {
    // getAllItems();
    return _product;
  }

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.buzz-test.tk/api/v1',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );

//   Future<String> uploadImage(File file) async {
//     String fileName = file.relativePath!.split('/').last;
//     FormData formData = FormData.fromMap({
//         "image":
//             await MultipartFile.fromFile(file.path, filename:fileName),
//     });
//     Response response = await dio.post("/info", data: formData,onSendProgress: (int sent, int total) {
//     print('$sent $total');
//   },);
//     return response.data['id'];
// }

  void updateImage(File file, String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? businessId = _prefs.getString('business_id');
    String token = _prefs.getString('u_token')!;
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    try {
      Response response = await dio.put(
        "https://api.buzz-test.tk/api/v1/business/$businessId/products/$id/image",
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "Authorization": "Bearer $token",
          },
        ),
      );
      print(response.statusMessage);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Item>> getAllItems() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString('business_id');

    try {
      var res = await dio.get(
        '/business/$id/products',
        // options: Options(
        //   headers: {
        //     "businessId": "Bearer $id",
        //   },
        // ),
      );
      print(res.data);
      _product = List<Item>.from(res.data['data'].map((e) => Item.fromJson(e)));
      notifyListeners();
      return _product;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<Item> getSingleItem(String productID) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString('business_id');

    try {
      var res = await dio.get(
        '/business/$id/products/$productID',
        options: Options(
            // headers: {
            //   "businessId": "Bearer $id",
            // },
            ),
      );
      // print(res.data);
      notifyListeners();
      return Item.fromJson(res.data['data']);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void addItem(Item product) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String id = _prefs.getString('business_id')!;
    try {
      http.Response res = await http.post(
        Uri.parse('https://api.buzz-test.tk/api/v1/business/$id/products'),
        body: jsonEncode(product.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);
      _product.add(product);
      notifyListeners();
      // addItemInHive(product);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void updateProduct(Item product, String productID) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String id = _prefs.getString('business_id')!;
    try {
      http.Response res = await http.put(
        Uri.parse(
            'https://api.buzz-test.tk/api/v1/business/$id/products/$productID'),
        body: jsonEncode(product.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);

      //Update locally product
      // _product.add(product);
      // notifyListeners();
      // addItemInHive(product);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void deleteProduct(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessId = _prefs.getString('business_id')!;
    try {
      var res = await dio.delete(
        '/business/$businessId/products/$id',
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
        _product.removeWhere((element) => element.id == id);
        notifyListeners();
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void addItemInHive(Item product) {
    final box = Boxes.getItem();
    box.put(product.id, product);
  }

  void deleteItemInHive(String id) {
    final box = Boxes.getItem();
    box.delete(id);
  }

  void addAddonOnProduct(List<String> addonIDs, String productID) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String id = _prefs.getString('business_id')!;
    try {
      http.Response res = await http.put(
        Uri.parse(
            'https://api.buzz-test.tk/api/v1/business/$id/products/$productID/addons'),
        body: {"add": addonIDs},
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);

      //Update locally product
      // _product.add(product);
      // notifyListeners();
      // addItemInHive(product);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
