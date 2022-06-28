// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:mypos/model/register_user.dart';
import 'package:mypos/screens/auth/entercode_screen.dart';
import 'package:mypos/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obsescurePasswordText = true;
  bool _obsescureConfirmPasswordText = true;
  bool checkboxValue = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneno = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _address = TextEditingController();

  bool _sendingRequest = false;
  http.Response? lastResponse;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _phoneno.dispose();
    _username.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _sendingRequest,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 28,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Create a new account",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff686868),
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                buildFormWidget(),
                const SizedBox(height: 16),
                buildElevatedButtonRegister(context),
                TextButton(
                  child: Text(
                    'Already Registered? Login now',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//--------------------------Change Password Button-----------------------------

  ElevatedButton buildElevatedButtonRegister(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        primary: Theme.of(context).primaryColor,
        onPrimary: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: (_sendingRequest)
          ? null
          : () async {
              if (!checkboxValue) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Accept terms and agreement to proceed')));
              }
              if (_formKey.currentState!.validate() && checkboxValue == true) {
                // Can call a server or save the information in a database.
                setState(() {
                  _sendingRequest = true;
                });

                try {
                  lastResponse = await http.post(
                    Uri.parse('https://api.buzz-test.tk/api/v1/auth/register'),
                    // body: jsonEncode({
                    //   "id": "66812390dasd810",
                    //   "name": "Mike tyson",
                    //   "email": "mike@gmail.com",
                    //   "phone": '9898989898',
                    //   "password": "12345mike",
                    //   "confirmPassword": "12345mike",
                    //   "address": "Nepal"
                    // }),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(RegisterUser(
                      id: '',
                      name: _username.text,
                      email: _email.text,
                      phone: _phoneno.text,
                      password: _passwordController.text,
                      confirmPassword: _passwordController.text,
                      address: _address.text,
                    ).toJson()),
                  );
                  print(lastResponse!.statusCode);
                  if (lastResponse!.statusCode == 200) {
                    VerifyCode _verify =
                        VerifyCode(email: _email.text, expires: 200000);
                    context.goNamed('code', extra: _verify);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => EnterCodeScreen(
                    //       toCheckEmail: _email.text,
                    //       expires: 200000,
                    //     ),
                    //   ),
                    //   (route) => false,
                    // );
                  }
                  print(lastResponse!.body);
                } catch (e) {
                  print(e);
                } finally {
                  setState(() {
                    lastResponse = lastResponse;
                  });
                }
                // print(jsonDecode(response.body)['data']['name']);

                // Dio dio = Dio();
                // Response? response;

                // dio.options.baseUrl = 'http://3.17.156.110/';

                // try {
                //   response = await dio.post(
                //     'https://api.buzz-test.tk/api/v1/auth/register',
                //     data: FormData.fromMap(
                //       RegisterUser(
                //         id: '',
                //         name: _username.text,
                //         email: _email.text,
                //         phone: _phoneno.text,
                //         password: _passwordController.text,
                //         confirmPassword: _passwordController.text,
                //         address: _address.text,
                //       ).toJson(),
                //     ),
                //     options: Options(
                //       headers: {'accept': 'application/json'},
                //       contentType: 'application/json',
                //     ),
                //   );
                //   debugPrint('response data' + response.data);
                //   // debugPrint('resposnse message' + response.statusMessage!);
                // } catch (e) {
                //   print(e);
                // }

                // Registration logic here
                //   await jsendResponse.fromAPIRequest(
                //       APIRequest(
                //           path: '/auth/register',
                //           method: "POST",
                //           payload: {
                //             'name': _username.text,
                //             'email': _email.text,
                //             'phone': _phoneno.text,
                //             'password': _passwordController.text,
                //             'confirm_password': _confirmPasswordController.text
                //           }),
                //       statusHandlers: [
                //         JsendStatusHandler(
                //           forSuccess: (jsendResp) {
                //             try {
                //               Navigator.pushNamed(context, "/enter_code",
                //                   arguments: jsendResp.data);
                //             } catch (e) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                   SnackBar(content: Text(e.toString())));
                //             }
                //           },
                //           forFail: (jsendResp) {
                //             lastResponse = jsendResp;
                //             _formKey.currentState!.validate();
                //             lastResponse = null;
                //           },
                //         ),
                //       ]);
                setState(() {
                  _sendingRequest = false;

                  _formKey.currentState!.validate();
                  lastResponse = null;
                });
              }
              // else {
              //   print('validation failed');
              // }
            },
      child: const Text(
        "Register",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

//---------------------------Form Widget------------------------------------

  Form buildFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _username,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Name';
              }
              // return null;
              return errorIn(lastResponse, "name");
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Color(0xffF4F4F4),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 10.0,
              ),
              fillColor: Colors.white,
              prefixIcon: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin: const EdgeInsets.only(right: 16.5, left: 0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                ),
              ),
              hintText: 'Full Name',
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
            controller: _email,
            //Validation
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Email';
              }
              // return null;
              return errorIn(lastResponse, "email");
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin: const EdgeInsets.only(right: 16.5, left: 0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
                child: const Icon(
                  Icons.mail_outline_outlined,
                ),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 14,
                color: Colors.black.withOpacity(0.50),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            //maxLength: 8,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _phoneno,
            //Validation
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Phone Number';
              }
              // return null;
              return errorIn(lastResponse, "phone");
            },
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
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
              fillColor: Colors.white,
              prefixIcon: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin: const EdgeInsets.only(right: 16.5, left: 0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.phone,
                ),
              ),
              hintText: 'Phone Number',
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              if (value.length < 8) {
                return 'Please enter atleast 8 digits';
              }
              // return null;
              return errorIn(lastResponse, "password");
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin: const EdgeInsets.only(right: 16.5, left: 0),
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
                icon: Icon(
                  _obsescurePasswordText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _obsescurePasswordText = !_obsescurePasswordText;
                  });
                },
              ),
              hintText: 'Password',
              hintStyle: const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 14,
                  color: Colors.black),
            ),
            obscureText: _obsescurePasswordText,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            //validataion
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please re-enter password';
              }
              if (value.length < 8) {
                return 'Please enter atleast 8 digits';
              }
              if (_passwordController.text != _confirmPasswordController.text) {
                return 'Password doesnot match';
              }
              // return null;
              return errorIn(lastResponse, "confirm_password");
            },
            decoration: InputDecoration(
              border: InputBorder.none,
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
              fillColor: Colors.white,
              prefixIcon: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin: const EdgeInsets.only(right: 16.5, left: 0),
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
                icon: Icon(
                  _obsescureConfirmPasswordText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _obsescureConfirmPasswordText =
                        !_obsescureConfirmPasswordText;
                  });
                },
              ),
              hintText: 'Confirm Password',
              hintStyle: const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 14,
                  color: Colors.black),
            ),
            keyboardType: TextInputType.text,
            obscureText: _obsescureConfirmPasswordText,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _address,
            //Validation
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Address';
              }
              // return null;
              return errorIn(lastResponse, "address");
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin: const EdgeInsets.only(right: 16.5, left: 0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
                child: const Icon(Icons.map),
              ),
              hintText: 'Address',
              hintStyle: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 14,
                color: Colors.black.withOpacity(0.50),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            //maxLength: 8,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                        value: checkboxValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkboxValue = newValue!;
                          });
                        }),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                ' I agree to given Terms and Conditions',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }

//---------------------------displayChangePasswordMessage-----------------------

  void displayChangePasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        AlertDialog dialog = AlertDialog(
          content: Text(
            'Your new password is ' + _confirmPasswordController.text,
            style: const TextStyle(
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
