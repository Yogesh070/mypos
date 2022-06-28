import 'package:flutter/material.dart';
import 'package:mypos/screens/home/components/side_navbar_tile.dart';
import 'package:mypos/screens/home/home.dart';

class SideMenu extends StatelessWidget {
  final Function onNavIndexChanged;
  final int selectedIndex;
  final List<MenuOptions> menuOptions;
  const SideMenu(
      {Key? key,
      required this.onNavIndexChanged,
      required this.selectedIndex,
      required this.menuOptions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      sideBarIndicatorColor:
                          selectedIndex == menuOptions.indexOf(menuOption)
                              ? const Color(0xff30B700)
                              : Colors.transparent,
                      textIndicatorColor:
                          selectedIndex == menuOptions.indexOf(menuOption)
                              ? const Color(0xff30B700)
                              : Colors.black,
                      iconIndicatorColor:
                          selectedIndex == menuOptions.indexOf(menuOption)
                              ? const Color(0xff30B700)
                              : Colors.black,
                      title: menuOption.title,
                      icon: menuOption.icon,
                      press: () {
                        onNavIndexChanged(menuOptions.indexOf(menuOption));
                        Navigator.pop(context);
                      },
                      selected:
                          selectedIndex == menuOptions.indexOf(menuOption),
                    ))
                .toList(),
          ),
        ],
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
