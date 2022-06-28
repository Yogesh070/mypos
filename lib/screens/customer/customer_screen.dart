import 'package:mypos/controllers/customer_controller.dart';
import 'package:mypos/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:mypos/screens/customer/create_customer.dart';
import 'package:mypos/screens/profile/profile.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Customer> _searchedCustomers = [];

  @override
  void initState() {
    Provider.of<CustomerController>(context, listen: false).getAllCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (MediaQuery.of(context).size.width < 600)
          ? AppBar(
              elevation: 0,
              titleSpacing: 10,
              title: const Text(
                'Add Customer to Ticket',
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
                    const Text(
                      'Add Customer to Ticket',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(60),
            ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: kBorderColor),
                  bottom: BorderSide(color: kBorderColor),
                ),
              ),
              child: TextFormField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    icon: Icon(
                      Icons.search,
                      color: kIconColor,
                    ),
                    hintText: 'Search Customer',
                    hintStyle: TextStyle(color: kAccentColor, fontSize: 14),
                    border: InputBorder.none),
                onChanged: (val) {
                  setState(
                    () {
                      _searchedCustomers = Provider.of<CustomerController>(
                              context,
                              listen: false)
                          .allCustomers
                          .where((element) => element.name.contains(val))
                          .toList();
                    },
                  );
                },
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (value) {
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                'Recent Customers',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Consumer<CustomerController>(
                builder: (context, customerController, child) {
                  // final List<Customer> customerFromBox =
                  //     box.values.toList().cast<Customer>();
                  return ListView.builder(
                    itemCount: _searchController.text.isNotEmpty
                        ? _searchedCustomers.length
                        : Provider.of<CustomerController>(context,
                                listen: false)
                            .allCustomers
                            .length,
                    itemBuilder: (context, index) {
                      final customer = _searchController.text.isNotEmpty
                          ? _searchedCustomers[index]
                          : Provider.of<CustomerController>(context,
                                  listen: false)
                              .allCustomers[index];

                      // : customerFromBox[index];
                      return GestureDetector(
                        onTap: () {
                          (MediaQuery.of(context).size.width > 600)
                              ? showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      children: [
                                        Container(
                                          width: 700,
                                          height: 800,
                                          color: Colors.red,
                                          child: Profile(customer: customer),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(
                                      customer: customer,
                                    ),
                                  ),
                                );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/profile.png',
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: kBorderColor,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(customer.name),
                                      Text(
                                        customer.phone ?? 'Not Avilable',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDefaultGreen,
        child: const Icon(Icons.add),
        onPressed: () {
          (MediaQuery.of(context).size.width < 600)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateCustomer(),
                  ),
                )
              : showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        Container(
                          width: 600,
                          height: 800,
                          color: Colors.red,
                          child: const CreateCustomer(),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
