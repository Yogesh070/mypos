import 'package:mypos/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SidebarPayment extends StatelessWidget {
  const SidebarPayment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle kBoldTextStyle =
        const TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x55d3d3d3),
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Ticket',
                          style: kAppBarText,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/images/Ticket White.svg',
                              color: Colors.black,
                              height: 36,
                              width: 27,
                            ),
                            const Positioned(
                              child: Text(
                                '11',
                                style: TextStyle(color: Colors.white),
                              ),
                              top: 9,
                              left: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        icon: const Icon(Icons.more_vert), onPressed: () {}),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const DataRowItems(
                  name: 'Momo',
                  amount: 10,
                ),
                const DataRowItems(
                  name: 'Chowmin',
                  amount: 5,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: kBoldTextStyle,
                        ),
                        Text(
                          '220',
                          style: kBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  color: kDefaultGreen,
                  child: const Text(
                    'Proceed To Payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DataRowItems extends StatelessWidget {
  final String name;
  final int amount;

  const DataRowItems({Key? key, required this.name, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: kBorderColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$name x$amount'),
                const Text('110'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
