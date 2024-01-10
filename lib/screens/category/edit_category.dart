import 'package:flutter/material.dart';
import 'package:wallet/models/category/category_models.dart';

import '../../db/category/category_db.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel editModel;
  const EditCategory({super.key, required this.editModel});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController _nameEditingController = TextEditingController();
  CategoryType? selectedCategory;
  //CategoryModel? selectedCategorymodel;
  // ignore: non_constant_identifier_names
  String? CategoryID;
  @override
  void initState() {
    super.initState();
    // CategoryID =widget.editModel.id
    _nameEditingController = TextEditingController(text: widget.editModel.name);
    selectedCategory = widget.editModel.type;
    // String? categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child:  Text(
          'add Category',
          style: TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextFormField(
            controller: _nameEditingController,
            decoration: const InputDecoration(
              hintText: 'Category name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Radio(
              value: CategoryType.income,
              groupValue: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            const Text('income'),
            Radio(
              value: CategoryType.expense,
              groupValue: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            const Text('expense'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                
                onPressed: () {
                  print('edit   button');
            
                  editcategorys();
                  Navigator.of(context).pop;
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> editcategorys() async {
    final _name = _nameEditingController.text;
    if (_name.isEmpty) {
      return;
    }
    if (selectedCategory == null) {
      return;
    }

    final model = CategoryModel(
        id: widget.editModel.id, name: _name, type: selectedCategory!);
    //print(model.name);
    Navigator.of(context).pop();

    CategoryDB.instance.editCategory(model);
  }
}
