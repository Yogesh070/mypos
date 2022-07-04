// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mypos/components/addtextfield.dart';
import 'package:mypos/screens/payment/complete_payment.dart';
// import 'package:mypos/controllers/product_controller.dart';
// import 'package:mypos/controller/items_controller.dart';
// import 'package:mypos/screen/split/splitoption.dart';
import 'package:mypos/utils/constant.dart';
// import 'package:provider/provider.dart';

class CashPayment extends StatelessWidget {
  final String? totalAmount;

  CashPayment({Key? key, required this.totalAmount}) : super(key: key);

  final TextEditingController _amountController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var _pay = Provider.of<SplitController>(context);
    // var _itemsCon = Provider.of<ProductController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Cash Payment',
          style: kAppBarText,
        ),
        // actions: [
        //   GestureDetector(
        //     child: const Padding(
        //       padding: EdgeInsets.only(right: 25.0),
        //       child: Center(
        //           child: Text(
        //         'SPLIT',
        //         style: TextStyle(
        //             color: Color(0xFF30B700),
        //             fontFamily: 'RobotoRegular',
        //             fontSize: 16.0),
        //       )),
        //     ),
        //     onTap: () {
        //       _itemsCon.splitPayment(context);
        //     },
        //   ),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    totalAmount!,
                    // _itemsCon.total.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Cash Received',
                style: TextStyle(fontSize: 14, fontFamily: 'RobotoRegular'),
              ),
              AddTextField(
                hintText: 'amount',
                textEditingController: _amountController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (int.tryParse(val!) == null) {
                    return "Invalid value";
                  }
                  if (val.isNotEmpty) {
                    if (int.parse(val) <= 0) {
                      return 'Enter Valid Amount';
                    } else if (int.parse(val) < int.parse(totalAmount!)) {
                      return 'Cannot Pay less amount than amount to be paid';
                    }
                  }
                  return null;
                },
              ),
              // _pay.cashReceived > 0.0
              //     ?    SplitTextFormField(
              //             hintText: 'Enter amount',
              //             textEditingController: _itemsCon.cashReceived)
              //     : Text(_pay.returnChange.toString(),
              //         style: const TextStyle(
              //             fontSize: 14, fontFamily: 'RobotoRegular')),
              // const Padding(
              //   padding: EdgeInsets.only(top: 8.0),
              //   child: Divider(
              //     color: Color(0xFFE0E0E0),
              //     thickness: 1.5,
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: PayButton(
                  color: kDefaultGreen,
                  text: const Text('Confirm', style: kSemiLargeText),
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompleteActionPayment(
                            totalAmount: totalAmount!,
                            paidAmount: _amountController.text,
                          ),
                        ),
                      );
                    }

                    // if (_itemsCon.cashReceived.text.isNotEmpty &&
                    //     _itemsCon.ticketList.isNotEmpty) {
                    //   _itemsCon.performTransaction(context);
                    //   _itemsCon.cashReceived.clear();
                    // } else {
                    //   debugPrint('amount not defined or items not added');
                    // }
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  final VoidCallback onPress;
  final Widget text;
  final Color color;
  final EdgeInsetsGeometry padding;
  const PayButton(
      {Key? key,
      required this.onPress,
      required this.text,
      required this.color,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Padding(
        padding: padding,
        child: text,
      ),
      style: TextButton.styleFrom(backgroundColor: color),
    );
  }
}
