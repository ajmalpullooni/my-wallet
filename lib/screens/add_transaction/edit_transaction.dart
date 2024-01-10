import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:wallet/db/category/category_db.dart';
import 'package:wallet/db/transactions/transaction_db.dart';
import 'package:wallet/models/category/category_models.dart';
import 'package:wallet/models/transactions/transaction_model.dart';


// ignore: must_be_immutable
class EditTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  TransactionModel editTransaction;
  final int id;
   EditTransaction({super.key, required this.id,required this.editTransaction});

  @override
  State<EditTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<EditTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  final _dateTextEditingController = TextEditingController();
  bool isDataSaved = false;

  /*
  Purpose
  amount
  category type
  date
  submit button
   */

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    _dateTextEditingController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // drawer: Drawer(),
      appBar: AppBar(
        //backgroundColor: Colors.amber,
        bottom: PreferredSize(child: Container(
          color: Colors.grey,
          height: .3,
        ), preferredSize: Size.fromHeight(0)),
        title: const Text(
          'Add Transaction',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Radio button category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.income;
                          categoryID = null;
                          print(_selectedCategoryType);
                        });
                      },
                    ),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.expense;
                          categoryID = null;
                          print(_selectedCategoryType);
                        });
                      },
                    ),
                    const Text('Expense'),
                  ],
                ),
              ],
            ),

            //Category Type
            Row(
              children: [
                const Text('Category'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: categoryID,
                    iconSize: 0,
                    //hint: const Text('Select Catgory'),
                    items: (_selectedCategoryType == CategoryType.income
                            ? CategoryDB().incomeCategoryListListener
                            : CategoryDB().expenseCategoryListListener)
                        .value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                        onTap: () {
                          print(e.toString());
                          _selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedvalue) {
                      print(selectedvalue);
                      setState(() {
                        categoryID = selectedvalue;
                      });
                    },
                  ),
                ),
              ],
            ),

            //Date
            Row(
              children: [
                const Text('Date'),
                const SizedBox(
                  width: 45,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: .1),
                    )),
                    readOnly: true,
                    controller: _dateTextEditingController,
                    onTap: () async {
                      final _selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1998),
                        lastDate: DateTime(2025),
                      );

                      if (_selectedDateTemp == null) {
                        return;
                      } else {
                        print(_selectedDateTemp.toString());
                        setState(() {
                          _selectedDate = _selectedDateTemp;
                          _dateTextEditingController.text =
                              DateFormat('dd-MM-yyyy')
                                  .format(_selectedDateTemp);
                        });
                      }
                     
                    },
                  ),
                ),
              ],
            ),

            //amount
            Row(
              children: [
                const Text('Amount '),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: .1),
                    )),
                    controller: _amountTextEditingController,
                    keyboardType: TextInputType.number,
                    // decoration: const InputDecoration(hintText: 'Amount'),
                  ),
                ),
              ],
            ),

            //purpose

            Row(
              children: [
                const Text('Purpose'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: .1),
                    )),
                    controller: _purposeTextEditingController,
                    keyboardType: TextInputType.text,
                    // decoration: const InputDecoration(hintText: 'Amount'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            
            //Submit
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    
                    addTransaction();
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (categoryID == null) {
      return;
    }
    // if (_selectedDate == null) {
    //   return;
    // }
    if (_selectedCategoryModel == null) {
      return;
    }

    final _parseamount = double.tryParse(_amountText);
    if (_parseamount == null) {
      return;
    }

    final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parseamount,
        date: _selectedDate ?? DateTime.now(),
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!,
        id: DateTime.now().millisecondsSinceEpoch.toString());
        // if(_selectedCategoryType==CategoryType.income){

        // }
        
 Future.delayed(const Duration(seconds: 2),);
    await TransactionDB.instance.addTransaction(_model);
    TransactionDB.instance.refresh();
    Navigator.of(context).pop();
   
  }

 
}
