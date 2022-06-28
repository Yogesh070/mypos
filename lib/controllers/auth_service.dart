// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:mypos/model/business.dart';
import 'package:mypos/model/register_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String baseURL = 'https://api.buzz-test.tk/api/v1';
  Future<http.Response> login(String email, String password) async {
    try {
      http.Response res = await http.post(
        Uri.parse(baseURL + '/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {"email_or_phone": email, "password": password},
        ),
      );
      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('u_token', jsonDecode(res.body)['token']);
      } else {
        print('Error saving token');
      }
      // print(res.body);
      return res;

      // Dio dio = Dio();
      // Response res;
      // res = await dio.post(
      //   'https://api.buzz-test.tk/api/v1/auth/login',
      //   data: {
      //     "email_or_phone": _emailController.text,
      //     "password": _passwordController.text
      //   },
      // );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> register(RegisterUser user) async {
    try {
      return await http.post(
        Uri.parse('https://api.buzz-test.tk/api/v1/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
    } catch (e) {
      return http.Response.bytes([], 400);
    }
  }

  Future<http.Response> registerBusiness(
      Business business, String authToken) async {
    print(baseURL + '/business');
    try {
      return await http.post(
        Uri.parse(baseURL + '/business'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(business.toJson()),
      );
    } catch (e) {
      return http.Response.bytes([], 400);
    }
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
