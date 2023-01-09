import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somsomhouse/view_models/final_view_models.dart';

class SingUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 129, 131, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 129, 131, 244),
        title: const Text(
          '회원가입',
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
            PasswordConfirmInput(),
            RegistButton()
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<FinalViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(5),
      child: TextField(
        onChanged: (email) {
          register.setRegisterEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'email',
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<FinalViewModel>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      child: TextField(
        onChanged: (password) {
          register.setRegisterPassword(password);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          helperText: '',
          errorText:
              register.registerPassword != register.registerPasswordConfirm
                  ? 'Password incorrect'
                  : null,
        ),
      ),
    );
  }
}

class PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<FinalViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(5),
      child: TextField(
        onChanged: (password) {
          register.setRegisterPasswordConfirm(password);
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'password confirm',
          helperText: '',
        ),
      ),
    );
  }
}

class RegistButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<FinalViewModel>(context, listen: false);
    final register = Provider.of<FinalViewModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed:
            (register.registerPassword != register.registerPasswordConfirm)
                ? null
                : () async {
                    await authClient
                        .registerWithEmail(
                            register.registerEmail, register.registerPassword)
                        .then((registerStatus) {
                      if (registerStatus == AuthStatus.registerSuccess) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(content: Text('회원가입 성공!')),
                          );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(content: Text('회원가입 실패')),
                          );
                      }
                    });
                  },
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
