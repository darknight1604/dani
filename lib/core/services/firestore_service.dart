import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dani/core/constants.dart';
import 'package:dani/core/repositories/remote/firestore_repository.dart';
import 'package:dani/core/services/local_service.dart';

import '../../features/login/domains/models/user.dart';
import '../utils/firestore/firestore_order_by.dart';
import '../utils/firestore/firestore_query.dart';

class FirestoreService {
  final FirestoreRepository firestoreRepository;
  final LocalService localService;

  FirestoreService(
    this.firestoreRepository,
    this.localService,
  );

  Future<QuerySnapshot> getCollection(
    String collectionPath, {
    List<FirestoreQuery>? queries,
  }) async {
    return await firestoreRepository.getCollection(
      collectionPath,
      queries: queries,
    );
  }

  Future<QuerySnapshot?> getCollectionByUser(
    String collectionPath, {
    List<FirestoreOrderBy>? listOrderBy,
  }) async {
    User? user = await localService.getUser();
    if (user == null) return null;
    return await firestoreRepository.getCollection(
      collectionPath,
      queries: [
        FirestoreQueryEqualTo(
          Constants.userEmail,
          [
            user.email ?? '',
          ],
        ),
      ],
      listOrderBy: listOrderBy,
    );
  }

  Future<bool> createDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    User? user = await localService.getUser();
    if (user == null) return false;
    Map<String, dynamic> payload = data;
    payload[Constants.userEmail] = user.email;
    return firestoreRepository.createDocument(
      collectionPath: collectionPath,
      data: payload,
    );
  }
}
