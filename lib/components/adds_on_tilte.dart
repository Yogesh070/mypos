import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddsOnTile extends StatelessWidget {
  final String name;
  final bool? isChecked;
  final Function(bool?)? chechBoxCallback;
  final void Function()? onTap;

  const AddsOnTile({
    Key? key,
    required this.name,
    this.isChecked,
    this.chechBoxCallback,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name),
      trailing: Transform.translate(
        offset: const Offset(13, 0),
        child: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            trackColor: Colors.black,
            value: isChecked!,
            onChanged: chechBoxCallback,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
