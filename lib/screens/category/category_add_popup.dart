import 'package:flutter/material.dart';
import 'package:wallet/db/category/category_db.dart';

import '../../models/category/category_models.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  TextEditingController _nameEditingController = TextEditingController();
  showDialog(

      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Colors.white ,
          title: const Text('Add Category',style: TextStyle(fontSize: 18),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                    hintText: 'Category name', border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )),
              ),
            ),
            Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = selectedCategoryNotifier.value;
                 final _category= CategoryModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type,
                  );
                  CategoryDB().inserCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Add'),
              ),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  CategoryType? _type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
