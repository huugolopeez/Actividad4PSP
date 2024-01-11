import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {

  final String nombre;
  final int edad;

  FbUsuario({
    required this.nombre,
    required this.edad
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return FbUsuario(
        nombre: data?['nombre'],
        edad: data?['edad']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre" : nombre,
      if (edad != null) "edad" : edad
    };
  }
}