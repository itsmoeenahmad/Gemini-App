import 'package:flutter/material.dart';

import '../HomeScreen/homeScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const homeScreen() ));
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.35),
        child: Center(
          child: Image.asset('assets/geminiLogo.png'),
        ),
      ),
    );
  }
}
