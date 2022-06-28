import 'package:flutter/material.dart';

class ExpandableSidenav extends StatelessWidget {
  final double sidebarPanelWidth;
  ExpandableSidenav({
    Key? key,
    required this.sidebarPanelWidth,
  }) : super(key: key);

  final List sidenavItems = ['home', 'setting', 'extra0', 'items', 'item2'];
  final List<IconData> icons = [
    Icons.food_bank,
    Icons.receipt,
    Icons.list,
    Icons.settings,
    Icons.apps,
    Icons.question_answer
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 100),
            width: sidebarPanelWidth,
            color: Colors.white,
            child: ListView.builder(
                itemCount: sidenavItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Icon(icons[index])),
                        (sidebarPanelWidth > 60)
                            ? Expanded(child: Text(sidenavItems[index]))
                            : Container(),
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
