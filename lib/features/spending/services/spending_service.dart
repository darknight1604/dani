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

  List<SpendingCategory> result = [];

  final String _collectionName = 'spending_category';
  final String _collectionSpending = 'spending_request';

  Future<List<SpendingCategory>> getListSpendingCategory() async {
    if (result.isNotEmpty) return result;

    QuerySnapshot querySnapshot =
        await firestoreService.getCollection(_collectionName);
    querySnapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      data[Constants.id] = element.id;
      result.add(
        SpendingCategory.fromJson(data),
      );
    });

    return result;
  }

  Future<List<Spending>> getListSpending({
    int? start,
    int? end,
  }) async {
    List<Spending> listSpendingRequest = [];
    QuerySnapshot? querySnapshot = await firestoreService.getCollectionByUser(
      _collectionSpending,
      start: start,
      end: end,
      listOrderBy: [
        FirestoreOrderByDesending('indexFull'),
      ],
    );
    if (querySnapshot == null) return listSpendingRequest;
    querySnapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      data[Constants.id] = element.id;
      listSpendingRequest.add(
        Spending.fromJson(data),
      );
    });

    return listSpendingRequest;
  }

  Future<bool> addSpendingRequest(SpendingRequest spendingRequest) async {
    return await firestoreService.createDocument(
      collectionPath: 'spending_request',
      data: spendingRequest.toJson(),
    );
  }

  Future<bool> updateSpendingRequest(SpendingRequest spendingRequest) async {
    return await firestoreService.updateDocument(
      collectionPath: 'spending_request',
      data: spendingRequest.toJson(),
    );
  }

  Future<bool> updateSpendingRequestByRawJson(Map<String, dynamic> json) async {
    return await firestoreService.updateDocument(
      collectionPath: 'spending_request',
      data: json,
    );
  }
}
