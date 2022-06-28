import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obsescurePasswordText = true; //to show/hide password text
  bool _obsescureConfirmPasswordText =
      true; //to show/hide confrim password text

  //below two contoller used for checking and confriming password
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Change Password",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 48, 16, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter Your",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "New Password",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Please enter a 8-digit password.",
                  style: TextStyle(
                      wordSpacing: 3,
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(height: 20),
                buildFormWidget(),
                const SizedBox(height: 120),
                buildElevatedButtonChangePassword(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

//--------------------------Change Password Button-----------------------------

  ElevatedButton buildElevatedButtonChangePassword(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        primary: Colors.black,
        onPrimary: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Can call a server or save the information in a database.
          displayChangePasswordMessage();
          debugPrint(
              'Your new changed password: ' + _confirmPasswordController.text);
        } else {
          debugPrint('not changed');
        }
      },
      child: const Text(
        "Change Password",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600),
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
            //Validation
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              if (value.length < 4) {
                return 'Please enter atleast 4 digits';
              }
              return null;
            },
            controller: _passwordController,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 10.0,
              ),
              fillColor: Colors.white,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 20,
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
            maxLength: 8,
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
              if (value.length < 4) {
                return 'Please enter atleast 4 digits';
              }
              if (_passwordController.text != _confirmPasswordController.text) {
                return 'Password doesnot match';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 10.0,
              ),
              fillColor: Colors.white,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 20,
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
            maxLength: 8,
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
