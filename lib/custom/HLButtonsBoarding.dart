import 'package:flutter/material.dart';

import '../singletone/DataHolder.dart';

class HLButtonsBoarding extends StatelessWidget {

  Function(int indice)? evento;
  Widget sText0;
  Widget sText1;

  HLButtonsBoarding({Key? key,
    required this.sText0,
    required this.sText1,
    this.evento
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 150, height: 50),
              child: ElevatedButton(
                  onPressed: () => evento!(0),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(DataHolder().colorFondo),
                      side: MaterialStateProperty.all(BorderSide(color: DataHolder().colorPrincipal)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ))),
                  child: sText0
              )),
          ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 150, height: 50),
              child: ElevatedButton(
                  onPressed: () => evento!(1),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(DataHolder().colorPrincipal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ))),
                  child: sText1
              ))
        ]
    );
  }
}