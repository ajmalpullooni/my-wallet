import 'package:flutter/material.dart';
import 'package:wallet/db/transactions/transaction_db.dart';
import 'package:wallet/models/category/category_models.dart';

import '../models/transactions/transaction_model.dart';

ValueNotifier incomeTotal = ValueNotifier(0.0);
ValueNotifier expenseTotal = ValueNotifier(0.0);
ValueNotifier balanceTotal = ValueNotifier(0.0); 

  incomeExpense() {
  incomeTotal.value = 0;
  expenseTotal.value = 0;
  balanceTotal.value   = 0;
  final List<TransactionModel> value =
      TransactionDB.instance.transactionListNotifier.value;

  for (int i = 0; i < value.length; i++) {
    if (CategoryType.income == value[i].category.type) {
      incomeTotal.value = incomeTotal.value + value[i].amount;
    } else {
      expenseTotal.value = expenseTotal.value + value[i].amount;
    }
    balanceTotal.value = incomeTotal.value - expenseTotal.value;
  }
}


  // incomeExpense(double income,double expnse,double total) async{
  // incomeTotal.value = income;
  // expenseTotal.value = expnse;
  // balanceTotal.value   =incomeTotal.value - expenseTotal.value;
  // // final List<TransactionModel> value =
  // //     TransactionDB.instance.transactionListNotifier.value;

  // for (int i = 0; i < value.length; i++) {
  //   if (CategoryType.income == value[i].category.type) {
  //     incomeTotal.value = incomeTotal.value + value[i].amount;
  //   } else {
  //     expenseTotal.value = expenseTotal.value + value[i].amount;
  //   }
  //   balanceTotal.value = incomeTotal.value - expenseTotal.value;
  // }
//}



