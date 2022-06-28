import 'package:flutter/material.dart';

class ItemDropDownTax extends StatelessWidget {
  final List<String> listItem = ['Apply tax to new items', 'Item 2', 'Item 3'];

  ItemDropDownTax({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String listItemSelected = 'Apply tax to new items';
    return SizedBox(
      width: double.infinity,
      child: DropdownButton<String>(
        isExpanded: true,
        value: listItemSelected,
        iconSize: 30,
        icon: (null),
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
        hint: const Text('Select State'),
        onChanged: (newValue) {
          listItemSelected = newValue.toString();
        },
        items: listItem.map((item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
      ),
    );
  }
}
