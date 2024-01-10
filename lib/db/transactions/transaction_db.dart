// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:wallet/calculation/sort.dart';
import 'package:wallet/models/transactions/transaction_model.dart';

const TRANSACTION_DB_NAME='transaction-db';

abstract class TransactionDBFunctions{
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
  Future<void> editTransaction(TransactionModel value);
}

class TransactionDB implements TransactionDBFunctions{
  TransactionDB._internal();

  static TransactionDB instance=TransactionDB._internal();
  
  factory TransactionDB(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>>  transactionListNotifier=ValueNotifier([]);


  @override
  Future<void> addTransaction(TransactionModel obj)async {
   final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await _db.put(obj.id, obj);
  incomeExpense();
  }

  Future<void> refresh()async{
    final _list=await getAllTransaction();
    _list.sort((first,second) =>first.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    incomeExpense();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionListNotifier.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getAllTransaction() async{
    final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String id) async{
    final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
  
  @override
  Future<void> editTransaction(TransactionModel value)async {
    final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(value.id, value);
    refresh();
  }

}