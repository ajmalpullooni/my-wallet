import 'package:flutter/material.dart';
import 'package:wallet/db/category/category_db.dart';
import 'package:wallet/screens/category/category_add_popup.dart';
import 'package:wallet/screens/category/expense_category_list.dart';
import 'package:wallet/screens/category/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(child: Container(
          color: Colors.grey,
          height: .3,
        ), preferredSize: Size.fromHeight(0)),
        title: const Text(
          'Category',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),

        /// backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      //drawer: Drawer(),
      body: Column(
        children: [
          TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                ),
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              IncomeCategoryList(),
              ExpenseCategoryList(),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          showCategoryAddPopup(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
