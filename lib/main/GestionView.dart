import 'package:flutter/material.dart';

import '../singletone/DataHolder.dart';

class GestionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: DataHolder().colorFondo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Sin terminar..'),
      ),
    );
  }
}