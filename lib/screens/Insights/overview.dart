import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:wallet/calculation/sort.dart';
import 'package:wallet/db/transactions/transaction_db.dart';
import 'package:wallet/models/transactions/transaction_model.dart';

import '../../models/category/category_models.dart';

// Define a ValueNotifier for chart data
ValueNotifier<List<TransactionModel>> overviewChartList =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class MyOverview extends StatefulWidget {
  const MyOverview({super.key});

  @override
  State<MyOverview> createState() => _MyOverviewState();
}

class _MyOverviewState extends State<MyOverview> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: overviewChartList,
        builder: (BuildContext context, List<TransactionModel> newList, Widget? _) {
          // Calculate the income and expense totals from your list of transactions
          double incomeTotal = calculateIncomeTotal(newList);
          double expenseTotal = calculateExpenseTotal(newList);

          Map incomeMap = {"name": "Income", "amount": incomeTotal};
          Map expenseMap = {"name": "Expense", "amount": expenseTotal};
          List<Map> chartList = [incomeMap, expenseMap];

          return chartList.isEmpty
              ? Center(
                  child: Text('No data', style: GoogleFonts.quicksand()),
                )
              : Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SfCircularChart(
                    backgroundColor: Colors.white,
                    legend: const Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<Map, String>(
                        dataSource: chartList,
                        xValueMapper: (Map data, _) => data['name'],
                        yValueMapper: (Map data, _) => data['amount'],
                        enableTooltip: true,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  double calculateIncomeTotal(List<TransactionModel> transactions) {
    
    double total = 0.0;
    for (var transaction in transactions) {
      if (transaction.category.type == CategoryType.income) {
        total += transaction.amount;
      }
    }
    return total;
  }

  double calculateExpenseTotal(List<TransactionModel> transactions) {
    
    double total = 0.0;
    for (var transaction in transactions) {
      if (transaction.category.type == CategoryType.expense) {
        total += transaction.amount;
      }
    }
    return total;
  }
}
