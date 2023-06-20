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

  Future<List<SpendingCategory>> getListSpendingCategory() async {
    QuerySnapshot querySnapshot =
        await firestoreService.getCollection(_collectionName);
    return querySnapshot.docs.map((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      data[Constants.id] = element.id;
      return SpendingCategory.fromJson(data);
    }).toList();
  }

  Future<List<Spending>> getListSpending() async {
    List<Spending> listSpendingRequest = [];
    QuerySnapshot? querySnapshot = await firestoreService.getCollectionByUser(
      _collectionSpending,
      listOrderBy: [
        FirestoreOrderByDesending(Constants.createdDate),
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
