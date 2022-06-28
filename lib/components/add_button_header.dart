import 'package:mypos/components/primary_button.dart';
import 'package:flutter/material.dart';

class AddButtonHeader extends StatelessWidget {
  final VoidCallback buttonOnTap, iconOnTap;

  const AddButtonHeader({
    Key? key,
    required this.buttonOnTap,
    required this.iconOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: iconOnTap,
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        PrimaryButton(
          title: 'Add New',
          onPressed: buttonOnTap,
          icon: const Icon(
            Icons.add,
          ),
        )
      ],
    );
  }
}
