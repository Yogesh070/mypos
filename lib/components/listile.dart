import 'package:flutter/material.dart';

class TileListBox extends StatelessWidget {
  final String taxTitle;
  final int? quantity;
  final IconData? iconData;
  final Widget? merge;
  final String amount;
  final String? created;
  final bool? isChecked;
  final Function(bool?)? chechBoxCallback;
  final void Function()? onLongPress;
  final void Function()? onTap;

  const TileListBox(
      {Key? key,
      required this.taxTitle,
      this.isChecked,
      this.chechBoxCallback,
      this.onLongPress,
      this.onTap,
      required this.amount,
      this.created,
      this.merge,
      this.iconData,
      this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      horizontalTitleGap: 10,
      onLongPress: onLongPress,
      leading: iconData != null
          ? Wrap(
              alignment: WrapAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.7,
                  child: Transform.translate(
                    offset: const Offset(0, 4),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: chechBoxCallback,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      iconData,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          : Transform.scale(
              scale: 0.7,
              child: Checkbox(
                fillColor: MaterialStateProperty.all(
                  const Color(0xff000000),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                value: isChecked,
                onChanged: chechBoxCallback,
              ),
            ),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      onTap: onTap,
      title: Row(
        //   alignment: WrapAlignment.spaceBetween
        children: [
          Text(
            taxTitle,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          quantity != null
              ? Text(
                  ' x$quantity',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                )
              : const SizedBox.shrink(),
          Transform.scale(
            scale: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff30B700).withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: merge,
            ),
          ),
        ],
      ),
      subtitle: created != null
          ? Text(
              created!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff707070),
              ),
            )
          : null,
    );
  }
}
