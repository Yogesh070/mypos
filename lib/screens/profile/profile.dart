import 'package:go_router/go_router.dart';
import 'package:mypos/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:mypos/components/primary_button.dart';
import 'package:mypos/model/customer.dart';

import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final Customer customer;
  const Profile({Key? key, required this.customer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    final childrenList1 = [
      ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        leading: const Icon(Icons.email),
        title: Text(customer.email ?? 'Not Avilable'),
        horizontalTitleGap: 0,
      ),
      ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        leading: const Icon(Icons.phone_android),
        horizontalTitleGap: 0,
        title: Text(customer.phone ?? 'Not Avilable'),
      ),
      // ListTile(
      //   visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      //   leading: const Icon(Icons.location_on_outlined),
      //   title: Text(customer.address),
      //   horizontalTitleGap: 0,
      // ),
      // ListTile(
      //   visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      //   leading: const Icon(Icons.message),
      //   title: Text(customer.note ?? ''),
      //   horizontalTitleGap: 0,
      // ),
      const ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        leading: Icon(Icons.receipt),
        title: Text('Due Amt. (3500)'),
        horizontalTitleGap: 0,
      ),
    ];
    final childrenList2 = [
      const ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        leading: Icon(Icons.blur_circular_rounded),
        title: Text('0.00'),
        horizontalTitleGap: 0,
      ),
      const ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        leading: Icon(Icons.shop),
        title: Text('3'),
        horizontalTitleGap: 0,
      ),
      const ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        leading: Icon(Icons.calendar_today_outlined),
        title: Text('21 Nov,2020'),
        horizontalTitleGap: 0,
      ),
      const ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        leading: Icon(Icons.star),
        title: Text('Advance/Post Credit'),
        horizontalTitleGap: 0,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (MediaQuery.of(context).size.width < 600)
          ? AppBar(
              titleSpacing: 10,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(4),
                child: Divider(),
              ),
              elevation: 0,
              title: const Text(
                'Profile',
                style: kAppBarText,
              ),
              leading: GestureDetector(
                child: const Icon(Icons.arrow_back_ios_new),
                onTap: () {
                  context.pop();
                },
              ),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (Provider.of<CustomerController>(context,
                                    listen: false)
                                .selectedCustomerForTicket ==
                            null) {
                          Provider.of<CustomerController>(context,
                                  listen: false)
                              .setCustomerInTicket(customer);
                        } else {
                          Provider.of<CustomerController>(context,
                                  listen: false)
                              .removeCustomerFromTicket();
                        }
                        context.goNamed('home');
                      },
                      child: Text(
                        Provider.of<CustomerController>(context, listen: false)
                                    .selectedCustomerForTicket ==
                                null
                            ? 'ADD TO TICKET'
                            : 'Remove From Ticket',
                        style: const TextStyle(
                          color: kDefaultGreen,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
                          'Customer Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<CustomerController>(context, listen: false)
                            .setCustomerInTicket(customer);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ADD TO TICKET',
                        style: TextStyle(
                          color: kDefaultGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(60),
            ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView(
          padding: kScreenMargin,
          children: [
            CircleAvatar(
              minRadius: 20,
              child: Image.asset(
                'assets/images/profile.png',
                height: 60,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  customer.name,
                  style: (mediaWidth < 600)
                      ? const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )
                      : const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                ),
                IconButton(
                  splashRadius: 20,
                  tooltip: 'Edit Profile',
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Provider.of<CustomerController>(context, listen: false)
                    //     .toEditCustomer = customer;
                    context
                        .goNamed('edit-profile', params: {"uid": customer.id!});
                  },
                ),
                IconButton(
                  splashRadius: 20,
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<CustomerController>(context, listen: false)
                        .deleteCustomer(customer.id!);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            (mediaWidth < 600)
                ? Column(
                    children: [
                      Column(children: childrenList1),
                      const Divider(),
                      Column(children: childrenList2),
                    ],
                  )
                : IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Column(children: childrenList1)),
                        Container(
                          color: kBorderColor,
                          width: 1,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Column(children: childrenList2),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: PrimaryButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  title: 'Redeem Points',
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
