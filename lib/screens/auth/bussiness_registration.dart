import 'package:mypos/components/primary_button.dart';
import 'package:mypos/controllers/auth_service.dart';
import 'package:mypos/model/business.dart';
import 'package:mypos/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

class BussinessRegistationScreen extends StatefulWidget {
  final String? token;

  const BussinessRegistationScreen({Key? key, this.token}) : super(key: key);

  @override
  State<BussinessRegistationScreen> createState() =>
      _BussinessRegistationScreenState();
}

class _BussinessRegistationScreenState
    extends State<BussinessRegistationScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _panno = TextEditingController();
  final TextEditingController owner = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  http.Response? lastResponse;
  @override
  void dispose() {
    _name.dispose();
    _color.dispose();
    _panno.dispose();
    owner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Business SignUp',
                  style: TextStyle(
                    fontSize: 28,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _name,
                  hintText: 'Name*',
                  icon: Icons.person,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Your Name';
                    }
                    // return null;
                    return errorIn(lastResponse, "name");
                  },
                ),
                CustomTextField(
                  controller: _color,
                  hintText: 'Color',
                  icon: Icons.color_lens,
                  validation: (value) {
                    return errorIn(lastResponse, "color");
                  },
                ),
                CustomTextField(
                  controller: _panno,
                  hintText: 'Pan Number',
                  keyboardType: TextInputType.number,
                  icon: Icons.numbers,
                  validation: (value) {
                    return errorIn(lastResponse, "pan_no");
                  },
                ),
                CustomTextField(
                  controller: owner,
                  hintText: 'Owner',
                  icon: Icons.onetwothree_sharp,
                  validation: (value) {
                    return errorIn(lastResponse, "owner");
                  },
                ),
                PrimaryButton(
                  title: 'Proceed',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      http.Response res = await AuthService().registerBusiness(
                        Business(
                          id: 'id',
                          name: _name.text,
                          color: _color.text,
                          owner: owner.text,
                          panNo: int.parse(_panno.text),
                        ),
                        widget.token!,
                      );
                      if (res.statusCode == 200) {
                        context.goNamed('home');
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final IconData icon;
  final String? Function(String?)? validation;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      required this.icon,
      this.validation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validation,
        keyboardType: keyboardType,
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
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
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
            child: Icon(
              icon,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 14,
            color: Colors.black.withOpacity(0.50),
          ),
        ),
      ),
    );
  }
}
