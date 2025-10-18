import 'package:flutter/material.dart';
import 'package:tic_tac_toe/views/home_page.dart';

void main() async {
  runApp(SplashScreen());
  await Future.delayed(Duration(seconds: 3));
  runApp(MyApp());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [
                Color(0xff6FA8DC),
                Color(0xff93C47D),
                Color(0xffFFE084),
                Colors.white,
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/tic-tac-toe.png',
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Text(
                'Tic\nTac\nToe',
                style: TextStyle(
                  fontSize: 120,
                  fontFamily: 'Nosifer',
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
