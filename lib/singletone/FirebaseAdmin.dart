import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestoreObjects/FbPost.dart';
import 'DataHolder.dart';

class FirebaseAdmin {

  Future<QuerySnapshot<FbPost>> getPosts() async {

    CollectionReference<FbPost> reference = DataHolder().db.collection("Posts").withConverter(
        fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    return await reference.get();
  }

  void insertPost(FbPost post) {
    CollectionReference<FbPost> postRef = DataHolder().db.collection('Posts').withConverter(
        fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore()
    );

    postRef.add(post);
  }

  Future<List<Map<String, dynamic>>> getPostByTitle(String searchValue) async {
    QuerySnapshot querySnapshot = await DataHolder().db
        .collection('Posts')
        .where('titulo', isGreaterThanOrEqualTo: searchValue)
        .get();

    return querySnapshot.docs
        .where((doc) =>
    (doc['titulo'] as String).contains(searchValue))
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}