import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost {

  final String titulo;
  final String cuerpo;
  final String imagen;

  FbPost({
    required this.titulo,
    required this.cuerpo,
    required this.imagen
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return FbPost(
        titulo: data?['titulo'],
        cuerpo: data?['cuerpo'],
        imagen: data?['imagen']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo" : titulo,
      if (cuerpo != null) "cuerpo" : cuerpo,
      if (imagen != null) "imagen" : imagen
    };
  }
}