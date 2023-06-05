import 'package:alpha/core/repositories/remote/firestore_repository.dart';
import 'package:alpha/features/spending/models/spending_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/spending_request.dart';

class SpendingService {
  final FirestoreRepository firestoreRepository;

  SpendingService(this.firestoreRepository);

  List<SpendingCategory> result = [];

  final String _collectionName = 'spending_category';

  Future<List<SpendingCategory>> getListSpendingCategory() async {
    if (result.isNotEmpty) return result;

    QuerySnapshot querySnapshot =
        await firestoreRepository.getCollection(_collectionName);
    querySnapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      data['id'] = element.id;
      result.add(
        SpendingCategory.fromJson(data),
      );
    });

    return result;
  }

  Future<bool> addSpendingRequest(SpendingRequest spendingRequest) async {
    return await firestoreRepository.createDocument(
      collectionPath: 'spending_request',
      data: spendingRequest.toJson(),
    );
  }
}
