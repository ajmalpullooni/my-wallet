import 'package:flutter/material.dart';
import 'package:wallet/screens/Insights/expenses.dart';
import 'package:wallet/screens/Insights/incomes.dart';
import 'package:wallet/screens/Insights/overview.dart';


class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(builder: (ctx) =>const ScreenHome()));
          //     },
          //     icon: const Icon(Icons.arrow_back)),
          title: const Text('Statistics',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),

          
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'), // Add Tab widgets here
              Tab(text: 'Income'),
              Tab(text: 'Expense'),
            ],
          ),
        ),
        body:  const SafeArea(
          child: TabBarView(
            children: [
              MyOverview(),
              IncomeChart(),
              MyExpense(),
            ],
          ),
        ),
      ),
    );
  }
}