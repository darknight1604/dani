import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/firestore/firestore_order_by.dart';
import 'package:dani/core/utils/firestore/firestore_query.dart';
import 'package:dani/core/utils/string_util.dart';

import '../../utils/iterable_util.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getCollection(
    String collectionPath, {
    List<FirestoreQuery>? queries,
    List<FirestoreOrderBy>? listOrderBy,
  }) async {
    CollectionReference collection = _firestore.collection(collectionPath);
    if (IterableUtil.isNullOrEmpty(queries) &&
        IterableUtil.isNullOrEmpty(listOrderBy)) {
      return await collection.get();
    }
    if (IterableUtil.isNotNullOrEmpty(queries) &&
        IterableUtil.isNotNullOrEmpty(listOrderBy)) {
      return await FirestoreOrderByHelper.magicByQuery(
        FirestoreQueryHelper.magic(collection, queries!),
        listOrderBy!,
      ).get();
    }
    if (queries != null && queries.isNotEmpty) {
      return FirestoreQueryHelper.magic(collection, queries).get();
    }
    return await FirestoreOrderByHelper.magic(collection, listOrderBy!).get();
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

  Future<bool> updateDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    String? id = data[Constants.id];
    if (StringUtil.isNullOrEmpty(id)) {
      return false;
    }
    CollectionReference collection = _firestore.collection(collectionPath);
    return await collection
        .doc(id)
        .update(data)
        .then((value) => true)
        .catchError((_) => false);
  }
}
