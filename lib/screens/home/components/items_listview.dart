import 'package:flutter/material.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/screens/home/components/animate_itemlist.dart';

class ItemsListView extends StatelessWidget {
  final List<Item> items;
  final Function(GlobalKey<State<StatefulWidget>>) onClick;
  const ItemsListView({required this.items, Key? key, required this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return AnimateItemList(onClick: onClick, item: item);
        },
      ),
    );
  }
}
