import 'package:mypos/components/shimmer_item_list.dart';
import 'package:mypos/controllers/category_controller.dart';
import 'package:mypos/model/category.dart';
import 'package:mypos/screens/category/add_category.dart';
import 'package:flutter/material.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Category> _searchedCategory = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCategory(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<CategoryController>(
          builder: (context, categoryController, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (val) {
                  setState(() {
                    _searchedCategory = categoryController.allCategory
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(val.toLowerCase()))
                        .toList();
                  });
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: FutureBuilder(
                    future:
                        Provider.of<CategoryController>(context, listen: false)
                            .getCategories(),
                    builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => divider,
                          itemCount: (_searchController.text.isEmpty)
                              ? categoryController.allCategory.length
                              : _searchedCategory.length,
                          itemBuilder: (context, index) {
                            final category = (_searchController.text.isEmpty)
                                ? categoryController.allCategory[index]
                                : _searchedCategory[index];
                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              key: ValueKey(index),
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(left: 16),
                                child: const Align(
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await CategoryController()
                                    .deleteCategory(category.id!);
                              },
                              // onDismissed: (direction) {
                              //   showDialog<String>(
                              //     context: context,
                              //     builder: (BuildContext context) =>
                              //         AlertDialog(
                              //       title: const Text('AlertDialog Title'),
                              //       content:
                              //           const Text('AlertDialog description'),
                              //       actions: <Widget>[
                              //         TextButton(
                              //           onPressed: () =>
                              //               Navigator.pop(context, 'Cancel'),
                              //           child: const Text('Cancel'),
                              //         ),
                              //         TextButton(
                              //           onPressed: () =>
                              //               Navigator.pop(context, 'OK'),
                              //           child: const Text('OK'),
                              //         ),
                              //       ],
                              //     ),
                              //   );
                              //   // CategoryController()
                              //   //     .deleteCategory(category.id!);
                              // },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddCategory(
                                        category: category,
                                        forEdit: true,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(category.name),
                                trailing: Text(category.color),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const ShimmerItemList();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
