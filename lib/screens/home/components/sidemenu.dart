import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/screens/home/components/side_navbar_tile.dart';

class MenuOptions {
  String title;
  IconData icon;
  String path;
  MenuOptions({required this.title, required this.icon, required this.path});
}

final List<MenuOptions> menuOptions = [
  MenuOptions(title: 'Menu', icon: Icons.fastfood, path: '/home'),
  MenuOptions(title: 'Bills', icon: Icons.line_style, path: '/bill'),
  MenuOptions(title: 'Items', icon: Icons.list, path: '/item'),
  MenuOptions(title: 'Category', icon: Icons.category, path: '/category'),
  MenuOptions(title: 'Addon', icon: Icons.add, path: '/addon'),
  // MenuOptions(title: 'Creditors', icon: Icons.credit_card),
  // MenuOptions(title: 'Notifications', icon: Icons.notifications),
  // MenuOptions(title: 'Settings', icon: Icons.settings),
  // MenuOptions(title: 'Apps', icon: Icons.app_settings_alt),
  // MenuOptions(title: 'Help', icon: Icons.help),
];

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String currentLocation = GoRouter.of(context).location;
    return Drawer(
      child: ListView(
        children: [
          const NavDrawerHeaderText(
            title: 'Owner',
            personName: 'Amit Shrestha',
            userName: 'sthaa001',
          ),
          Column(
            children: menuOptions
                .map((menuOption) => SideNavBarTile(
                      sideBarIndicatorColor: currentLocation == menuOption.path
                          ? const Color(0xff30B700)
                          : Colors.transparent,
                      textIndicatorColor: currentLocation == menuOption.path
                          ? const Color(0xff30B700)
                          : Colors.black,
                      iconIndicatorColor: currentLocation == menuOption.path
                          ? const Color(0xff30B700)
                          : Colors.black,
                      title: menuOption.title,
                      icon: menuOption.icon,
                      press: () {
                        context.go(menuOption.path);
                      },
                      selected: currentLocation == menuOption.path,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    String currentLocation = GoRouter.of(context).location;
    return AppBar(
      title: Text(
        menuOptions
            .where((element) => element.path == currentLocation)
            .first
            .title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class NavDrawerHeaderText extends StatelessWidget {
  final String title, personName, userName;

  const NavDrawerHeaderText({
    Key? key,
    required this.title,
    required this.personName,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 126.9,
      child: DrawerHeader(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //direction: Axis.vertical,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Text(
                personName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(color: Colors.green),
      ),
    );
  }
}
