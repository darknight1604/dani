import 'package:alpha/core/repositories/remote/firestore_repository.dart';
import 'package:alpha/features/spending/models/spending_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpendingService {
  final FirestoreRepository firestoreRepository;

  SpendingService(this.firestoreRepository);

  List<SpendingCategory> result = [];
  
  Future<List<SpendingCategory>> getListSpendingCategory() async {
    if (result.isNotEmpty) return result;

    QuerySnapshot querySnapshot =
        await firestoreRepository.getCollection('spending_category');
    querySnapshot.docs.forEach((element) {
      result.add(
        SpendingCategory.fromJson(
          {
            'id': element.id,
            'name': element['name'],
            'description': element['description'],
          },
        ),
      );
    });

    return result;
  }
}
