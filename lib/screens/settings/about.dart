import 'package:flutter/material.dart';

class MyAbout extends StatelessWidget {
  const MyAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('About Us',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
          centerTitle: true,
          //backgroundColor: Colors.white
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  //color: Colors.amber,
                  height: 250,
                  width: 200,
                  child:const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'MyWallet',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                       Text(
                     "Developed by\n      Ajmal",
                  ),
                  Text(
                     'Version 1.0.2',
                  ),
                    ],
                  ),
                )
              ],
            ),
          ),
  //     body:Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           // alignment: Alignment(0, 0),
  //           alignment: Alignment.center,
  //           height: 300,
  //           width: 200,
  //           color: Colors.amber,
  //           child: Column(
              
  //            //crossAxisAlignment: CrossAxisAlignment.center,
  //            // mainAxisAlignment: MainAxisAlignment.center,
  //             children:  [
  //               Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 20),
  //                 child: Text(
  //                   'MyWallet',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w500,
  //                     fontSize: 20,
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 10),
  //                 child: Text(
  //                   "    Developed by\n         Ajmal",
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 10),
  //                 child: Text(
  //                   'Version 1.0.2',
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
     );
  }
}