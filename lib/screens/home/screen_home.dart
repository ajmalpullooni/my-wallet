import 'package:flutter/material.dart';
import 'package:wallet/screens/category/screen_category.dart';
import 'package:wallet/screens/home/widgets/bottom_navigation.dart';
import 'package:wallet/screens/Insights/screen_insights.dart';
import 'package:wallet/screens/transactions/screen_transactions.dart';

import '../settings/settings_screen.dart';

class ScreenHome extends StatelessWidget {
 const  ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
    Statistics(),
    SettingsScreen(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // bottomSheet: Text('data'),
      bottomNavigationBar:const MoneyManagerBottomNavigation(),
      body: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context,int updatedIndex, _) {
         return _pages[updatedIndex];
        },
      ),
      
    );
  }
}
