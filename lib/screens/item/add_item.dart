// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
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

  bool _usesOfferPrice = false;
  bool _trackStock = false;
  bool _isVeg = false;

  List<XFile>? _imageFileList;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  String? _retrieveDataError;
  XFile? pickedFile;

  final ImagePicker _picker = ImagePicker();
  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 400,
        maxHeight: 400,
      );
      // setState(() {
      //   // _setImageFileListFromFile(pickedFile);
      // });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  List<String> _selectedAddons = [];

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
      _itemPrice.text = widget.toEditItem!.price.toString();
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
      _selectedAddons = widget.toEditItem!.addons ?? [];
    }
    super.initState();
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: kIsWeb
                  ? Image.network(_imageFileList![index].path)
                  : Image.file(File(_imageFileList![index].path)),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

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
                  if (pickedFile != null && _pickImageError == null) {
                    Provider.of<ProductController>(context, listen: false)
                        .updateImage(
                            File(pickedFile!.path), widget.toEditItem!.id!);
                  }
                } else {
                  Item toAddItem = Item(
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
                    inStock: int.tryParse(_inStock.text),
                    lowStock: int.tryParse(_lowStock.text),
                  );
                  if (pickedFile != null) {
                    print("to upload image " + pickedFile!.name);
                    Provider.of<ProductController>(context, listen: false)
                        .addItem(toAddItem, true, file: File(pickedFile!.path));
                  } else if (_pickImageError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Pick image error: $_pickImageError',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    print("Without upload image ");
                    Provider.of<ProductController>(context, listen: false)
                        .addItem(toAddItem, false);
                    Navigator.of(context).pop();
                  }
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
                  validator: (val) {
                    if (int.tryParse(val!) == null) {
                      return "Invalid value";
                    }
                    return null;
                  },
                ),
                AddTextField(
                  hintText: 'Description',
                  textEditingController: _itemDes,
                ),
                AddTextField(
                  hintText: 'Cost Price',
                  textEditingController: _costPrice,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (int.tryParse(val!) == null) {
                      return "Invalid value";
                    }
                    if (val.isEmpty) {
                      return "Cost Price cannot be empty";
                    }
                    return null;
                  },
                ),
                AddTextField(
                  hintText: 'Offer Price',
                  textEditingController: _offerPrice,
                  keyboardType: TextInputType.number,
                  validator: (String? val) {
                    if (int.tryParse(val!) == null) {
                      return "Invalid value";
                    }
                    if (int.parse(_itemPrice.text) < int.parse(val)) {
                      return 'Offer Price should be less than product\'s price';
                    } else {
                      return null;
                    }
                  },
                ),
                ListTileWithCupertinoSwitch(
                  title: 'Is Veg',
                  value: _isVeg,
                  onChanged: (val) {
                    setState(() {
                      _isVeg = val;
                    });
                  },
                ),
                ListTileWithCupertinoSwitch(
                  title: 'Uses OfferPrice',
                  value: _usesOfferPrice,
                  onChanged: (val) {
                    setState(() {
                      _usesOfferPrice = val;
                    });
                  },
                ),
                const NewSection(
                  title: 'Inventory',
                ),
                ListTileWithCupertinoSwitch(
                  title: 'Track Stock',
                  value: _trackStock,
                  onChanged: (val) {
                    setState(() {
                      _trackStock = val;
                    });
                  },
                ),
                _trackStock
                    ? Column(
                        children: [
                          AddTextField(
                            hintText: 'In Stock',
                            textEditingController: _inStock,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (int.tryParse(val!) == null) {
                                return "Invalid value";
                              }
                              if (_trackStock && val.isEmpty) {
                                return "Field cannot be empty";
                              }
                              return null;
                            },
                          ),
                          AddTextField(
                            hintText: 'Low Stock',
                            textEditingController: _lowStock,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (int.tryParse(val!) == null) {
                                return "Invalid value";
                              }
                              if (_trackStock && val.isEmpty) {
                                return "Field cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
                AddTextField(
                  hintText: 'SKU',
                  textEditingController: _sku,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (int.tryParse(val!) == null) {
                      return "Invalid value";
                    }
                    return null;
                  },
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
                    return ListTileWithCupertinoSwitch(
                      title: addon.name,
                      value: _selectedAddons.contains(addon.id),
                      onChanged: (val) {
                        setState(() {
                          if (val) {
                            _selectedAddons.add(addon.id);
                          } else {
                            _selectedAddons.remove(addon.id);
                          }
                        });
                      },
                    );
                  },
                ),
                Semantics(
                  label: 'image_picker_example_from_gallery',
                  child: FloatingActionButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                    },
                    tooltip: 'Pick Image from gallery',
                    child: const Icon(Icons.photo),
                  ),
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

class ListTileWithCupertinoSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool) onChanged;
  const ListTileWithCupertinoSwitch(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.6,
        child: CupertinoSwitch(
          trackColor: Colors.black,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
