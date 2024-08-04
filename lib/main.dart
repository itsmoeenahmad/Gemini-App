import 'package:flutter/material.dart';
import 'package:geminiapp/Screens/LogicCode/logicCode.dart';
import 'package:provider/provider.dart';
import 'Screens/SplashScreen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ProviderClass() )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: splashScreen(),
      ),
    );
  }
}
