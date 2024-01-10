import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:wallet/calculation/sort.dart';
import 'package:wallet/db/category/category_db.dart';
import 'package:wallet/db/transactions/transaction_db.dart';
import 'package:wallet/models/category/category_models.dart';
import 'package:wallet/screens/add_transaction/screen_add_transaction.dart';
import 'package:wallet/screens/transactions/see_all_transactions.dart';

import '../../models/transactions/transaction_model.dart';

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({super.key});

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}


class _ScreenTransactionState extends State<ScreenTransaction> {
  @override
  void initState() {
   incomeExpense();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI(); 
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              color: Colors.grey,
              height: .3,
            )),
        title: const Column(
          children: [
            Text(
              'MyWallet',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.7,
              ),
            ),
            DefaultTextStyle(
              style: TextStyle(),
              child: Center(
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    //letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        //backgroundColor: Colors.pink,
        // centerTitle: true,
      ),
      body: Column(
        children: [
          // const CalanderiInHomePage(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
                   valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (context, value, child) =>
             Container(
                height: 50,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                      const  Text(
                          'INCOME',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: incomeTotal,
                          builder:
                              (BuildContext context, dynamic newList, Widget? _) {
                            return Text(
                              incomeTotal.value.toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                       const Text(
                          'EXPENSE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: expenseTotal,
                          builder: (context, value, child) {
                            return Text(
                              expenseTotal.value.toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                       const Text(
                          'TOTAL',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: balanceTotal,
                          builder: (context, value, child) {
                            return Text(
                              balanceTotal.value.toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //MainCardIEB(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transaction list',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                // const SizedBox(
                //   width: 220,
                // ),

                //the button of the all transactions
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const SeeAllTransaction();
                      },
                    ));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          //transaction cards are started from here
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext ctx, List<TransactionModel> newList,
                  Widget? _) {
                return ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),

                  //values
                  itemBuilder: (ctx, index) {
                    final value = newList[index];
                    return Slidable(
                      key: Key(value.id!),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (ctx) {
                              TransactionDB.instance
                                  .deleteTransaction(value.id!);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (ctx) {
                              TransactionDB.instance
                                  .editTransaction(value);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            label: 'edit',
                          ),
                        ],
                      ),
                      child: Card(
                        color: value.type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        //color: Colors.white,
                        elevation: .5,
                        child: ListTile(
                        
                          leading: Text(parseDate(value.date)),
                          title: Text(value.category.name),
                          subtitle: Text(value.purpose),
                          trailing: Text(
                            'RS ${value.amount}',
                            style:const TextStyle(color: Colors.white,fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 0,
                    );
                  },
                  itemCount: newList.length > 7 ? 7 : newList.length,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
    
  }
}

class CalanderiInHomePage extends StatelessWidget {
  const CalanderiInHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: double.infinity,
          //color: Colors.blue[100],
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('<  November,2023   >'),
            ],
          ),
        ),
      ],
    );
  }
}
