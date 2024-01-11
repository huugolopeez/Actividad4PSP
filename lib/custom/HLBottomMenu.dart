import 'package:flutter/material.dart';

import '../singletone/DataHolder.dart';

class HLBottomMenu extends StatelessWidget {

  Function(int indice)? evento;

  HLBottomMenu({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => evento!(0), child: Icon(Icons.list, color: DataHolder().colorPrincipal)),
          TextButton(onPressed: () => evento!(1), child: Icon(Icons.grid_view, color: DataHolder().colorPrincipal))
        ]
    );
  }
}