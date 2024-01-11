import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    setState(() {
      if(index == 0) {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => WLoginView()),
            ModalRoute.withName('/loginview')
        );
      } else if(index == 1) {
        Navigator.of(context).pushNamed('/gestionview');
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