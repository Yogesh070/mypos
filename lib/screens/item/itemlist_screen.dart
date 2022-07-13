import 'package:go_router/go_router.dart';
import 'package:mypos/components/shimmer_item_list.dart';
import 'package:mypos/controllers/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/screens/home/components/sidemenu.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

enum FoodCategory {
  drinks,
  alcohol,
  snacks,
}

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final TextEditingController controller = TextEditingController();
  FoodCategory _groupValue = FoodCategory.snacks;
  List<Item> _searchedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('add-item');
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                    // onChanged: _apiCon.onSearchTextChanged,
                    onChanged: (val) {
                      setState(() {
                        _searchedItems = Provider.of<ProductController>(context,
                                listen: false)
                            .allItem
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(val.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  icon: const Icon(Icons.sort),
                  onSelected: (FoodCategory val) {
                    setState(() {
                      _groupValue = val;
                    });
                    // sortByCategory();
                  },
                  itemBuilder: (context) => <PopupMenuItem<FoodCategory>>[
                    PopupMenuItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Sort by'),
                          Transform.scale(
                            scale: 1.2,
                            child: const Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        visualDensity: VisualDensity.compact,
                        contentPadding:
                            const EdgeInsets.only(left: 0, right: 8),
                        horizontalTitleGap: 4,
                        leading: Radio<FoodCategory>(
                          value: FoodCategory.snacks,
                          groupValue: _groupValue,
                          onChanged: (FoodCategory? val) {
                            setState(() {
                              _groupValue = val!;
                            });
                          },
                        ),
                        title: const Text('Snacks'),
                      ),
                      value: FoodCategory.snacks,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 0, right: 8),
                        visualDensity: VisualDensity.compact,
                        horizontalTitleGap: 4,
                        leading: Radio<FoodCategory>(
                          value: FoodCategory.drinks,
                          groupValue: _groupValue,
                          onChanged: (FoodCategory? val) {
                            setState(() {
                              _groupValue = val!;
                            });
                          },
                        ),
                        title: const Text('Drinks'),
                      ),
                      value: FoodCategory.drinks,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ListTile(
                        horizontalTitleGap: 4,
                        visualDensity: VisualDensity.compact,
                        contentPadding:
                            const EdgeInsets.only(left: 0, right: 8),
                        leading: Radio<FoodCategory>(
                          value: FoodCategory.alcohol,
                          groupValue: _groupValue,
                          onChanged: (FoodCategory? val) {
                            setState(() {
                              _groupValue = val!;
                            });
                          },
                        ),
                        title: const Text('Alcohol'),
                      ),
                      value: FoodCategory.alcohol,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: FutureBuilder(
                    future:
                        Provider.of<ProductController>(context, listen: false)
                            .getAllItems(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => divider,
                          itemCount: (controller.text.isEmpty)
                              ? Provider.of<ProductController>(context)
                                  .allItem
                                  .length
                              : _searchedItems.length,
                          itemBuilder: (context, index) {
                            final product = (controller.text.isEmpty)
                                ? Provider.of<ProductController>(context)
                                    .allItem[index]
                                : _searchedItems[index];

                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              key: ValueKey(product),
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(left: 16),
                                child: const Align(
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              onDismissed: (direction) {
                                // _apiCon.deleteNote(product.id);
                                Provider.of<ProductController>(context,
                                        listen: false)
                                    .deleteProduct(product.id!);
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  context.goNamed(
                                    'edit-item',
                                    params: {"iid": product.id!},
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: (product.image != null)
                                      ? CachedNetworkImage(
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          imageUrl: product.image!,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : Image.asset(
                                          'assets/images/default-image.jpg',
                                        ),
                                ),
                                title: Text(product.name),
                                trailing: Text('Rs.${product.price}'),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Error getting data from internet');
                      } else {
                        return const ShimmerItemList();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
