import 'package:flutter/material.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/screens/home/components/animate_itemgrid.dart';

class ItemsGridView extends StatelessWidget {
  final List<Item> items;
  final Function(GlobalKey<State<StatefulWidget>>) onClick;
  const ItemsGridView({required this.items, Key? key, required this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return AnimateItemGrid(onClick: onClick, item: item);
          },
        ),
      ),
    );
  }
}
