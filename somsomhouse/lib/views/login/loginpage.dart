import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/widgets/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser; //firebase에 user 값을 가져옴.

  void getCurrentUser() {
    try {
      final userUser = _authentication.currentUser;
      if (userUser != null) {
        loggedUser = userUser;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: LoginWidget(),
      ),
    );
  }
}
