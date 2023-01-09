import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somsomhouse/view_models/final_view_models.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 178, 223),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 177, 178, 223),
        title: const Text(
          '로그인',
          style: TextStyle(
            fontSize: 35,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            EmailInput(),
            PasswordInput(),
            LoginButton(),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Divider(
                thickness: 1,
              ),
            ),
            RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<FinalViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        onChanged: (email) {
          login.setloginEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: '이메일',
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<FinalViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        onChanged: (password) {
          login.setloginPassword(password);
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: '비밀번호',
          helperText: '',
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<FinalViewModel>(context, listen: false);
    final login = Provider.of<FinalViewModel>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 222, 129, 160),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          await authClient
              .loginWithEmail(login.loginEmail, login.loginPassword)
              .then((loginStatus) {
            if (loginStatus == AuthStatus.loginSuccess) {
              //models에 저장되어있는 AuthStatus값을 가져옴
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text('환영합니다! ' + authClient.user!.email! + ' ')));
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('로그인 실패')));
            }
          });
        },
        child: const Text(
          '로그인',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/singup');
        },
        child: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(200, 186, 30, 233),
          ),
        ));
  }
}
