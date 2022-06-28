import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Icon? icon;
  final double? horizontalIconSpace;
  final EdgeInsets? padding;

  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.horizontalIconSpace = 4,
    this.icon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0XFF30B700)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const SizedBox.shrink(),
          (icon != null)
              ? SizedBox(
                  width: horizontalIconSpace,
                )
              : const SizedBox.shrink(),
          Text(title!),
        ],
      ),
    );
  }
}
