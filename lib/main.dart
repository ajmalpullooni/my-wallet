import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:wallet/models/category/category_models.dart';
import 'package:wallet/models/transactions/transaction_model.dart';
import 'package:wallet/screens/add_transaction/screen_add_transaction.dart';

import 'package:wallet/splash_screen.dart';

Future<void> main() async{

  // final  obj1=CategoryDB();
  // final obj2=CategoryDB();
  
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();

 if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
  Hive.registerAdapter(CategoryTypeAdapter());
 }

 if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
  Hive.registerAdapter(CategoryModelAdapter());
 }

 if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
  Hive.registerAdapter(TransactionModelAdapter());
 }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        ScreenaddTransaction.routeName:(ctx) =>const ScreenaddTransaction(),
      },
    );
  }
}
