// ignore_for_file: avoid_print
import 'package:mypos/controllers/notificationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:mypos/components/primary_button.dart';
import 'package:mypos/controllers/customer_controller.dart';
import 'package:mypos/model/customer.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class CreateCustomer extends StatefulWidget {
  final bool forEdit;
  final Customer? toEditCustomer;

  const CreateCustomer({Key? key, this.forEdit = false, this.toEditCustomer})
      : super(key: key);

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.forEdit) {
      if (widget.toEditCustomer!.email != null) {
        _email.text = widget.toEditCustomer!.email!;
      }
      if (widget.toEditCustomer!.phone != null) {
        _phone.text = widget.toEditCustomer!.phone!;
      }
      _name.text = widget.toEditCustomer!.name;
    }
    Provider.of<NotificationController>(context, listen: false)
        .initConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    // Hive.box('customer').close();
    _email.dispose();
    _phone.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (MediaQuery.of(context).size.width < 600)
          ? AppBar(
              elevation: 0,
              titleSpacing: 10,
              backgroundColor: Colors.white,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: Divider(),
              ),
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                !widget.forEdit ? 'Create Customer' : 'Edit Customer',
                style: kAppBarText,
              ),
              leading: GestureDetector(
                child: const Icon(Icons.arrow_back_ios_new),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : PreferredSize(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Register Customer',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(60)),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Name',
                labelText: 'Name',
                icon: Icons.person,
                inputType: TextInputType.text,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
                controller: _name,
              ),
              CustomTextFormField(
                hintText: 'Email',
                labelText: 'Email',
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
                controller: _email,
                validationFunction: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (value.isNotEmpty && !emailValid) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                hintText: 'Phone',
                labelText: 'Phone',
                icon: Icons.phone,
                inputType: TextInputType.phone,
                controller: _phone,
                validationFunction: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter Phone number';
                  // } else if (value.length != 10) {
                  //   return 'Please enter valid phone number';
                  // }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                title: 'Save',
                onPressed: () {
                  print(Provider.of<NotificationController>(context,
                          listen: false)
                      .hasInternetConnection);
                  if (_formKey.currentState!.validate()) {
                    final customer = Customer(
                      name: _name.text,
                    );

                    if (widget.forEdit) {
                      customer.id = widget.toEditCustomer!.id;
                      if (widget.toEditCustomer!.email != null) {
                        if (widget.toEditCustomer!.email!.trim() !=
                            _email.text.trim()) {
                          customer.email = _email.text;
                        }
                      } else {
                        customer.email = _email.text;
                      }
                      if (widget.toEditCustomer!.phone != null) {
                        if (widget.toEditCustomer!.phone!.trim() !=
                            _phone.text.trim()) {
                          customer.phone = _phone.text;
                        }
                      } else {
                        customer.phone = _phone.text;
                      }
                      print(customer.toJson());
                      Provider.of<CustomerController>(context, listen: false)
                          .updateCustomer(customer);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Customer Edited Sucessfully'),
                          backgroundColor: kDefaultGreen,
                        ),
                      );
                      // int count = 0;
                      // Navigator.of(context).popUntil((_) => count++ >= 2);
                    } else {
                      if (_email.text.isNotEmpty) {
                        customer.email = _email.text;
                      }
                      if (_phone.text.isNotEmpty) {
                        customer.phone = _phone.text;
                      }
                      if (Provider.of<NotificationController>(context,
                              listen: false)
                          .hasInternetConnection) {
                        print(customer.toJson());
                        Provider.of<CustomerController>(context, listen: false)
                            .addCustomer(customer, context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No internet Conectivity'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final String hintText;
  final TextInputType inputType;
  final String? Function(String?) validationFunction;
  final TextEditingController? controller;

  const CustomTextFormField({
    Key? key,
    required this.icon,
    required this.labelText,
    required this.hintText,
    required this.inputType,
    required this.validationFunction,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 0, bottom: 8),
          alignLabelWithHint: true,
          icon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Icon(
              icon,
              color: kIconColor,
            ),
          ),
          hintText: hintText,
          labelStyle: const TextStyle(color: kAccentColor),
          labelText: labelText,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBorderColor, width: 1),
          ),
        ),
        onSaved: (String? value) {
          // This optional block of code can be used to run
          // code when the user saves the form.
        },
        validator: validationFunction,
      ),
    );
  }
}
