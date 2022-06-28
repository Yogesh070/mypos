import 'package:flutter/material.dart';
import 'package:mypos/controllers/product_controller.dart';
// import 'package:mypos/controller/items_controller.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/screens/home/components/animate_itemlist.dart';
import 'package:provider/provider.dart';

// import 'localwidget/animate_itemlist.dart';

class ItemsListView extends StatelessWidget {
  const ItemsListView({
    required this.futureItem,
    Key? key,
    required this.onClick,
  }) : super(key: key);
  final Future<List<Item>> futureItem;
  final void Function(GlobalKey<State<StatefulWidget>>) onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        initialData: Provider.of<ProductController>(context).allItem,
        future: futureItem,
        builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return AnimateItemList(onClick: onClick, item: item);
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
