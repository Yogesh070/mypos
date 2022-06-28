// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class VerifyCode {
  final int expires;
  final String email;

  VerifyCode({required this.expires, required this.email});
}

class EnterCodeScreen extends StatefulWidget {
  // final int expires; // milliseconds
  // final String toCheckEmail;
  final VerifyCode verifyCode;

  const EnterCodeScreen({Key? key, required this.verifyCode}) : super(key: key);
  // const EnterCodeScreen(
  //     {Key? key, this.expires = 0, required this.toCheckEmail})
  //     : super(key: key);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  int _expiryTimeLeft = 0;
  final _updateInterval = 1000; // milliseconds
  bool _isChecking = false;
  @override
  void initState() {
    super.initState();
    _expiryTimeLeft = widget.verifyCode.expires;
    runTimer();
  }

  void runTimer() async {
    while (_expiryTimeLeft > 0) {
      await Future.delayed(Duration(milliseconds: _updateInterval));
      _expiryTimeLeft -= _updateInterval;
      print("expiry time now is: " + _expiryTimeLeft.toString());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Enter Code",
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isChecking,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 48, 16, 48),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter 6-Digit",
                    style: TextStyle(
                      fontSize: 28,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Recovery Code",
                    style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Please enter code we have sent you at ${widget.verifyCode.email}.",
                    style: TextStyle(
                        wordSpacing: 3,
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  PinCodeTextField(
                    autoDismissKeyboard: true,
                    animationDuration: const Duration(milliseconds: 120),
                    enableActiveFill: true,
                    animationType: AnimationType.scale,
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      print(value); //gives updated value everytime it changed
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      inactiveColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeFillColor: Colors.white,
                      activeColor: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      inactiveFillColor: Colors.white,
                    ),
                    onCompleted: (value) async {
                      setState(() {
                        _isChecking = true;
                      });
                      try {
                        http.Response res = await http.post(
                          Uri.parse(
                              'https://api.buzz-test.tk/api/v1/auth/verify-mail'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode({
                            "email": widget.verifyCode.email,
                            "token": value
                          }),
                        );
                        print('Checking verification at ' +
                            widget.verifyCode.email +
                            'with verfication code ' +
                            value);
                        print(res.body);
                        print(jsonDecode(res.body)['status']);
                        // print(jsonDecode(res.body)['data']['token']);

                        if (res.statusCode == 400) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(jsonDecode(res.body)['message']),
                            backgroundColor: Colors.red,
                          ));
                        }
                        // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjhmNTk1ZTVmMjdiM2IxMDI5ZjUyZGIiLCJidXNpbmVzc0lkIjpudWxsLCJyb2xlIjoidXNlciIsImlhdCI6MTY1MzU2MTczMiwiZXhwIjoxNjU0ODU3NzMyfQ.FeUhilQIzrNwg2uogFc-ndClMVZJMkazxuBy40Y0pOw"
                        if (res.statusCode == 200) {
                          _expiryTimeLeft = -1;
                          context.goNamed('business-reg',
                              extra: jsonDecode(res.body)['data']['token']);
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => BussinessRegistationScreen(
                          //       token: jsonDecode(res.body)['token'],
                          //     ),
                          //   ),
                          // );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                      setState(
                        () {
                          _isChecking = false;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  buildTimer(), //This shows user the time before code expires
                  const SizedBox(height: 120),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                      minimumSize: Size(MediaQuery.of(context).size.width, 40),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: (_expiryTimeLeft > 0)
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Cant resend token now."),
                              ),
                            );
                          },
                    icon:
                        const Icon(Icons.refresh_rounded, color: Colors.white),
                    label: const Text(
                      "Send Again",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//This shows user the time before code expires in seconds

  Row buildTimer() {
    var seconds = Duration(milliseconds: _expiryTimeLeft.toInt()).inSeconds;
    return Row(
      children: [
        Text(
          "Note: The code expires in " +
              Duration(seconds: seconds).inMinutes.toString() +
              " min " +
              Duration(seconds: seconds % 60).inSeconds.toString() +
              " secnods.",
          style: TextStyle(
            wordSpacing: 3,
            fontSize: 12,
            color: Theme.of(context).primaryColor,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
