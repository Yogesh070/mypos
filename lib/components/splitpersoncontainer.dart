import 'package:mypos/components/primary_button.dart';
import 'package:flutter/material.dart';

class SplitPersonContainer extends StatelessWidget {
  const SplitPersonContainer({
    Key? key,
    required this.number,
    required this.textField,
    this.onChanged,
    this.onPressed,
  }) : super(key: key);

  final int number;
  final Widget textField;
  final Function()? onChanged;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Person ${number + 1}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Cash'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          textField,
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: 74,
            height: 37,
            child: PrimaryButton(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              title: 'Pay',
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
