import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dani/core/utils/firestore/firestore_query.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getCollection(
    String collectionPath,
    List<FirestoreQuery>? queries,
  ) async {
    CollectionReference collection = _firestore.collection(collectionPath);
    if (queries != null && queries.isNotEmpty) {
      return FirestoreQueryHelper.magic(collection, queries).get();
    }
    return await collection.get();
  }

  Future<bool> createDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    CollectionReference collection = _firestore.collection(collectionPath);

    return await collection
        .add(data)
        .then((value) => true)
        .catchError((_) => false);
  }
}
