import 'package:flutter/material.dart';

import '../singletone/DataHolder.dart';

class HLWDrawerClass extends StatelessWidget {

  final Function(int indice)? onItemTap;

  const HLWDrawerClass({super.key,
    required this.onItemTap
  });

  @override
  Widget build(BuildContext context) {

    return Drawer(
        backgroundColor: DataHolder().colorFondo,
        child: ListView(
            children: [
              DrawerHeader(
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                            child: Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.account_circle)
                                  ),
                                  Text(
                                      DataHolder().selectedUser.nombre.toString(),
                                      style: const TextStyle(color: Colors.white)
                                  )
                                ])
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: Row(
                                children: [
                                  Padding(
                                      padding:  EdgeInsets.only(right: 10),
                                      child: Text(
                                          '2050 seguidores',
                                          style: TextStyle(color: Colors.white)
                                      )
                                  ),
                                  Text(
                                      '2000 seguidos',
                                      style: TextStyle(color: Colors.white)
                                  )
                                ])
                        )
                      ])
              ),
              ListTile(
                  leading: const Icon(Icons.ac_unit_rounded, color: Colors.white),
                  selectedColor: DataHolder().colorPrincipal,
                  onTap: () { onItemTap!(0); },
                  title: const Text(
                      'Salir de la cuenta',
                      style: TextStyle(color: Colors.white)
                  )
              ),
              ListTile(
                  leading: const Icon(Icons.accessible_forward_sharp, color: Colors.white),
                  selectedColor: DataHolder().colorPrincipal,
                  onTap: () { onItemTap!(1); },
                  title: const Text(
                      'Gestion/Administracion',
                      style: TextStyle(color: Colors.white)
                  )
              )
            ])
    );
  }
}