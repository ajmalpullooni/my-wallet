// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:wallet/models/category/category_models.dart';
import 'package:hive/hive.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME='category-database';

abstract class CatgoryDbFunctions{
  Future<List<CategoryModel>> getCategories();
 Future<void> inserCategory(CategoryModel value);
 // ignore: non_constant_identifier_names
 Future<void> deleteCategory(String CategoryID);
 Future<void> editCategory(CategoryModel values);
}

class CategoryDB implements CatgoryDbFunctions{
  CategoryDB._internal();
  
  static CategoryDB instance=CategoryDB._internal();
  factory CategoryDB(){
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener=ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener=ValueNotifier([]);

  @override
  Future<void> inserCategory(CategoryModel value)async {
     final categoryDB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);    
     await categoryDB.put(value.id,value);
     refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI()async{
    final allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
   await Future.forEach(allCategories, (CategoryModel catgory) {
      if(catgory.type==CategoryType.income){
        incomeCategoryListListener.value.add(catgory);
      }else{
        expenseCategoryListListener.value.add(catgory);
      }
    },);

    
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }
  
  @override
  // ignore: non_constant_identifier_names
  Future<void> deleteCategory(String CategoryID) async{
    final categoryDB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(CategoryID);
    refreshUI();
  }
  
  @override
  Future<void> editCategory(CategoryModel value) async{
    final categoryDB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);

    await categoryDB.put(value.id, value);
    refreshUI();
  }
  
 
  

}