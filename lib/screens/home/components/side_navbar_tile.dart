import 'package:flutter/material.dart';

class SideNavBarTile extends StatelessWidget {
  final Color sideBarIndicatorColor, textIndicatorColor, iconIndicatorColor;
  final String title;
  final IconData icon;
  final VoidCallback press;
  final bool selected;

  const SideNavBarTile({
    Key? key,
    required this.sideBarIndicatorColor,
    required this.textIndicatorColor,
    required this.iconIndicatorColor,
    required this.title,
    required this.icon,
    required this.press,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 25,
          color: sideBarIndicatorColor,
        ),
        Expanded(
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textIndicatorColor,
              ),
            ),
            leading: IconTheme(
              data: IconThemeData(
                color: iconIndicatorColor,
              ),
              child: Icon(
                icon,
              ),
            ),
            onTap: press,
            selected: selected,
          ),
        ),
      ],
    );
  }
}
