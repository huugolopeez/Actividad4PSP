import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom/HLButtonsBoarding.dart';
import '../custom/HLTextField.dart';
import '../singletone/DataHolder.dart';

class WLoginView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPass = TextEditingController();

  throwSnackBar(String error) {
    SnackBar snackBar = SnackBar(content: Text(error));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  onClickRegister() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  onClickLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecEmail.text,
          password: tecPass.text
      );
      Navigator.of(_context).popAndPushNamed('/splashview');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print(' --> Formato del email incorrecto.');
        throwSnackBar('-- Formato del email incorrecto --');
      } else if (e.code == 'invalid-login-credentials') {
        print(' --> Credenciales incorrectas.');
        throwSnackBar('-- Credenciales incorrectas --');
      }
    }
  }

  void onHLButtonsBoarding(int indice) {
    if(indice == 0) {
      onClickLogin();
    } else if(indice == 1) {
      onClickRegister();
    }
  }

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        appBar: AppBar(
            title: const Text('Login'),
            centerTitle: true,
            backgroundColor: DataHolder().colorPrincipal
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(DataHolder().plAdmin.getImage('gatoElegante.jpg'), height: 200),
              HLTextField(sLabel: 'Username', tecController: tecEmail, iIcon: const Icon(Icons.account_circle_rounded)),
              HLTextField(sLabel: 'Password', tecController: tecPass, blIsPassword: true, iIcon: const Icon(Icons.password)),
              HLButtonsBoarding(sText0: const Text('Login'), sText1: const Text('Register'), evento: onHLButtonsBoarding)
            ]
        )
    );
  }
}