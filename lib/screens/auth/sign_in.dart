// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:mypos/components/primary_button.dart';
import 'package:mypos/controllers/auth_service.dart';
import 'package:mypos/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsescurePasswordText = true;
  bool _sendingRequest = false;
  bool checkboxValue = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  http.Response? lastResponse;
  getMyBusinsss(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response res = await http.get(
        Uri.parse('https://api.buzz-test.tk/api/v1/business/my'),
        headers: {'Authorization': 'Bearer $token'});
    lastResponse = res;
    print('response body for bussiness' + res.body);
    if (res.statusCode == 200) {
      List<dynamic> business = jsonDecode(res.body)['data'];
      if (business.isNotEmpty) {
        prefs.setString(
          'business_id',
          business[0]['id'],
        );
        GoRouter.of(context).goNamed('home');
      } else {
        GoRouter.of(context).go('/business-registration', extra: token);
      }
    } else {
      print(res.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _sendingRequest,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 56),
            alignment: Alignment.center,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/khajaghar.svg',
                  height: 180,
                  placeholderBuilder: (BuildContext context) {
                    return const Placeholder(
                      fallbackHeight: 180,
                    );
                  },
                ),
                const SizedBox(
                  height: 68,
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 40, maxWidth: 200),
                  child: const Text(
                    'Login to your Account ',
                  ),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 40, maxWidth: 220),
                  child: const Text(
                    "Welcome back, you've been missed",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Your Email';
                            }
                            return null;
                            // return errorIn(lastResponse, "message");
                          },
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Color(0xffF4F4F4),
                                width: 2,
                              ),
                            ),
                            fillColor: Colors.white,
                            prefixIcon: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              margin: const EdgeInsets.only(
                                right: 16.5,
                                left: 0,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: const Icon(Icons.person),
                            ),
                            hintText: 'Email or Phone',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.50),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          //Validation
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.length < 4) {
                              return 'Please enter atleast 4 digits';
                            }
                            return null;

                            // return errorIn(lastResponse, "password");
                          },
                          controller: _passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Color(0xffF4F4F4),
                                width: 2,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            prefixIcon: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 10),
                              margin:
                                  const EdgeInsets.only(right: 16.5, left: 0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                ),
                              ),
                              child: const Icon(
                                Icons.lock_outline,
                              ),
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 16,
                              icon: Icon(
                                _obsescurePasswordText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obsescurePasswordText =
                                      !_obsescurePasswordText;
                                });
                              },
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.50),
                            ),
                          ),
                          obscureText: _obsescurePasswordText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  child: Theme(
                                    data: ThemeData(
                                      primarySwatch: Colors.blue,
                                      unselectedWidgetColor: Colors.black,
                                    ),
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          fillColor: MaterialStateProperty.all(
                                            Colors.green,
                                          ),
                                          value: checkboxValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              checkboxValue = newValue!;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Remember me',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'Forgot your Password?',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: PrimaryButton(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    title: 'Login',
                    onPressed: () async {
                      setState(() {
                        _sendingRequest = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          lastResponse = await AuthService().login(
                              _emailController.text, _passwordController.text);
                          if (lastResponse!.statusCode == 401) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    jsonDecode(lastResponse!.body)['message']),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          if (lastResponse!.statusCode == 200) {
                            print(jsonDecode(lastResponse!.body)['token']);
                            getMyBusinsss(
                                jsonDecode(lastResponse!.body)['token']);
                            // context.goNamed('home');
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) =>
                            //         const BussinessRegistationScreen(),
                            //   ),
                            // );
                          }
                          // rohit.shrestha.a18@icp.edu.np
                          // 123rohit

                          setState(() {
                            lastResponse = lastResponse;
                          });
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          _sendingRequest = false;
                          _formKey.currentState!.validate();
                          lastResponse = null;
                        });
                      } else {
                        print("validation failed.");
                        setState(() {
                          _formKey.currentState!.validate();
                          _sendingRequest = false;
                          lastResponse = null;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                    child: Text(
                      'New to mypos? Register Now',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUp(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
