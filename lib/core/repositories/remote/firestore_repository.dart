import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  Future<QuerySnapshot> getCollection(String collectionPath) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection(collectionPath);
    return await collection.get();
  }
}
