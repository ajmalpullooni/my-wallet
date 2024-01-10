import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_models.dart';
import '../../models/transactions/transaction_model.dart';

class SeeAllTransaction extends StatefulWidget {
  const SeeAllTransaction({super.key});

  @override
  State<SeeAllTransaction> createState() => _SeeAllTransactionState();
}

class _SeeAllTransactionState extends State<SeeAllTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.pink,
        // title:const Text('Transaction List'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              color: Colors.grey,
              height: .3,
            )),
        title: const Text(
          'Transaction List',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(5),
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
                        TransactionDB.instance.deleteTransaction(value.id!);
                      },
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      label: 'Delete',
                    ),
                  ],
                ),
                // child: Card(
                //   color: value.type == CategoryType.income
                //       ? Colors.green
                //       : Colors.red,
                //   elevation: .5,
                //   child: ListTile(
                //     leading: CircleAvatar(
                //       radius: 30,
                //       backgroundColor: value.type == CategoryType.income
                //           ? Colors.green
                //           : const Color.fromARGB(255, 231, 27, 61),
                //       child: Text(
                //         parseDate(value.date),
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(fontSize: 12),
                //       ),
                //     ),
                //     title: Text('RS ${value.amount}'),
                //     subtitle: Text(value.category.name),
                //     trailing: Text(value.purpose),
                //   ),
                // ),
               child: Card(
                        color: value.type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        //color: Colors.white,
                        elevation: .5,
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   radius: 30,
                          //   backgroundColor: value.type == CategoryType.income
                          //       ? Colors.green
                          //       : Colors.red,
                          //   child: Text(
                          //     parseDate(value.date),
                          //     textAlign: TextAlign.center,
                          //     style: const TextStyle(fontSize: 12),
                          //   ),
                          // ),
                          // title: Text('RS ${value.amount}'),
                          // subtitle: Text(value.category.name),
                          // trailing: Text(value.purpose),
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
                height: 1,
              );
            },
            itemCount: newList.length,
          );
        },
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
    // final _date= DateFormat.MMMd().format(date);
    // final _splitDate=_date.split('');
    // return '${_splitDate.first}\n${_splitDate.last}';
    //return '${date.day}\n${date.month}';
  }
}
