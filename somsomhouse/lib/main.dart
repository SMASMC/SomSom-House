import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somsomhouse/view_models/final_view_models.dart';
import 'package:somsomhouse/views/home.dart';
import 'package:somsomhouse/views/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinalViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => const Home(),
        },
      ),
    );
  }
}
