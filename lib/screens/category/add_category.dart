import 'package:mypos/controllers/category_controller.dart';
import 'package:mypos/model/category.dart';
import 'package:flutter/material.dart';
import 'package:mypos/components/addtextfield.dart';
import 'package:mypos/utils/constant.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  final bool forEdit;
  final Category? category;

  const AddCategory({Key? key, this.forEdit = false, this.category})
      : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _categoryName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> _categoryColors = [
    '5386E4',
    'E63B2E',
    '441151',
    'BDBBB0',
    'FB5607',
    'FFBE0B',
    'FF006E',
    '251605'
  ];
  int selectedColorIndex = 0;
  @override
  void initState() {
    if (widget.forEdit) {
      _categoryName.text = widget.category!.name;
      selectedColorIndex = _categoryColors.indexOf(widget.category!.color);
    }
    super.initState();
  }

  @override
  void dispose() {
    _categoryName.dispose();
    // Hive.box('category').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: const Text(
          'category Details',
          style: kAppBarText,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Category category = Category(
                  name: _categoryName.text,
                  color: _categoryColors[selectedColorIndex],
                );
                category.id = widget.category!.id;
                if (widget.forEdit) {
                  // if (widget.category!.color.trim() !=
                  //     _categoryColors[selectedColorIndex]) {
                  //   category.color = _categoryColors[selectedColorIndex];
                  // }

                  Provider.of<CategoryController>(context, listen: false)
                      .updateCategory(category);
                } else {
                  Provider.of<CategoryController>(context, listen: false)
                      .addCategory(category);
                }

                Navigator.pop(context);
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
                  hintText: ' Name',
                  textEditingController: _categoryName,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Category Color',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.count(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: _categoryColors
                      .map((e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColorIndex =
                                        _categoryColors.indexOf(e);
                                  });
                                },
                                child: Container(
                                  child:
                                      _categoryColors[selectedColorIndex] == e
                                          ? const Icon(
                                              Icons.check,
                                              size: 40,
                                              color: Colors.white,
                                            )
                                          : const SizedBox(),
                                  decoration: BoxDecoration(
                                      color: Color(int.parse('0xff' + e)),
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                              )
                          // CircleAvatar(
                          //   backgroundColor: Color(int.parse('0xff' + e)),
                          // ),
                          )
                      .toList(),
                )
                // ..._categoryColors.map((e) => CircleAvatar(
                //       backgroundColor: Color(int.parse('0xff' + e)),
                //     ))

                // AddTextField(
                //   hintText: 'Color',
                //   textEditingController: _categoryColor,
                //   validator: (val) {
                //     if (val!.length != 6) {
                //       return 'Invalid Code color';
                //     }
                //     return null;
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
