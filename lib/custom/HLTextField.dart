import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HLTextField extends StatelessWidget {

  String sLabel;
  TextEditingController tecController;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;
  Icon iIcon;

  HLTextField({Key? key,
    required this.sLabel,
    required this.tecController,
    required this.iIcon,
    this.blIsPassword = false,
    this.dPaddingH = 60,
    this.dPaddingV = 16
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: dPaddingH, vertical: dPaddingV),
        child: Row(
            children: [
              Flexible(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                    child: TextFormField(
                        controller: tecController,
                        obscureText: blIsPassword,
                        decoration: InputDecoration(
                            icon: Padding(padding: EdgeInsets.only(left: 10), child: iIcon),
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: sLabel
                        )),
                  ))
            ]
        )
    );
  }
}