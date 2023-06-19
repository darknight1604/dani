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
  static Query<Object?> magicByQuery(
    Query<Object?> query,
    List<FirestoreOrderBy> listOrderBy, {
    int? start,
    int? end,
  }) {
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
    // if (start != null) {
    //   query = query.startAt([start.toString()]);
    // }
    // if (end != null) {
    // query = query.endAt([end.toString()]);
    // }
    query = query.startAfter([20230610]);
    // query = query.endBefore([end]).limit(10);
    print('end: $end');
    // query = query.endBefore([20230611]);
    return query;
  }
}
