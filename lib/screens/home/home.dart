import 'package:go_router/go_router.dart';
import 'package:mypos/components/ticket_counter.dart';
import 'package:mypos/controllers/category_controller.dart';
import 'package:mypos/controllers/customer_controller.dart';
import 'package:mypos/controllers/product_controller.dart';
import 'package:mypos/controllers/settings_controller.dart';
import 'package:mypos/controllers/sidenav_controller.dart';
import 'package:mypos/model/category.dart';
import 'package:mypos/screens/home/components/items_grid_view.dart';
import 'package:mypos/screens/home/components/items_listview.dart';
import 'package:mypos/screens/home/components/sidemenu.dart';
import 'package:mypos/screens/open%20ticket/components/ticket_container.dart';
import 'package:flutter/material.dart';
import 'package:mypos/components/primary_button.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/utils/addtocartanimation/add_to_cart_animation.dart';
import 'package:mypos/utils/addtocartanimation/add_to_cart_icon.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;

  late List<Category> items;
  String dropdownValue = 'All Items';

  double sidebarPanelWidth = 60.0;
  bool tapped = false;
  bool isSearchOpen = false;

  final TextEditingController _controller = TextEditingController();
  bool isvisible = false;
  late FocusNode myfocusnode;
  int searchflex = 1;
  int itemsFlex = 4;

  GlobalKey<CartIconKey> gkItem = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  List<String> _filterOptions = ['All Items'];
  List<Item> _itemsBasedOnCategory = [];

  void filterItemsBasedOnCategory(String category) {
    setState(() {
      _itemsBasedOnCategory =
          Provider.of<ProductController>(context, listen: false)
              .allItem
              .where((element) => element.categories!.contains(category))
              .toList();
    });
  }

  void getFilterOptions() async {
    List<Category> allCategoryz =
        await Provider.of<CategoryController>(context, listen: false)
            .getCategories();
    setState(() {
      _filterOptions = [
        dropdownValue,
        ...allCategoryz.map((e) => e.name).toList()
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    getFilterOptions();
    Provider.of<ProductController>(context, listen: false).getAllItems();
    myfocusnode = FocusNode();
  }

  List<Item> _searchedItems = [];

  @override
  void dispose() {
    super.dispose();
    myfocusnode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    List optionItems = Provider.of<SettingController>(context).optionItems;
    final List<PopupMenuItem> _popUpOptions = optionItems
        .map(
          (item) => PopupMenuItem(
            value: item,
            child: Text(item),
          ),
        )
        .toList();
    return AddToCartAnimation(
      gkItem: gkItem,
      rotation: true,
      dragToCardCurve: Curves.easeInOut,
      dragToCardDuration: const Duration(milliseconds: 500),
      previewCurve: Curves.linearToEaseOut,
      previewDuration: const Duration(milliseconds: 500),
      previewHeight: 30,
      previewWidth: 30,
      opacity: 0.85,
      initiaJump: false,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
        runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Scaffold(
        key: Provider.of<SideNavController>(context, listen: false).scafoldKey,
        appBar: selectedIndex == 0
            ? AppBar(
                titleSpacing: 10,
                elevation: 0,
                excludeHeaderSemantics: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (Provider.of<CustomerController>(context,
                                        listen: false)
                                    .selectedCustomerForTicket !=
                                null) {
                              context.goNamed(
                                'profile',
                                params: {
                                  "uid": Provider.of<CustomerController>(
                                          context,
                                          listen: false)
                                      .selectedCustomerForTicket!
                                      .id!
                                },
                              );
                            } else {
                              context.goNamed('customers');
                            }
                          },

                          //showdialog for bigger screen
                          // : showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return const SimpleDialog(
                          //         children: [
                          //           SizedBox(
                          //             width: 600,
                          //             height: 800,
                          //             child: CustomerScreen(),
                          //           ),
                          //         ],
                          //       );
                          //     },
                          //   ),

                          icon: Icon(
                            Provider.of<CustomerController>(context)
                                        .selectedCustomerForTicket ==
                                    null
                                ? Icons.person_add_alt_1_sharp
                                : Icons.person_remove_alt_1_rounded,
                          ),
                        ),
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          itemBuilder: (context) => _popUpOptions,
                          onSelected: (val) {
                            if (val.toString() == 'Grid View' ||
                                val.toString() == 'List View') {
                              Provider.of<SettingController>(context,
                                      listen: false)
                                  .changeLayout();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                toolbarHeight: 80,
                title: GestureDetector(
                  onTap: () {
                    context.goNamed('ticket');
                  },
                  child: TicketCounter(gkItem: gkItem),
                ))
            : const CustomAppBar(),
        body: newHome(media),
        drawer: const SideMenu(),
      ),
    );
  }

  Row newHome(Size media) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              (media.width < 600)
                  ? Container(
                      margin: const EdgeInsets.all(25),
                      child: const TicketContainer(),
                    )
                  : Container(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                decoration: (media.width > 600)
                    ? const BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x55d3d3d3),
                          offset: Offset(0, 5),
                        )
                      ])
                    : BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: kDefaultBackgroundColor,
                          width: 3,
                        ),
                      ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (media.width > 600)
                        ? IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                if (tapped == false) {
                                  sidebarPanelWidth = sidebarPanelWidth + 60;
                                }

                                if (tapped == true) {
                                  sidebarPanelWidth = sidebarPanelWidth - 60;
                                }
                                tapped = !tapped;
                              });
                            })
                        : Container(),
                    Visibility(
                      visible: (media.width < 600) ? !isvisible : true,
                      child: Expanded(
                        flex: (media.width < 920 && media.width > 600)
                            ? 4
                            : (media.width < 600)
                                ? itemsFlex
                                : 1,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              // isExpanded: true,
                              value: dropdownValue,
                              icon: const Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                              ),
                              iconSize: 35,
                              onChanged: (String? newValue) {
                                filterItemsBasedOnCategory(newValue!);
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: _filterOptions
                                  .map((values) => DropdownMenuItem(
                                        child: Text(
                                          values,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        value: values,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: (media.width < 600) ? searchflex : 4,
                      // flex: searchflex,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: (media.width < 600)
                              ? BoxDecoration(
                                  border: (isSearchOpen)
                                      ? null
                                      : const Border(
                                          left: BorderSide(
                                            color: kDefaultBackgroundColor,
                                            width: 3,
                                          ),
                                        ))
                              : null,
                          child: Visibility(
                            visible: isvisible,
                            maintainState: false,
                            replacement: IconButton(
                                icon: const Icon(Icons.search),
                                splashRadius: 1,
                                onPressed: () {
                                  setState(() {
                                    isvisible = !isvisible;
                                    myfocusnode.requestFocus();
                                    isSearchOpen = true;
                                  });
                                }),
                            child: TextField(
                                cursorColor: kDefaultGreen,
                                autofocus: false,
                                onEditingComplete: () {
                                  setState(() {
                                    isvisible = !isvisible;
                                    itemsFlex = 4;
                                    searchflex = 0;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  suffixIcon: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        myfocusnode.unfocus();
                                        setState(() {
                                          isvisible = !isvisible;
                                          isSearchOpen = !isSearchOpen;
                                        });
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                ),
                                focusNode: myfocusnode,
                                controller: _controller,
                                onChanged: (val) {
                                  setState(() {
                                    _searchedItems =
                                        Provider.of<ProductController>(context,
                                                listen: false)
                                            .allItem
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(val.toLowerCase()))
                                            .toList();
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    (media.width > 600)
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            // width: 184,
                            // padding: EdgeInsets.all(15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 48, vertical: 12),
                            decoration: BoxDecoration(
                              color: kDefaultGreen,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Open Ticket',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // (media.width > 600)
                    //     ? ExpandableSidenav(
                    //         sidebarPanelWidth: sidebarPanelWidth,
                    //       )
                    //     : Container(),
                    Provider.of<ProductController>(context).allItem.isNotEmpty
                        ? Builder(
                            builder: (context) {
                              List<Item> _allItems;
                              if (_controller.text.isNotEmpty) {
                                _allItems = _searchedItems;
                              } else if (dropdownValue != 'All Items') {
                                _allItems = _itemsBasedOnCategory;
                              } else {
                                _allItems = Provider.of<ProductController>(
                                        context,
                                        listen: false)
                                    .allItem;
                              }
                              return Provider.of<SettingController>(context,
                                          listen: false)
                                      .isListLayout
                                  ? ItemsListView(
                                      items: _allItems, onClick: listClick)
                                  : ItemsGridView(
                                      // futureItem: Provider.of<ProductController>(context)
                                      //     .getAllItems(),
                                      items: _allItems,
                                      onClick: listClick,
                                    );
                            },
                          )
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('You have no Items Yet'),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child:
                                      Text('Go to items menu to add an item'),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: PrimaryButton(
                                    title: 'Go To Items',
                                    onPressed: () {
                                      context.goNamed('item');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
        // media.width > 600 ? SidebarPayment() : Container(),
      ],
    );
  }

  void listClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
  }
}
