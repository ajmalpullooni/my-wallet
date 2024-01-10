import 'package:flutter/material.dart';
import 'package:wallet/screens/settings/about.dart';
import 'package:wallet/screens/settings/privacy_policy.dart';
import 'package:wallet/screens/settings/terms_and_conditions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.amber,
        bottom: PreferredSize(child: Container(
          color: Colors.grey,
          height: .3,
        ), preferredSize: Size.fromHeight(0)),
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          
        ),
        centerTitle: true,
      ),
      body: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      
      ListTile(
        leading:const Icon(Icons.info),
        title: const Text(' About'),
       onTap: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
           return const MyAbout();
         },));
        },
      ),
       ListTile(
        leading:const Icon(Icons.privacy_tip),
        title: const Text('Privacy Policy'),
        onTap: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
           return const PrivacyPolicy();
         },));
        },
      ),
       ListTile(
        leading:const Icon(Icons.list),
        title: const Text('Terms and Conditions'),
       onTap: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
           return const TeamsCondition();
         },));
        },
      ),
      //  ListTile(
      //   leading:const Icon(Icons.refresh),
      //   title: const Text('Reset App'),
      //   onTap: () {
      //    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //      return const PrivacyPolicy();
      //    },));
      //   },
      // ),
      
    ],
  ),
    );
  }
}
