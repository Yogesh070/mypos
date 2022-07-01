// ignore_for_file: avoid_print

import 'package:mypos/controllers/addon_controller.dart';
import 'package:mypos/controllers/product_controller.dart';
import 'package:mypos/model/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypos/components/addtextfield.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  // const AddItem({Key? key}) : super(key: key);
  final Item? toEditItem;
  final bool? forEdit;

  const AddItem({Key? key, this.toEditItem, this.forEdit = false})
      : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemPrice = TextEditingController();
  final TextEditingController _itemDes = TextEditingController();

  final TextEditingController _costPrice = TextEditingController();
  final TextEditingController _offerPrice = TextEditingController();
  final TextEditingController _lowStock = TextEditingController();
  final TextEditingController _inStock = TextEditingController();
  final TextEditingController _sku = TextEditingController();

  final bool _usesOfferPrice = false;
  final bool _trackStock = false;
  final bool _isVeg = false;

  final _formKey = GlobalKey<FormState>();

  final List<String> _selectedAddons = [];

  String? checkIfEmpty(String? val) {
    if (val!.isEmpty) {
      return "Field Cannot be Empty";
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _itemName.dispose();
    _itemPrice.dispose();
    _itemDes.dispose();
    _costPrice.dispose();
    _offerPrice.dispose();
    _lowStock.dispose();
    _inStock.dispose();
    _sku.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('calling addons fetch');
    Provider.of<AddonController>(context, listen: false).getAllAddons();

    if (widget.forEdit!) {
      _itemName.text = widget.toEditItem!.name;
      _itemPrice.text = widget.toEditItem!.price;
      _itemDes.text = widget.toEditItem!.description ?? '';
      if (widget.toEditItem!.costPrice != null) {
        _costPrice.text = widget.toEditItem!.costPrice.toString();
      }
      if (widget.toEditItem!.offerPrice != null) {
        _offerPrice.text = widget.toEditItem!.offerPrice.toString();
      }
      if (widget.toEditItem!.lowStock != null) {
        _costPrice.text = widget.toEditItem!.lowStock.toString();
      }
      if (widget.toEditItem!.inStock != null) {
        _costPrice.text = widget.toEditItem!.inStock.toString();
      }
      _sku.text = widget.toEditItem!.sku ?? '';
    }
    super.initState();
  }

  // void updateField(Item toEditItem,dynamic toEditField, TextEditingController controller){
  //       if (toEditItem.toEditField != null) {
  //                       if (toEditItem.toEditField!.trim() !=
  //                           _toEditField.text.trim()) {
  //                         customer.email = _email.text;
  //                       }
  //                     } else {
  //                       customer.email = _email.text;
  //                     }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: const Text(
          'Item Details',
          style: kAppBarText,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (widget.forEdit!) {
                  Item item =
                      Item(name: _itemName.text, price: _itemPrice.text);
                  if (widget.toEditItem!.sku != null) {
                    if (widget.toEditItem!.sku!.trim() != _sku.text.trim()) {
                      item.sku = _sku.text;
                    }
                  } else {
                    item.sku = _sku.text;
                  }
                  if (widget.toEditItem!.costPrice != null) {
                    if (widget.toEditItem!.costPrice.toString() !=
                        _costPrice.text.trim()) {
                      item.costPrice = int.parse(_costPrice.text);
                    }
                  } else {
                    item.costPrice = int.parse(_costPrice.text);
                  }
                  Provider.of<ProductController>(context, listen: false)
                      .updateProduct(item, widget.toEditItem!.id!);
                } else {
                  Provider.of<ProductController>(context, listen: false)
                      .addItem(
                    Item(
                      id: 'id',
                      name: _itemName.text,
                      price: _itemPrice.text,
                      addons: _selectedAddons,
                      usesOfferPrice: _usesOfferPrice,
                      offerPrice: int.parse(_offerPrice.text),
                      costPrice: int.parse(_costPrice.text),
                      usesStocks: true,
                      isVeg: _isVeg,
                      description: _itemDes.text,
                      sku: _sku.text,
                      inStock: int.parse(_inStock.text),
                      lowStock: int.parse(_lowStock.text),
                    ),
                  );
                  Navigator.of(context).pop();
                }
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
                  hintText: 'Item Name',
                  textEditingController: _itemName,
                ),
                AddTextField(
                  hintText: 'Price',
                  textEditingController: _itemPrice,
                  keyboardType: TextInputType.number,
                ),
                AddTextField(
                  hintText: 'Description',
                  textEditingController: _itemDes,
                ),
                AddTextField(
                  hintText: 'Cost Price',
                  textEditingController: _costPrice,
                  keyboardType: TextInputType.number,
                  validator: checkIfEmpty,
                ),
                AddTextField(
                  hintText: 'Offer Price',
                  textEditingController: _offerPrice,
                  keyboardType: TextInputType.number,
                  validator: (String? val) {
                    if (int.parse(_itemPrice.text) > int.parse(val!)) {
                      return 'Offer Price should be less than product\'s price';
                    } else {
                      return null;
                    }
                  },
                ),
                ListTileWithCupertinoSwitch(
                  title: 'Is Veg',
                  value: _isVeg,
                ),
                ListTileWithCupertinoSwitch(
                  title: 'Uses OfferPrice',
                  value: _usesOfferPrice,
                ),
                const NewSection(
                  title: 'Inventory',
                ),
                ListTileWithCupertinoSwitch(
                  title: 'Track Stock',
                  value: _trackStock,
                ),
                // _trackStock
                //     ?
                Column(
                  children: [
                    AddTextField(
                      hintText: 'In Stock',
                      textEditingController: _inStock,
                      keyboardType: TextInputType.number,
                    ),
                    AddTextField(
                      hintText: 'Low Stock',
                      textEditingController: _lowStock,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                // : const SizedBox(),
                AddTextField(
                  hintText: 'SKU',
                  textEditingController: _sku,
                  keyboardType: TextInputType.number,
                ),
                const NewSection(
                  title: 'Addons',
                ),
                ListView.builder(
                  itemCount: context.watch<AddonController>().allAddon.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final addon =
                        context.watch<AddonController>().allAddon[index];
                    // bool isSelected = false;

                    return ListTileWithCupertinoSwitch(
                      title: addon.name,
                      value: _selectedAddons.contains(addon.id),
                      onAddonSelected: (newVal) {
                        setState(() {
                          if (newVal) {
                            _selectedAddons.add(addon.id);
                          } else {
                            _selectedAddons.remove(addon.id);
                          }
                        });
                        print(_selectedAddons);
                      },
                    );
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

class NewSection extends StatelessWidget {
  final String title;

  const NewSection({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider()
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ListTileWithCupertinoSwitch extends StatefulWidget {
  final String title;
  bool value;
  final ValueChanged<bool>? onAddonSelected;
  ListTileWithCupertinoSwitch(
      {Key? key,
      required this.title,
      required this.value,
      this.onAddonSelected})
      : super(key: key);

  @override
  State<ListTileWithCupertinoSwitch> createState() =>
      _ListTileWithCupertinoSwitchState();
}

class _ListTileWithCupertinoSwitchState
    extends State<ListTileWithCupertinoSwitch> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.6,
        child: CupertinoSwitch(
          trackColor: Colors.black,
          value: widget.value,
          onChanged: (val) {
            setState(() {
              widget.value = val;
              print(widget.title + " changed " + widget.value.toString());
            });
            if (widget.onAddonSelected != null) {
              widget.onAddonSelected!(val);
            }
          },
        ),
      ),
    );
  }
}
