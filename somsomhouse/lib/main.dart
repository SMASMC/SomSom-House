import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somsomhouse/firebase_options.dart';
import 'package:somsomhouse/view_models/final_view_models.dart';
import 'package:somsomhouse/view_models/model_auth.dart';
import 'package:somsomhouse/views/home.dart';
import 'package:somsomhouse/views/loginpage.dart';
import 'package:somsomhouse/views/signuppage.dart';
import 'package:somsomhouse/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
      ],
      child: MaterialApp(
        // return ChangeNotifierProvider(
        //   create: (context) => FinalViewModel(),
        //   child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => const Home(),
          '/login': (context) => LoginScreen(),
          '/singup': (context) => SingUpPage(),
        },
      ),
    );
  }
}
