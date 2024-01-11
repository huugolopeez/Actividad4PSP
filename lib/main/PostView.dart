import 'package:flutter/material.dart';

import '../singletone/DataHolder.dart';

class PostView extends StatefulWidget {

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  bool blPostLoaded = false;

  @override
  void initState() {
    super.initState();
    cargarPostCache();
  }

  void cargarPostCache() async {
    setState(() {
      blPostLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent
        ),
        body: blPostLoaded ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(40, 40, 0, 20),
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
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(DataHolder().selectedPost.titulo, style: const TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(DataHolder().selectedPost.cuerpo, style: const TextStyle(color: Colors.white)),
              ),
              if(DataHolder().selectedPost.imagen != '')
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                      child: Image.network(DataHolder().selectedPost.imagen, height: 200)
                  ),
                )
            ]
        )
            :
        const CircularProgressIndicator()
    );
  }
}