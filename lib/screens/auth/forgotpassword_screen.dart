// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:mypos/screens/auth/entercode_screen.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _checkIconForSms = false; // check icon of sms
  bool _checkIconForEmail = false; // check icon of email

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Forgot Password",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600)),
        // leading: IconButton(
        //   icon: Icon(Icons.keyboard_arrow_left, color: Colors.black),
        //   onPressed: () {},
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 48, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Please",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Choose a Method",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              const Text(
                "Select which contact would you like to send the reset code.",
                style: TextStyle(
                  wordSpacing: 3,
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                // added ontap so that user can press any where inside the inkwell
                onTap: () {
                  setState(() {
                    _checkIconForSms = !_checkIconForSms;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff6C63FF)),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          height: 30,
                          width: 30,
                          child: const Icon(Icons.sms),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Reset Via SMS",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "+977 98******56",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            _checkIconForSms ? Icons.check_circle : null,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            debugPrint(_checkIconForSms.toString());
                            setState(
                                () => _checkIconForSms = !_checkIconForSms);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  setState(() {
                    _checkIconForEmail =
                        !_checkIconForEmail; // cannot put same value as from via sms contianer
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff6C63FF)),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          height: 30,
                          width: 30,
                          child: const Icon(Icons.mail_outline),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Reset Via Email",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                )),
                            Text(
                              "k********@gmail.com",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            _checkIconForEmail ? Icons.check_circle : null,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            print(_checkIconForEmail);
                            setState(
                                () => _checkIconForEmail = !_checkIconForEmail);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              MaterialButton(
                onPressed: () {
                  //sends 6 digit otp verification via sms
                  if (_checkIconForSms == true && _checkIconForEmail == false) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EnterCodeScreen(
                          verifyCode:
                              VerifyCode(expires: 200000, email: 'email'),
                        ),
                      ),
                    );
                    displaySmsMessage();
                  }
                  //sends 6 digit otp verification via email
                  if (_checkIconForEmail == true && _checkIconForSms == false) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EnterCodeScreen(
                          verifyCode:
                              VerifyCode(expires: 200000, email: 'email'),
                        ),
                      ),
                    );
                    displayEmailMessage();
                  }
                  //shows error if both are selected
                  if (_checkIconForSms == _checkIconForEmail) {
                    displayErrorMessage();
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      "Procced",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 141),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Didn't receive code?",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print('function for resending');
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Resend",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void displaySmsMessage() {
    showDialog(
      context: context,
      builder: (context) {
        AlertDialog dialog = AlertDialog(
          content: const Text(
            'Recovery code send via SMS',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
        return dialog;
      },
    );
  }

  void displayEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        AlertDialog dialog = AlertDialog(
          content: const Text(
            'Recovery code send via Email',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
        return dialog;
      },
    );
  }

  void displayErrorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        AlertDialog dialog = AlertDialog(
          content: const Text(
            'Please select anyone from the above',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
        return dialog;
      },
    );
  }
}
