import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/components/addtextfield.dart';
import 'package:mypos/components/primary_button.dart';
import 'package:mypos/controllers/customer_controller.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
// import 'package:provider/provider.dart';

class CompleteActionPayment extends StatelessWidget {
  final String totalAmount;
  final String paidAmount;

  CompleteActionPayment(
      {Key? key, required this.totalAmount, required this.paidAmount})
      : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // var _itemsCon = Provider.of<ItemsController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Cash Payment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width * 0.66,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff707070),
                        blurRadius: 1.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  // height: 20,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomColumn(
                          rate: totalAmount,
                          title: 'Total Amount',
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      Expanded(
                        child: CustomColumn(
                          rate: (double.parse(paidAmount) -
                                  double.parse(totalAmount))
                              .toString(),
                          title: 'Change',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.email),
                  boxWidth,
                  Expanded(
                    child: AddTextField(
                      hintText: 'ok.123@gmail.com',
                      textEditingController: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      // validator: (val) {
                      //   if (val!.isEmpty) {
                      //     return 'Cannot add empty email';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: 184,
                  height: 37,
                  child: PrimaryButton(
                    title: 'Complete Payment',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Bill toAddBill = Bill(
                          addedAt: DateTime.now(),
                          id: const Uuid().v1(),
                          items: Provider.of<TicketController>(context,
                                  listen: false)
                              .ticketList,
                          isPaid: true,
                          amountPaid: int.parse(paidAmount),
                          email: _emailController.text,
                        );

                        if (Provider.of<CustomerController>(context,
                                    listen: false)
                                .selectedCustomerForTicket !=
                            null) {
                          toAddBill.customer = Provider.of<CustomerController>(
                                  context,
                                  listen: false)
                              .selectedCustomerForTicket!;
                        }
                        if (Provider.of<TicketController>(context,
                                listen: false)
                            .ticketList
                            .isNotEmpty) {
                          toAddBill.customer = null;
                          Provider.of<TicketController>(context, listen: false)
                              .addToBill(toAddBill);
                          if (Provider.of<CustomerController>(context,
                                      listen: false)
                                  .selectedCustomerForTicket !=
                              null) {
                            Provider.of<CustomerController>(context,
                                    listen: false)
                                .removeCustomerFromTicket();
                          }
                          context.goNamed('home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cannot save empty ticket!'),
                            ),
                          );
                          context.goNamed('home');
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    Key? key,
    required this.rate,
    required this.title,
  }) : super(key: key);

  final String rate;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          rate,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
