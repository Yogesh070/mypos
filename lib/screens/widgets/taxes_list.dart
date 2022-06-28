import 'package:flutter/material.dart';
import 'package:mypos/controllers/settings_controller.dart';
import 'package:mypos/screens/widgets/taxes_tile.dart';

import 'package:provider/provider.dart';

class TaxesList extends StatelessWidget {
  final Function onIndexChanged;

  const TaxesList({Key? key, required this.onIndexChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<SettingController>(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: _controller.taxs.length,
      itemBuilder: (context, index) {
        final tax = _controller.taxs[index];

        return TaxesTile(
          taxTitle: tax.taxName,
          isChecked: tax.isAdded,
          chechBoxCallback: (bool? checkBoxState) {
            _controller.updateTax(tax);
            onIndexChanged(index);
          },
          onTap: () {
            _controller.updateTax(tax);
            onIndexChanged(index);
          },
        );
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Divider(
          height: 5,
          color: Color(0xffE0E0E0),
        ),
      ),
    );
  }
}
