import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom/HLButtonsBoarding.dart';
import '../custom/HLTextField.dart';
import '../firestoreObjects/FbUsuario.dart';
import '../singletone/DataHolder.dart';

class PerfilView extends StatelessWidget {

  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecName = TextEditingController();
  TextEditingController tecAge = TextEditingController();

  Future<void> onClickAceptar() async {

    FbUsuario usuario = FbUsuario(nombre: tecName.text, edad: int.parse(tecAge.text));

    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUser).set(usuario.toFirestore());
    Navigator.of(_context).popAndPushNamed('/splashview');
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onHLTextutton(int indice) {
    if(indice == 0) {
      onClickAceptar();
    } else if(indice == 1) {
      onClickCancelar();
    }
  }

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        appBar: AppBar(
            title: const Text('Perfil'),
            centerTitle: true,
            backgroundColor: DataHolder().colorPrincipal
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(DataHolder().plAdmin.getImage('gatoElegante.jpg'), height: 200),
              HLTextField(sLabel: 'Nombre', tecController: tecName, iIcon: const Icon(Icons.drive_file_rename_outline_sharp)),
              HLTextField(sLabel: 'Edad', tecController: tecAge, iIcon: const Icon(Icons.drive_file_rename_outline_sharp)),
              HLButtonsBoarding(sText0: const Text('Aceptar'), sText1: const Text('Cancelar'), evento: onHLTextutton)
            ]
        )
    );
  }
}