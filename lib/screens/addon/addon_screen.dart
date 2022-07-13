import 'package:mypos/components/shimmer_item_list.dart';
import 'package:mypos/controllers/addon_controller.dart';
import 'package:mypos/model/addon.dart';
import 'package:mypos/screens/addon/add_addon.dart';
import 'package:mypos/screens/home/components/sidemenu.dart';
import 'package:mypos/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:mypos/utils/constant.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class AddonListScreen extends StatefulWidget {
  const AddonListScreen({Key? key}) : super(key: key);

  @override
  State<AddonListScreen> createState() => _AddonListScreenState();
}

class _AddonListScreenState extends State<AddonListScreen> {
  final TextEditingController controller = TextEditingController();
  List<Addon> _searchedAddons = [];

  void test() async {
    await Hive.openBox<Addon>('addon');
  }

  @override
  void dispose() {
    // Hive.box('addon').close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddAddon(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (val) {
                setState(
                  () {
                    _searchedAddons =
                        Provider.of<AddonController>(context, listen: false)
                            .allAddon
                            .where(
                              (element) => element.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()),
                            )
                            .toList();
                  },
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: FutureBuilder(
                    future: Provider.of<AddonController>(context, listen: false)
                        .getAllAddons(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData || snapshot.hasError) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => divider,
                          itemCount: (controller.text.isEmpty)
                              ? Provider.of<AddonController>(context)
                                  .allAddon
                                  .length
                              : _searchedAddons.length,
                          itemBuilder: (context, index) {
                            final addon = (controller.text.isEmpty)
                                ? Provider.of<AddonController>(context)
                                    .allAddon[index]
                                : _searchedAddons[index];

                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              key: ValueKey(addon),
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(left: 16),
                                child: const Align(
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              onDismissed: (direction) async {
                                if (!await checkConnectivity()) {
                                  debugPrint("No internet");
                                }
                                // if (!await checkConnectivity() &&
                                //     !addon.isSynced!) {
                                //   Provider.of<AddonController>(context,
                                //           listen: false)
                                //       .deleteAddonInHive(addon.id);
                                // } else if (await checkConnectivity() &&
                                //     !addon.isSynced!) {
                                //   Provider.of<AddonController>(context,
                                //           listen: false)
                                //       .deleteAddonInHive(addon.id);
                                // } else if (!await checkConnectivity() &&
                                //     addon.isSynced!) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text('Cannot delete now'),
                                //     ),
                                //   );
                                //   //Delete synced addon when no internet is avilable
                                // }
                                else {
                                  Provider.of<AddonController>(context,
                                          listen: false)
                                      .deleteAddon(addon.id);
                                }
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  // print(addon.isSynced);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddAddon(forEdit: true, addon: addon),
                                    ),
                                  );
                                  // .then(
                                  //   (context) => _apiCon.getAddons(),
                                  // );
                                },
                                title: Text(addon.name),
                                trailing: Text('Rs.${addon.price}'),
                              ),
                            );
                          },
                        );
                      }
                      //  else if (snapshot.hasError) {
                      //   // return const Text('Error getting data from internet');

                      //   return ListView.separated(
                      //     separatorBuilder: (context, index) => divider,
                      //     itemCount: (controller.text.isEmpty)
                      //         ? Provider.of<AddonController>(context)
                      //             .allAddon
                      //             .length
                      //         : _searchedAddons.length,
                      //     itemBuilder: (context, index) {
                      //       final addon = (controller.text.isEmpty)
                      //           ? Provider.of<AddonController>(context)
                      //               .allAddon[index]
                      //           : _searchedAddons[index];

                      //       return Dismissible(
                      //         direction: DismissDirection.startToEnd,
                      //         key: ValueKey(addon),
                      //         background: Container(
                      //           color: Colors.red,
                      //           padding: const EdgeInsets.only(left: 16),
                      //           child: const Align(
                      //             child:
                      //                 Icon(Icons.delete, color: Colors.white),
                      //             alignment: Alignment.centerLeft,
                      //           ),
                      //         ),
                      //         onDismissed: (direction) {
                      //           Provider.of<AddonController>(context,
                      //                   listen: false)
                      //               .deleteAddon(addon.id);
                      //         },
                      //         child: ListTile(
                      //           contentPadding: EdgeInsets.zero,
                      //           onTap: () {
                      //             print(addon.toJson());

                      //             Navigator.of(context).push(
                      //               MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     AddAddon(forEdit: true, addon: addon),
                      //               ),
                      //             );
                      //             // .then(
                      //             //   (context) => _apiCon.getAddons(),
                      //             // );
                      //           },
                      //           title: Text(addon.name),
                      //           trailing: Text('Rs.${addon.price}'),
                      //         ),
                      //       );
                      //     },
                      //   );
                      // }
                      else {
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
