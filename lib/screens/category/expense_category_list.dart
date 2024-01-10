import 'package:flutter/material.dart';
import 'package:wallet/db/category/category_db.dart';
import 'package:wallet/models/category/category_models.dart';
import 'package:wallet/screens/category/edit_category.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseCategoryListListener,
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final category = newlist[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                child: ListTile(
                    title: Text(category.name),
                    trailing: Wrap(
                        //spacing: -16,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EditCategory(editModel: category);
                                  });
                              // CategoryDB.instance.deleteCategory(category.id);
                              CategoryDB.instance.editCategory(category);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              CategoryDB.instance.deleteCategory(category.id);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ])),
              ),
            );
          },
          separatorBuilder: (cxt, index) {
            return const SizedBox(
              height: 1,
            );
          },
          itemCount: newlist.length,
        );
      },
    );
  }
}



