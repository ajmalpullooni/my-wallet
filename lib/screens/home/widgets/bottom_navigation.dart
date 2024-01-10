import 'package:flutter/material.dart';
import 'package:wallet/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

   

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget?_) {
        return BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        currentIndex: updatedIndex,
        onTap: (newIndex) {
           ScreenHome.selectedIndexNotifier.value=newIndex;
        },
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Home'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.category),
          label: 'Category'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.insights),
          label: 'Statistics'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
          label: 'Settings'
          ),

        ],
      );
      },
    );
  }
}
