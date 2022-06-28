import 'package:flutter/material.dart';

class TaxesTile extends StatelessWidget {
  final String? taxTitle;
  final bool? isChecked;
  final Function(bool?)? chechBoxCallback;
  final void Function()? onLongPress;
  final void Function()? onTap;

  const TaxesTile(
      {Key? key,
      this.taxTitle,
      this.isChecked,
      this.chechBoxCallback,
      this.onLongPress,
      this.onTap})
      : super(key: key);
  // final Function(bool?)? chechBoxCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      onLongPress: onLongPress,
      leading: Transform.scale(
        scale: 0.7,
        child: Checkbox(
          value: isChecked,
          onChanged: chechBoxCallback,
        ),
      ),
      onTap: onTap,
      title: Text(
        taxTitle!,
      ),
      trailing: const PopupOptionMenu(),
    );
  }
}

class PopupOptionMenu extends StatelessWidget {
  const PopupOptionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Item 1'),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Item 2'),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text('Item 3'),
        ),
      ],
    );
  }

  onSelected(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        debugPrint('item 1 pressed');
        break;
      case 1:
        debugPrint('item 2 pressed');
        break;
      case 2:
        debugPrint('item 3 pressed');
        break;
    }
  }
}
