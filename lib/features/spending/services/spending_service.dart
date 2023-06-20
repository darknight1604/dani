import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dani/core/constants.dart';
import 'package:dani/core/services/firestore_service.dart';
import 'package:dani/core/utils/firestore/firestore_order_by.dart';
import 'package:dani/features/spending/models/spending.dart';
import 'package:dani/features/spending/models/spending_category.dart';

import '../models/spending_request.dart';

class SpendingService {
  final FirestoreService firestoreService;

  SpendingService(this.firestoreService);

  final String _collectionName = 'spending_category';
  final String _collectionSpending = 'spending_request';

  late QueryDocumentSnapshot _lastDocumentSpending;

  Future<List<SpendingCategory>> getListSpendingCategory() async {
    QuerySnapshot querySnapshot =
        await firestoreService.getCollection(_collectionName);
    return querySnapshot.docs.map((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      data[Constants.id] = element.id;
      return SpendingCategory.fromJson(data);
    }).toList();
  }

  Future<List<Spending>> getListSpending({
    QueryDocumentSnapshot<Object?>? lastDocumentSnapshot,
    int? limit,
  }) async {
    QuerySnapshot? querySnapshot = await firestoreService.getCollectionByUser(
      limit: limit,
      _collectionSpending,
      lastDocumentSnapshot: lastDocumentSnapshot,
      listOrderBy: [
        FirestoreOrderByDesending(Constants.createdDate),
      ],
    );
    if (querySnapshot == null || querySnapshot.docs.isEmpty) return [];
    _lastDocumentSpending = querySnapshot.docs.last;
    return querySnapshot.docs.map((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      data[Constants.id] = element.id;

      return Spending.fromJson(data);
    }).toList();
  }

  Future<List<Spending>> loadMoreListSpending() async => getListSpending(
        lastDocumentSnapshot: _lastDocumentSpending,
        limit: Constants.limitNumberOfItem,
      );

  Future<bool> addSpendingRequest(SpendingRequest spendingRequest) async {
    return await firestoreService.createDocument(
      collectionPath: _collectionSpending,
      data: spendingRequest.toJson(),
    );
  }

  Future<bool> updateSpendingRequest(SpendingRequest spendingRequest) async {
    return await firestoreService.updateDocument(
      collectionPath: _collectionSpending,
      data: spendingRequest.toJson(),
    );
  }
}
