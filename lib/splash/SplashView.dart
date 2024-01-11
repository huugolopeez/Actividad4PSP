import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firestoreObjects/FbUsuario.dart';
import '../singletone/DataHolder.dart';

class SplashView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  void checkSession() async {
    await Future.delayed(const Duration(seconds: 4));
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference<FbUsuario> reference = db.collection("Usuarios").doc(uid).withConverter(fromFirestore: FbUsuario.fromFirestore, toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());
      DocumentSnapshot<FbUsuario> docSnap = await reference.get();
      FbUsuario? usuario = docSnap.data();

      if(usuario != null) {
        DataHolder().selectedUser = usuario;
        DataHolder().saveSelectedUserInCache();
        Navigator.of(context).popAndPushNamed('/homeview');
      } else {
        Navigator.of(context).popAndPushNamed('/perfilview');
      }
    } else {
      Navigator.of(context).popAndPushNamed('/loginview');
    }
  }

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(DataHolder().plAdmin.getImage('gatoElegante.jpg'), width: 300, height: 400),
                  const CircularProgressIndicator()
                ]
            )
        )
    );
  }
}