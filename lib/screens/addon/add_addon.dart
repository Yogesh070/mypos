import 'package:mypos/controllers/addon_controller.dart';
import 'package:mypos/model/addon.dart';
import 'package:mypos/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:mypos/components/addtextfield.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class AddAddon extends StatefulWidget {
  final bool forEdit;
  final Addon? addon;

  const AddAddon({Key? key, this.forEdit = false, this.addon})
      : super(key: key);

  @override
  _AddAddonState createState() => _AddAddonState();
}

class _AddAddonState extends State<AddAddon> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final TextEditingController _maxAvilable = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.forEdit && widget.addon != null) {
      _name.text = widget.addon!.name;
      _price.text = widget.addon!.price.toString();
      _description.text = widget.addon!.description;
      _maxAvilable.text = widget.addon!.maxAvailable.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _description.dispose();
    _maxAvilable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: const Text(
          'Addon Details',
          style: kAppBarText,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (!widget.forEdit) {
                  Addon toAdd = Addon(
                    id: 'id',
                    name: _name.text,
                    description: _description.text,
                    price: double.tryParse(_price.text) ?? 0,
                    maxAvailable: int.tryParse(_maxAvilable.text) ?? 0,
                  );
                  if (await checkConnectivity()) {
                    Provider.of<AddonController>(context, listen: false)
                        .addAddon(toAdd);
                  }
                  //  else {
                  //   Provider.of<AddonController>(context, listen: false)
                  //       .addAddonOnOffline(toAdd);
                  // }
                } else {
                  Provider.of<AddonController>(context, listen: false)
                      .updateAddon(
                    Addon(
                      id: widget.addon!.id,
                      name: _name.text,
                      description: _description.text,
                      price: double.tryParse(_price.text) ?? 0,
                      maxAvailable: int.tryParse(_maxAvilable.text) ?? 0,
                    ),
                  );
                }

                Navigator.of(context).pop();
              }
            },
            child: const Text("Save"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddTextField(
                  hintText: 'Addon Name',
                  textEditingController: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                AddTextField(
                  hintText: 'Price',
                  textEditingController: _price,
                  keyboardType: TextInputType.number,
                  validator: (String? val) {
                    if (double.tryParse(val!) == null) {
                      return 'Enter Valid Price';
                    }
                    if (val.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                ),
                AddTextField(
                  hintText: 'Description',
                  textEditingController: _description,
                  // validator: (String? val) {
                  //   if (val!.isEmpty) {
                  //     return 'Cannot be empty';
                  //   }
                  //   return null;
                  // },
                ),
                AddTextField(
                  hintText: 'Max Avilable',
                  textEditingController: _maxAvilable,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (int.tryParse(val!) == null && val.isNotEmpty) {
                      return 'Enter Valid Price';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
