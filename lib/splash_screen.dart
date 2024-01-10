import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/screens/home/screen_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final montserratFont = GoogleFonts.montserrat();

  @override
  void initState() {
    _navigatetohome();
    super.initState();


  }
  Future<void> _navigatetohome()async{
    await Future.delayed(const Duration(seconds: 7),(){

    });
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const ScreenHome();
    },));
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Lottie.network('https://lottie.host/12f523e1-1acc-4230-9693-2ae6bc9b2cd0/CVpIDPeh24.json'),
        // const Text('data'),
          Container(
            child: 
              Column(
                children: [
                  Text('MyWallet', style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.w600, fontFamily: montserratFont.fontFamily)),
                   const Text(
                    'Save Your money',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10  ,
                    ),
               ),
                ],
              ),
              
            
          ),
          
          FutureBuilder(
            future: _navigatetohome(),
            builder: (context, snapshot) {
            if(snapshot.hasData){
               return Text('MyWallet', style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.w500, fontFamily: montserratFont.fontFamily));
               
              //return Text('data');
            }else{
              return Container();
            }
          },)
        ],
      ),
     
    );
  }
}