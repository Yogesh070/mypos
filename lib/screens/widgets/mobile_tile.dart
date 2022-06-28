import 'package:flutter/material.dart';

class MobileTile extends StatelessWidget {
  final String taxName;
  final String? charge;

  const MobileTile({Key? key, required this.taxName, this.charge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      title: Text(taxName),
      trailing: Text(charge! + '%'),
    );
  }
}
