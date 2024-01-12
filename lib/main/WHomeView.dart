import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../custom/HLBottomMenu.dart';
import '../custom/HLPostCellView.dart';
import '../custom/HLPostGridCellView.dart';
import '../custom/HLWDrawerClass.dart';
import '../firestoreObjects/FbPost.dart';
import '../onBoarding/WLoginView.dart';
import '../singletone/DataHolder.dart';

class WHomeView extends StatefulWidget {

  @override
  State<WHomeView> createState() => _WHomeViewState();
}

class _WHomeViewState extends State<WHomeView> {

  final List<FbPost> posts = [];
  bool bIsList = true;

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  void getPosts() async {
    QuerySnapshot<FbPost> querySnap = await DataHolder().fbAdmin.getPosts();

    for(int i = 0 ; i < querySnap.docs.length ; i++) {
      setState(() {
        posts.add(querySnap.docs[i].data());
      });
    }
  }

  void onItemTapList(int index) {
    DataHolder().selectedPost = posts[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed('/postview');
  }

  void onItemTapDrawer(int index) {
    setState(() async {
      if(index == 0) {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => WLoginView()),
            ModalRoute.withName('/loginview')
        );
      } else if(index == 1) {
        Navigator.of(context).pushNamed('/gestionview');
      } else if(index == 2) {
        TextEditingController _searchController = TextEditingController();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Buscar Post por Título'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Ingrese el título a buscar',
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String searchValue = _searchController.text.trim();
                      if (searchValue.isNotEmpty) {
                        Navigator.of(context).pop();

                        List<Map<String, dynamic>> searchResults =
                        await DataHolder().fbAdmin.getPostByTitle(searchValue);

                        if (searchResults.isNotEmpty) {
                          print("HE ENTRADDOOOOO");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Resultados de la Búsqueda'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var result in searchResults)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('título: ${result['titulo']}'),
                                          Text('cuerpo: ${result['cuerpo']}'),
                                        ])
                                  ]),
                                actions: [
                                  TextButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }
                                  )]
                              );
                            }
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Resultados de la Búsqueda'),
                                content: Text('No se encontraron posts con el título proporcionado.'),
                                actions: [
                                  TextButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }
                                  )]
                              );
                            }
                          );
                        }
                      }
                    },
                    child: Text('Buscar'),
                  ),
                ],
              ),
            );
          },
        );
      } else if(index == 3) {
        Position currentPosition = await DataHolder().geolocAdmin.registrarCambiosLoc();
        GeoPoint currentGeoPoint = GeoPoint(currentPosition.latitude, currentPosition.longitude);
        await DataHolder().geolocAdmin.agregarUbicacionEnFirebase(currentGeoPoint);
        List<String> usersInRange = await DataHolder().geolocAdmin.obtenerUsuariosEnRango();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Usuarios en rango de 5 km:'),
              content: Column(
                children: usersInRange
                    .map(
                      (userId) => Text(
                    userId ?? 'Usuario sin ID',
                    // 'Usuario sin ID' se mostrará si userId es nulo
                  ),
                )
                    .toList(),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void onBottomMenuPressed(int index) {
    setState(() {
      if(index == 0) {
        bIsList = true;
      } else if(index == 1) {
        bIsList = false;
      }
    });
  }

  Widget? gridOrList(bool bIsList) {
    if(bIsList) {
      return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return HLPostCellView(
                sTitle: posts[index].titulo,
                sBody: posts[index].cuerpo,
                sImage: posts[index].imagen,
                dFontSize: 30,
                iPosition: index,
                onItemTap: onItemTapList
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }
      );
    } else {
      return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 125,
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return HLPostGridCellView(
                sTitle: posts[index].titulo,
                sBody: posts[index].cuerpo,
                dFontSize: 30,
                iPosition: index,
                onItemTap: onItemTapList
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Center(
            child: gridOrList(bIsList)
        ),
        bottomNavigationBar: HLBottomMenu(evento: onBottomMenuPressed),
        drawer: HLWDrawerClass(onItemTap: onItemTapDrawer),
        floatingActionButton: FloatingActionButton(
            onPressed: () { Navigator.of(context).popAndPushNamed('/postcreateview'); },
            backgroundColor: DataHolder().colorPrincipal,
            child: const Icon(Icons.add)
        )
    );
  }
}