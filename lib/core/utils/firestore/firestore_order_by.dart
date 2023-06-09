import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreOrderBy {
  final String key;

  FirestoreOrderBy(this.key);
}

class FirestoreOrderByAscending extends FirestoreOrderBy {
  FirestoreOrderByAscending(super.key);
}

class FirestoreOrderByDesending extends FirestoreOrderBy {
  FirestoreOrderByDesending(super.key);
}

class FirestoreOrderByHelper {
  static Query<Object?> _magic(
      CollectionReference<Object?> collectionRef, FirestoreOrderBy orderBy) {
    switch (orderBy.runtimeType) {
      case FirestoreOrderByDesending:
        return collectionRef.orderBy(orderBy.key, descending: true);
      default:
        return collectionRef.orderBy(orderBy.key);
    }
  }

  static Query<Object?> magic(CollectionReference<Object?> collectionRef,
      List<FirestoreOrderBy> listOrderBy) {
    Query<Object?> query = collectionRef;
    for (var orderBy in listOrderBy) {
      query = _magic(collectionRef, orderBy);
    }
    return query;
  }

  static Query<Object?> magicByQuery(
    Query<Object?> query,
    List<FirestoreOrderBy> listOrderBy,
  ) {
    for (var orderBy in listOrderBy) {
      switch (orderBy.runtimeType) {
        case FirestoreOrderByDesending:
          query = query.orderBy(orderBy.key, descending: true);
          break;
        default:
          query = query.orderBy(orderBy.key);
          break;
      }
    }
    return query;
  }
}
