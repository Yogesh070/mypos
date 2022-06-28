import 'package:mypos/utils/constant.dart';
import 'package:flutter/material.dart';

class TabletViewAppbar extends StatelessWidget {
  final Widget trailing;

  const TabletViewAppbar({Key? key, required this.trailing}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: kBorderColor),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          trailing
        ],
      ),
    );
  }
}
