import 'dart:async';
import 'package:flutter/material.dart';

//화면 처음 나오는거
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveScreen() async {
    Navigator.pushNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000), () {
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.asset('images/솜솜하우스_배너.png'),
            ],
          ),
        ),
      ),
    );
  }
}
