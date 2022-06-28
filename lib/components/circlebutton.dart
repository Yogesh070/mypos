import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(icon, color: Colors.black),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black),
        ),
        padding: const EdgeInsets.all(10),
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
    );
  }
}
