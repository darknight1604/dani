import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreQuery {
  final String key;
  final List<String> listValue;

  FirestoreQuery(this.key, this.listValue);
}

class FirestoreQueryEqualTo extends FirestoreQuery {
  FirestoreQueryEqualTo(super.key, super.listValue);
}

class FirestoreQueryNotEqualTo extends FirestoreQuery {
  FirestoreQueryNotEqualTo(super.key, super.listValue);
}

class FirestoreQueryHelper {
  static Query<Object?> _magic(
    CollectionReference<Object?> collectionRef,
    FirestoreQuery query,
  ) {
    switch (query.runtimeType) {
      case FirestoreQueryEqualTo:
        return collectionRef.where(query.key, isEqualTo: query.listValue.first);
      default:
    }
    return collectionRef;
  }

  static Query<Object?> magic(
    CollectionReference<Object?> collectionRef,
    List<FirestoreQuery> firestoreQueries,
  ) {
    Query<Object?> query = collectionRef;
    for (var firestoreQuery in firestoreQueries) {
      query = _magic(collectionRef, firestoreQuery);
    }
    return query;
  }
}
