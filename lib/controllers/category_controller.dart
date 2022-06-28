// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mypos/model/category.dart' as cat;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mypos/utils/boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends ChangeNotifier {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.buzz-test.tk/api/v1',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );
  List<cat.Category> _category = [];
  UnmodifiableListView<cat.Category> get allCategory =>
      UnmodifiableListView(_category);

  bool isCategoryLoadedOnce = false;

  void updateCategory(cat.Category category) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessID = _prefs.getString('business_id')!;

    try {
      http.Response res = await http.put(
        Uri.parse(
            'https://api.buzz-test.tk/api/v1/business/$businessID/categories/${category.id}'),
        body: jsonEncode(category.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        _category[
                _category.indexWhere((element) => element.id == category.id)] =
            cat.Category.fromJson(jsonDecode(res.body)['data']);
        notifyListeners();
      }

      // addAddonInHive(category);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<List<cat.Category>> getCategories({bool? forceLoad = false}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString('business_id');
    // isCategoryLoadedOnce = forceLoad!;
    if (!isCategoryLoadedOnce) {
      try {
        var res = await dio.get(
          '/business/$id/categories',
          options: Options(
            headers: {
              "businessId": "Bearer $id",
            },
          ),
        );
        print(res.data);
        if (res.statusCode == 200) {
          _category = List<cat.Category>.from(
              res.data['data'].map((e) => cat.Category.fromJson(e)));
          notifyListeners();
          isCategoryLoadedOnce = true;
          print(_category);
        }
        print(!isCategoryLoadedOnce);
        return _category;
      } on DioError catch (e) {
        throw Exception(e);
      }
    } else {
      return _category;
    }
  }

  void addCategory(cat.Category category) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String id = _prefs.getString('business_id')!;
    print(_category.toString() + " before adding category");
    try {
      http.Response res = await http.post(
        Uri.parse('https://api.buzz-test.tk/api/v1/business/$id/categories'),
        body: jsonEncode(category.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);
      // addCategoryInHive(category);
      if (res.statusCode == 200) {
        _category.add(cat.Category.fromJson(jsonDecode(res.body)['data']));
        notifyListeners();
        print(_category);
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteCategory(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('u_token')!;
    String businessId = _prefs.getString('business_id')!;
    try {
      var res = await dio.delete(
        '/business/$businessId/categories/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print(res.data);
      if (res.statusCode == 200) {
        _category.removeWhere((element) => element.id == id);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  void addCategoryInHive(cat.Category category) {
    final box = Boxes.getCategory();
    box.put(category.id, category);
  }

  void deleteCategoryInHive(String id) {
    final box = Boxes.getCategory();
    box.delete(id);
  }
}
